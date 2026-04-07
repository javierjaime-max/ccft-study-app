import { useState, useEffect, useRef } from 'react'
import { supabase } from '../../lib/supabase'
import { DOMAIN_COLORS, DOMAIN_LABELS } from '../../data/vocab'
import { DOCUMENTS } from '../../data/documents'
import { useVocabTerms } from '../../hooks/useVocabTerms'
import {
  evaluateScenario,
  generateFaultScenario,
  evaluateFaultResponse,
} from '../../lib/claude'
import type { ScenarioEvaluation, FaultScenario, FaultEvaluation } from '../../lib/claude'
import type { VocabTerm } from '../../data/vocab'

interface Props {
  userId: string
}

type Step =
  | 'domain'
  | 'reading'
  | 'flashcards'
  | 'scenario'
  | 'concepts'
  | 'reinforce'
  | 'fault-loading'
  | 'fault-identify'
  | 'fault-result'
  | 'complete'

const DOMAINS = ['D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7']

const DOMAINS_WITHOUT_FAULT = ['D6', 'D7']

const MOVEMENTS: Record<string, string[]> = {
  D1: ['Air Squat', 'Push-up', 'Deadlift', 'Overhead Press'],
  D2: ['Back Squat', 'Deadlift', 'Pull-up', 'Thruster'],
  D3: ['Air Squat', 'Front Squat', 'Overhead Squat', 'Deadlift', 'Power Clean'],
  D4: ['Power Clean', 'Power Snatch', 'Thruster', 'Back Squat', 'Muscle-up'],
  D5: ['Air Squat', 'Deadlift', 'Push-up', 'Ring Row'],
  D6: [],
  D7: [],
}

const SCENARIOS: Record<string, string[]> = {
  D1: [
    'An athlete arrives and mentions they had knee surgery 6 months ago. They say they feel fine. How do you screen them before class?',
    'A new athlete has high blood pressure and is on medication. What is your process before they join their first class?',
    'An athlete collapses during a workout. Walk through your immediate response.',
    'A 55-year-old with no fitness history wants to start CrossFit. How do you assess their readiness and structure their first weeks?',
    'An athlete discloses a herniated disc from two years ago. They have been cleared by a physician. How do you proceed?',
  ],
  D2: [
    'Your 5am class has 3 beginners and 5 experienced athletes. How do you scale the programming to serve both groups?',
    'You notice your programming has been heavily biased toward pushing movements for 3 weeks. What do you do?',
    'An athlete asks why you scaled their workout. How do you explain the acute:chronic load ratio in plain language?',
    'You are programming for a group of athletes training 5 days per week. How do you structure recovery into the week?',
    'An athlete has plateaued on their strength for 3 months. What programming adjustments do you consider?',
  ],
  D3: [
    'A new athlete cannot perform a squat to depth. Walk through how you would teach the air squat from scratch.',
    'You are teaching the deadlift to a class of 8. How do you structure the demo, cues, and corrections?',
    'An experienced athlete has developed a bad habit with their snatch. How do you correct it without damaging their confidence?',
    'A coach asks you to explain how you teach the kip to a beginner athlete. Walk through your progression.',
    'You are introducing the thruster to athletes who know the front squat and press separately. What is your teaching sequence?',
  ],
  D4: [
    'During a workout you spot an athlete with a muted hip on their cleans. What do you say and when?',
    'An athlete is going too heavy and their form is breaking down. How do you intervene in the middle of an AMRAP?',
    "You see a static fault — butt wink — in the bottom of an athlete's squat. How do you cue a correction?",
    'Three athletes in your class each have a different fault on their pull-ups. How do you prioritize your coaching time?',
    'An athlete gets defensive when you offer a correction. How do you handle the coaching moment?',
  ],
  D5: [
    "A 62-year-old masters athlete insists on doing the Rx weight. They have a false positive belief about their capacity. How do you handle it?",
    'A 9-year-old in your kids class is being disruptive. Walk through your behavior management approach.',
    'A coach on your staff is not cueing the points of performance consistently. How do you address it?',
    'A pregnant athlete in her second trimester wants to continue training. What modifications and considerations apply?',
    'You have an adaptive athlete with limited lower body mobility joining your class. How do you integrate them?',
  ],
  D6: [
    'An athlete asks for nutrition advice for weight loss. What can you say within your scope of practice?',
    'An athlete mentions they have been eating very low carb and their performance has dropped. What do you discuss?',
    "A youth athlete's parent asks about the Zone Diet for their 12-year-old. How do you respond?",
    'An athlete is chronically fatigued and sleeping poorly. How do you approach the lifestyle conversation?',
    'An athlete asks about supplementation to improve performance. What is your role and what do you say?',
  ],
  D7: [
    'An athlete asks you to write them a personalized strength program for $150/month. Is this within your scope of practice as a CCFT?',
    'You witness a fellow coach behaving inappropriately toward an athlete. What is your obligation under the Standards of Professional Practice?',
    'Your CCFT expires in 30 days and you have not completed your CEUs. Walk through your options.',
    'A client at a non-affiliated gym asks you to coach them privately. What professional and ethical considerations apply?',
    "An athlete posts a negative review of your coaching online. How do you respond in a way consistent with CrossFit's professional standards?",
  ],
}

function pickRandom<T>(arr: T[]): T {
  return arr[Math.floor(Math.random() * arr.length)]
}

function scoreColor(s: number): string {
  if (s >= 4) return '#34C759'
  if (s >= 3) return '#FF9500'
  return '#c41e3a'
}

function selectFlashcards(
  terms: VocabTerm[],
  domain: string,
  progressMap: Record<string, string>
): VocabTerm[] {
  const domainTerms = terms.filter(t => t.domains.includes(domain))
  const unseen = domainTerms.filter(t => !progressMap[t.term] || progressMap[t.term] === 'unseen')
  const learning = domainTerms.filter(t => progressMap[t.term] === 'learning')
  const rest = domainTerms.filter(
    t => progressMap[t.term] && progressMap[t.term] !== 'unseen' && progressMap[t.term] !== 'learning'
  )
  const pool = [...unseen, ...learning, ...rest]
  return pool.slice(0, 3)
}

// ─── Step indicator ───────────────────────────────────────────────────────────

interface StepIndicatorProps {
  current: number
  total: number
  label: string
  domain: string
}

function StepIndicator({ current, total, label, domain }: StepIndicatorProps) {
  return (
    <div className="flex items-center gap-2">
      <span className="text-xs font-bold" style={{ color: DOMAIN_COLORS[domain] }}>{domain}</span>
      <span className="text-[#333] text-xs">·</span>
      <span className="text-[#555] text-xs">Step {current} of {total} — {label}</span>
    </div>
  )
}

// ─── Score dots ───────────────────────────────────────────────────────────────

function ScoreDots({ score, size = 'sm' }: { score: number; size?: 'sm' | 'md' }) {
  const dotClass = size === 'md' ? 'w-2.5 h-2.5' : 'w-2 h-2'
  const color = scoreColor(score)
  return (
    <div className="flex items-center gap-1.5">
      {[1, 2, 3, 4, 5].map(n => (
        <div
          key={n}
          className={`${dotClass} rounded-full`}
          style={{ backgroundColor: n <= score ? color : '#1a1a1a' }}
        />
      ))}
      <span className="text-xs font-semibold ml-1" style={{ color }}>{score}/5</span>
    </div>
  )
}

// ─── Main component ───────────────────────────────────────────────────────────

export default function Today({ userId }: Props) {
  const { terms, loading: termsLoading } = useVocabTerms()

  // Navigation
  const [step, setStep] = useState<Step>('domain')
  const [domain, setDomain] = useState<string | null>(null)
  const [showDomainPicker, setShowDomainPicker] = useState(false)

  // Domain suggestion
  const [suggestedDomain, setSuggestedDomain] = useState<string | null>(null)
  const [loadingSuggestion, setLoadingSuggestion] = useState(true)

  // Reading
  const [readDoc, setReadDoc] = useState<{ id: string; title: string; url: string } | null>(null)

  // Flashcards
  const [flashcards, setFlashcards] = useState<VocabTerm[]>([])
  const [flashIndex, setFlashIndex] = useState(0)
  const [flipped, setFlipped] = useState(false)
  const [flashResults, setFlashResults] = useState<Record<string, 'known' | 'review'>>({})

  // Scenario
  const [scenario, setScenario] = useState('')
  const [scenarioResponse, setScenarioResponse] = useState('')
  const [scenarioEval, setScenarioEval] = useState<ScenarioEvaluation | null>(null)
  const [evaluatingScenario, setEvaluatingScenario] = useState(false)
  const [scenarioError, setScenarioError] = useState('')

  // Concepts
  const [conceptStatus, setConceptStatus] = useState<Record<string, 'known' | 'review'>>({})

  // Reinforce
  const [reinforceQ, setReinforceQ] = useState('')
  const [reinforceResponse, setReinforceResponse] = useState('')
  const [reinforceEval, setReinforceEval] = useState<ScenarioEvaluation | null>(null)
  const [gradingReinforce, setGradingReinforce] = useState(false)
  const [reinforceError, setReinforceError] = useState('')

  // Fault
  const [faultMovement, setFaultMovement] = useState('')
  const [faultScenario, setFaultScenario] = useState<FaultScenario | null>(null)
  const [faultLoadError, setFaultLoadError] = useState('')
  const [selectedFault, setSelectedFault] = useState('')
  const [faultCue, setFaultCue] = useState('')
  const [faultEval, setFaultEval] = useState<FaultEvaluation | null>(null)
  const [evaluatingFault, setEvaluatingFault] = useState(false)
  const [faultError, setFaultError] = useState('')

  const startTime = useRef<number>(Date.now())

  // ─── Load domain suggestion on mount ───────────────────────────────────────

  useEffect(() => {
    async function loadSuggestion() {
      setLoadingSuggestion(true)
      try {
        const { data: sessions } = await supabase
          .from('study_sessions')
          .select('domain, claude_score')
          .eq('user_id', userId)
          .order('completed_at', { ascending: false })
          .limit(50)

        const scores: Record<string, number[]> = {}
        for (const s of sessions ?? []) {
          if (!scores[s.domain]) scores[s.domain] = []
          scores[s.domain].push(s.claude_score ?? 0)
        }

        const avgScores: Record<string, number> = {}
        for (const [d, vals] of Object.entries(scores)) {
          avgScores[d] = vals.reduce((a, b) => a + b, 0) / vals.length
        }

        // First: domain with no sessions
        const noSessions = DOMAINS.find(d => !avgScores[d])
        if (noSessions) {
          setSuggestedDomain(noSessions)
          return
        }

        // Fallback: lowest avg score
        const lowest = DOMAINS.reduce((a, b) =>
          (avgScores[a] ?? 99) <= (avgScores[b] ?? 99) ? a : b
        )
        setSuggestedDomain(lowest)
      } catch {
        setSuggestedDomain('D1')
      } finally {
        setLoadingSuggestion(false)
      }
    }

    loadSuggestion()
  }, [userId])

  // ─── Helpers ───────────────────────────────────────────────────────────────

  const totalSteps = domain && !DOMAINS_WITHOUT_FAULT.includes(domain) ? 4 : 3


  async function startDomain(d: string) {
    setDomain(d)
    setShowDomainPicker(false)
    startTime.current = Date.now()

    // Load reading doc
    const { data: readIds } = await supabase
      .from('reading_progress')
      .select('doc_id')
      .eq('user_id', userId)

    const readSet = new Set((readIds ?? []).map((r: { doc_id: string }) => r.doc_id))
    const domainDocs = DOCUMENTS.filter(doc => doc.domain === d)
    const unread = domainDocs.find(doc => !readSet.has(doc.id))
    const doc = unread ?? domainDocs[0] ?? null

    if (doc) {
      setReadDoc({ id: doc.id, title: doc.title, url: doc.url })
    } else {
      setReadDoc(null)
    }

    // Pick scenario
    const pool = SCENARIOS[d] ?? []
    setScenario(pickRandom(pool))

    setStep('reading')
  }

  async function afterReading() {
    if (!domain || !readDoc) return

    // Mark read
    await supabase.from('reading_progress').upsert(
      { user_id: userId, doc_id: readDoc.id, read_at: new Date().toISOString() },
      { onConflict: 'user_id,doc_id' }
    )

    // Load flashcard progress
    const { data: progress } = await supabase
      .from('flashcard_progress')
      .select('term, status')
      .eq('user_id', userId)

    const progressMap: Record<string, string> = {}
    for (const p of progress ?? []) {
      progressMap[p.term] = p.status
    }

    const cards = selectFlashcards(terms, domain, progressMap)
    setFlashcards(cards)
    setFlashIndex(0)
    setFlipped(false)
    setFlashResults({})
    setStep('flashcards')
  }

  async function rateFlashcard(result: 'known' | 'review') {
    if (!domain) return
    const card = flashcards[flashIndex]
    if (!card) return

    setFlashResults(prev => ({ ...prev, [card.term]: result }))

    // Upsert progress
    const status = result === 'known' ? 'known' : 'learning'
    await supabase.from('flashcard_progress').upsert(
      { user_id: userId, term: card.term, status, last_seen: new Date().toISOString() },
      { onConflict: 'user_id,term' }
    )

    if (flashIndex < flashcards.length - 1) {
      setFlashIndex(flashIndex + 1)
      setFlipped(false)
    } else {
      // All flashcards done — go to scenario
      setStep('scenario')
    }
  }

  async function submitScenario() {
    if (!domain || !scenarioResponse.trim()) return
    setEvaluatingScenario(true)
    setScenarioError('')
    try {
      const result = await evaluateScenario(domain, scenario, scenarioResponse)
      setScenarioEval(result)
      setConceptStatus({})

      if (result.key_concepts?.length > 0) {
        setReinforceQ(
          `Based on this scenario, define "${result.key_concepts[0]}" in your own words and explain how it applies to your answer.`
        )
      } else {
        setReinforceQ('What is one thing you would do differently based on this feedback?')
      }

      setStep('concepts')
    } catch (err) {
      setScenarioError(err instanceof Error ? err.message : String(err))
    } finally {
      setEvaluatingScenario(false)
    }
  }

  function allConceptsMarked(): boolean {
    if (!scenarioEval) return true
    const concepts = scenarioEval.key_concepts ?? []
    if (concepts.length === 0) return true
    return concepts.every(c => conceptStatus[c] != null)
  }

  async function submitReinforce() {
    if (!domain || !reinforceResponse.trim()) return
    setGradingReinforce(true)
    setReinforceError('')
    try {
      const result = await evaluateScenario(domain, reinforceQ, reinforceResponse)
      setReinforceEval(result)

      const hasFault = !DOMAINS_WITHOUT_FAULT.includes(domain)
      if (hasFault) {
        const movements = MOVEMENTS[domain] ?? []
        const movement = pickRandom(movements)
        setFaultMovement(movement)
        setStep('fault-loading')
        await loadFaultScenario(domain, movement)
      } else {
        await saveSession(result)
        setStep('complete')
      }
    } catch (err) {
      setReinforceError(err instanceof Error ? err.message : String(err))
    } finally {
      setGradingReinforce(false)
    }
  }

  async function loadFaultScenario(d: string, movement: string) {
    setFaultLoadError('')
    try {
      const result = await generateFaultScenario(d, movement)
      setFaultScenario(result)
      setSelectedFault('')
      setFaultCue('')
      setFaultEval(null)
      setStep('fault-identify')
    } catch (err) {
      setFaultLoadError(err instanceof Error ? err.message : String(err))
      setStep('fault-identify')
    }
  }

  async function submitFault() {
    if (!faultScenario || !selectedFault || !faultCue.trim()) return
    setEvaluatingFault(true)
    setFaultError('')
    try {
      const result = await evaluateFaultResponse(
        faultMovement,
        faultScenario.athlete_description,
        faultScenario.fault_options,
        selectedFault,
        faultCue
      )
      setFaultEval(result)

      // Save fault attempt
      await supabase.from('fault_finder_attempts').insert({
        user_id: userId,
        domain,
        movement: faultMovement,
        scenario: faultScenario.athlete_description,
        selected_fault: selectedFault,
        cue_response: faultCue,
        correct: result.correct_selection,
        claude_score: result.score,
        feedback: result.feedback,
        cue_assessment: result.cue_assessment,
      })

      setStep('fault-result')
    } catch (err) {
      setFaultError(err instanceof Error ? err.message : String(err))
    } finally {
      setEvaluatingFault(false)
    }
  }

  async function afterFaultResult() {
    await saveSession(reinforceEval)
    setStep('complete')
  }

  async function saveSession(lastEval: ScenarioEvaluation | null) {
    if (!domain) return
    const s1 = scenarioEval?.score ?? 0
    const s2 = lastEval?.score ?? 0
    const faultScore = faultEval?.score ?? 0
    const hasFault = !DOMAINS_WITHOUT_FAULT.includes(domain)
    const claudeScore = hasFault
      ? Math.round((s1 + s2 + faultScore) / 3)
      : Math.round((s1 + s2) / 2)

    const duration = Math.round((Date.now() - startTime.current) / 1000)

    await supabase.from('study_sessions').insert({
      user_id: userId,
      domain,
      part1_term: scenarioEval?.key_concepts?.[0] ?? '',
      part3_scenario: scenario,
      part3_response: scenarioResponse,
      claude_score: claudeScore,
      session_type: 'guided',
      duration_secs: duration,
    })
  }

  function reset() {
    setStep('domain')
    setDomain(null)
    setShowDomainPicker(false)
    setReadDoc(null)
    setFlashcards([])
    setFlashIndex(0)
    setFlipped(false)
    setFlashResults({})
    setScenario('')
    setScenarioResponse('')
    setScenarioEval(null)
    setEvaluatingScenario(false)
    setScenarioError('')
    setConceptStatus({})
    setReinforceQ('')
    setReinforceResponse('')
    setReinforceEval(null)
    setGradingReinforce(false)
    setReinforceError('')
    setFaultMovement('')
    setFaultScenario(null)
    setFaultLoadError('')
    setSelectedFault('')
    setFaultCue('')
    setFaultEval(null)
    setEvaluatingFault(false)
    setFaultError('')
  }

  // ─── STEP: domain ──────────────────────────────────────────────────────────

  if (step === 'domain') {
    return (
      <div className="space-y-4">
        <div className="bg-[#111] border border-white/5 rounded-xl p-5">
          <h2 className="text-white font-semibold mb-1">Today's Session</h2>
          <p className="text-[#666] text-sm">
            One domain. Reading, flashcards, scenario, and fault drill — all guided. Just go.
          </p>
        </div>

        {/* Suggested domain */}
        {loadingSuggestion ? (
          <div className="bg-[#111] border border-white/5 rounded-xl p-5">
            <div className="text-[#555] text-xs">Loading recommendation...</div>
          </div>
        ) : suggestedDomain && (
          <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-4">
            <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">
              Recommended
            </div>
            <div
              className="flex items-center gap-3 p-4 rounded-xl border"
              style={{ borderColor: `${DOMAIN_COLORS[suggestedDomain]}33`, backgroundColor: `${DOMAIN_COLORS[suggestedDomain]}0d` }}
            >
              <span className="text-xl font-bold" style={{ color: DOMAIN_COLORS[suggestedDomain] }}>
                {suggestedDomain}
              </span>
              <div>
                <div className="text-white text-sm font-semibold">{DOMAIN_LABELS[suggestedDomain]}</div>
                <div className="text-[#555] text-xs mt-0.5">
                  {DOMAINS_WITHOUT_FAULT.includes(suggestedDomain) ? '3 steps — no fault drill' : '4 steps including fault drill'}
                </div>
              </div>
            </div>
            <div className="flex gap-3">
              <button
                onClick={() => startDomain(suggestedDomain)}
                disabled={termsLoading}
                className="flex-1 bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-6 py-3 rounded-lg transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
              >
                {termsLoading ? 'Loading...' : 'Start Session →'}
              </button>
              <button
                onClick={() => setShowDomainPicker(v => !v)}
                className="bg-[#1a1a1a] hover:bg-[#222] border border-white/10 text-[#a4a4a4] hover:text-white text-xs font-semibold tracking-[2px] uppercase px-4 py-3 rounded-lg transition-colors"
              >
                Change
              </button>
            </div>

            {showDomainPicker && (
              <div className="space-y-2 pt-1">
                <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Pick Domain</div>
                {DOMAINS.map(d => (
                  <button
                    key={d}
                    onClick={() => { setSuggestedDomain(d); setShowDomainPicker(false) }}
                    className="w-full flex items-center gap-3 bg-[#0a0a0a] hover:bg-[#141414] border border-white/5 hover:border-white/10 rounded-lg px-4 py-3 transition-colors text-left"
                  >
                    <span className="text-xs font-bold w-6" style={{ color: DOMAIN_COLORS[d] }}>{d}</span>
                    <span className="text-[#a4a4a4] text-sm">{DOMAIN_LABELS[d]}</span>
                    {d === suggestedDomain && (
                      <span className="ml-auto text-[#555] text-xs">selected</span>
                    )}
                  </button>
                ))}
              </div>
            )}
          </div>
        )}
      </div>
    )
  }

  // ─── STEP: reading ─────────────────────────────────────────────────────────

  if (step === 'reading') {
    return (
      <div className="space-y-4">
        <StepIndicator current={1} total={totalSteps} label="Reading" domain={domain!} />

        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-4">
          <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Study Document</div>
          {readDoc ? (
            <>
              <div
                className="border-l-4 pl-4 py-1"
                style={{ borderColor: DOMAIN_COLORS[domain!] }}
              >
                <div className="text-white text-sm font-semibold leading-snug">{readDoc.title}</div>
                <div className="text-[#555] text-xs mt-1">{domain} — {DOMAIN_LABELS[domain!]}</div>
              </div>
              <a
                href={readDoc.url}
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center justify-center gap-2 w-full bg-[#0a0a0a] hover:bg-[#141414] border border-white/10 text-[#a4a4a4] hover:text-white text-xs font-semibold tracking-[2px] uppercase px-4 py-3 rounded-lg transition-colors"
              >
                Open PDF ↗
              </a>
              <p className="text-[#555] text-xs text-center">
                Read through the document, then mark it complete to continue.
              </p>
            </>
          ) : (
            <p className="text-[#666] text-sm">No documents found for this domain.</p>
          )}
        </div>

        <button
          onClick={afterReading}
          className="w-full bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-6 py-3 rounded-lg transition-colors"
        >
          Mark Read & Continue →
        </button>
      </div>
    )
  }

  // ─── STEP: flashcards ──────────────────────────────────────────────────────

  if (step === 'flashcards') {
    const card = flashcards[flashIndex]
    const progress = flashIndex + 1
    const total = flashcards.length

    return (
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <StepIndicator current={2} total={totalSteps} label="Flashcards" domain={domain!} />
          <span className="text-[#555] text-xs">{progress} / {total}</span>
        </div>

        {/* Progress bar */}
        <div className="h-1 bg-[#1a1a1a] rounded-full overflow-hidden">
          <div
            className="h-full rounded-full transition-all"
            style={{
              width: `${(progress / total) * 100}%`,
              backgroundColor: DOMAIN_COLORS[domain!],
            }}
          />
        </div>

        {card ? (
          <div className="space-y-3">
            {/* Card */}
            <button
              onClick={() => setFlipped(v => !v)}
              className="w-full bg-[#111] border border-white/5 rounded-xl p-5 text-left space-y-3 transition-colors hover:border-white/10"
            >
              <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">
                {flipped ? 'Definition' : 'Term'}
              </div>
              {!flipped ? (
                <>
                  <div className="text-white text-lg font-semibold">{card.term}</div>
                  <div className="text-[#555] text-xs">Tap to reveal definition</div>
                </>
              ) : (
                <>
                  <p className="text-[#e8e8e8] text-sm leading-relaxed">{card.def}</p>
                  {card.src && (
                    <div className="text-[#444] text-xs">Source: {card.src}</div>
                  )}
                </>
              )}
            </button>

            {flipped && (
              <div className="grid grid-cols-2 gap-3">
                <button
                  onClick={() => rateFlashcard('review')}
                  className="bg-[#FF9500]/10 hover:bg-[#FF9500]/20 border border-[#FF9500]/20 text-[#FF9500] text-xs font-semibold tracking-[2px] uppercase px-4 py-3 rounded-lg transition-colors"
                >
                  Need Work
                </button>
                <button
                  onClick={() => rateFlashcard('known')}
                  className="bg-[#34C759]/10 hover:bg-[#34C759]/20 border border-[#34C759]/20 text-[#34C759] text-xs font-semibold tracking-[2px] uppercase px-4 py-3 rounded-lg transition-colors"
                >
                  Got It
                </button>
              </div>
            )}

            {!flipped && (
              <p className="text-[#444] text-xs text-center">
                Recall the definition, then flip to check
              </p>
            )}
          </div>
        ) : (
          <div className="bg-[#111] border border-white/5 rounded-xl p-5">
            <p className="text-[#666] text-sm">No flashcards available for this domain.</p>
            <button
              onClick={() => setStep('scenario')}
              className="mt-4 bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-6 py-3 rounded-lg transition-colors"
            >
              Continue →
            </button>
          </div>
        )}
      </div>
    )
  }

  // ─── STEP: scenario ────────────────────────────────────────────────────────

  if (step === 'scenario') {
    return (
      <div className="space-y-4">
        <StepIndicator current={3} total={totalSteps} label="Scenario" domain={domain!} />

        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-4">
          <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Coaching Scenario</div>
          <div
            className="bg-[#0a0a0a] border-l-4 rounded-r-lg p-4"
            style={{ borderColor: DOMAIN_COLORS[domain!] }}
          >
            <p className="text-[#e8e8e8] text-sm leading-relaxed">{scenario}</p>
          </div>
          <p className="text-[#555] text-xs">Answer cold — don't look anything up. Think through what you'd actually do.</p>
        </div>

        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-3">
          <label className="block text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">
            Your Response
          </label>
          <textarea
            value={scenarioResponse}
            onChange={e => { setScenarioResponse(e.target.value); setScenarioError('') }}
            placeholder="What would you do?"
            className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-4 py-3 text-white text-sm placeholder-[#444] focus:outline-none focus:border-[#003566] transition-colors resize-none"
            rows={6}
          />
          {scenarioError && <p className="text-[#c41e3a] text-xs">{scenarioError}</p>}
          <div className="flex justify-end">
            <button
              onClick={submitScenario}
              disabled={!scenarioResponse.trim() || evaluatingScenario}
              className="bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-6 py-3 rounded-lg transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
            >
              {evaluatingScenario ? 'Evaluating...' : 'Get Feedback →'}
            </button>
          </div>
        </div>
      </div>
    )
  }

  // ─── STEP: concepts ────────────────────────────────────────────────────────

  if (step === 'concepts') {
    const termMap = Object.fromEntries(terms.map(t => [t.term.toLowerCase(), t]))
    const concepts = scenarioEval?.key_concepts ?? []

    return (
      <div className="space-y-4">
        <StepIndicator current={3} total={totalSteps} label="Concepts" domain={domain!} />

        {/* Score + feedback */}
        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-3">
          <div className="flex items-center justify-between">
            <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Claude's Evaluation</div>
            <ScoreDots score={scenarioEval?.score ?? 0} />
          </div>
          <p className="text-[#e8e8e8] text-sm leading-relaxed">{scenarioEval?.feedback}</p>
        </div>

        {/* Key concepts */}
        {concepts.length > 0 && (
          <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-3">
            <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Concepts in Play</div>
            <p className="text-[#555] text-xs">Framework concepts that applied to this scenario. Mark each one.</p>
            <div className="space-y-3">
              {concepts.map(concept => {
                const match = termMap[concept.toLowerCase()]
                const status = conceptStatus[concept]
                return (
                  <div key={concept} className="bg-[#0a0a0a] border border-white/5 rounded-lg p-4 space-y-2">
                    <div>
                      <div className="text-white text-sm font-semibold">{concept}</div>
                      {match
                        ? <p className="text-[#666] text-xs mt-1 leading-relaxed">{match.def}</p>
                        : <p className="text-[#555] text-xs mt-1 italic">Study this term in your materials</p>
                      }
                    </div>
                    <div className="flex gap-2 pt-1">
                      <button
                        onClick={() => setConceptStatus(prev => ({ ...prev, [concept]: 'known' }))}
                        className={`flex-1 text-xs font-semibold py-1.5 rounded transition-colors ${
                          status === 'known'
                            ? 'bg-[#34C759]/20 text-[#34C759] border border-[#34C759]/30'
                            : 'bg-[#111] text-[#555] border border-white/5 hover:text-white'
                        }`}
                      >
                        Got it
                      </button>
                      <button
                        onClick={() => setConceptStatus(prev => ({ ...prev, [concept]: 'review' }))}
                        className={`flex-1 text-xs font-semibold py-1.5 rounded transition-colors ${
                          status === 'review'
                            ? 'bg-[#FF9500]/20 text-[#FF9500] border border-[#FF9500]/30'
                            : 'bg-[#111] text-[#555] border border-white/5 hover:text-white'
                        }`}
                      >
                        Need Work
                      </button>
                    </div>
                  </div>
                )
              })}
            </div>
          </div>
        )}

        <div className="flex justify-end">
          <button
            onClick={() => setStep('reinforce')}
            disabled={!allConceptsMarked()}
            className="bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-6 py-3 rounded-lg transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
          >
            Continue →
          </button>
        </div>
      </div>
    )
  }

  // ─── STEP: reinforce ───────────────────────────────────────────────────────

  if (step === 'reinforce') {
    return (
      <div className="space-y-4">
        <StepIndicator current={3} total={totalSteps} label="Reinforce" domain={domain!} />

        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-4">
          <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Reinforce</div>
          <div className="bg-[#0a0a0a] border-l-4 border-[#003566] rounded-r-lg p-4">
            <p className="text-[#e8e8e8] text-sm leading-relaxed">{reinforceQ}</p>
          </div>
          <textarea
            value={reinforceResponse}
            onChange={e => { setReinforceResponse(e.target.value); setReinforceError('') }}
            placeholder="Your answer..."
            className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-4 py-3 text-white text-sm placeholder-[#444] focus:outline-none focus:border-[#003566] transition-colors resize-none"
            rows={5}
          />
          {reinforceError && <p className="text-[#c41e3a] text-xs">{reinforceError}</p>}
          <div className="flex justify-end">
            <button
              onClick={submitReinforce}
              disabled={!reinforceResponse.trim() || gradingReinforce}
              className="bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-6 py-3 rounded-lg transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
            >
              {gradingReinforce
                ? DOMAINS_WITHOUT_FAULT.includes(domain ?? '')
                  ? 'Scoring...'
                  : 'Generating Fault...'
                : DOMAINS_WITHOUT_FAULT.includes(domain ?? '')
                  ? 'Complete Session →'
                  : 'Continue to Fault Drill →'
              }
            </button>
          </div>
        </div>
      </div>
    )
  }

  // ─── STEP: fault-loading ──────────────────────────────────────────────────

  if (step === 'fault-loading') {
    return (
      <div className="space-y-4">
        <StepIndicator current={4} total={totalSteps} label="Fault Drill" domain={domain!} />
        <div className="bg-[#111] border border-white/5 rounded-xl p-5 text-center space-y-3">
          <div className="text-white text-sm font-semibold">{faultMovement}</div>
          <p className="text-[#555] text-xs">Generating fault scenario...</p>
          {faultLoadError && <p className="text-[#c41e3a] text-xs">{faultLoadError}</p>}
        </div>
      </div>
    )
  }

  // ─── STEP: fault-identify ─────────────────────────────────────────────────

  if (step === 'fault-identify') {
    return (
      <div className="space-y-4">
        <StepIndicator current={4} total={totalSteps} label="Fault Drill" domain={domain!} />

        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-4">
          <div className="flex items-center justify-between">
            <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Fault Drill</div>
            <span
              className="text-xs font-bold px-2 py-1 rounded"
              style={{ color: DOMAIN_COLORS[domain!], backgroundColor: `${DOMAIN_COLORS[domain!]}1a` }}
            >
              {faultMovement}
            </span>
          </div>

          {faultScenario ? (
            <>
              <div
                className="bg-[#0a0a0a] border-l-4 rounded-r-lg p-4"
                style={{ borderColor: DOMAIN_COLORS[domain!] }}
              >
                <p className="text-[#e8e8e8] text-sm leading-relaxed">{faultScenario.athlete_description}</p>
              </div>

              {/* Fault selection */}
              <div className="space-y-2">
                <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">
                  Primary Fault
                </div>
                {faultScenario.fault_options.map(opt => (
                  <button
                    key={opt.id}
                    onClick={() => setSelectedFault(opt.id)}
                    className={`w-full flex items-center gap-3 rounded-lg px-4 py-3 text-left text-sm transition-colors border ${
                      selectedFault === opt.id
                        ? 'border-[#003566] bg-[#003566]/20 text-white'
                        : 'border-white/5 bg-[#0a0a0a] text-[#a4a4a4] hover:border-white/10 hover:text-white'
                    }`}
                  >
                    <span className="w-5 h-5 rounded-full border flex items-center justify-center flex-shrink-0" style={{
                      borderColor: selectedFault === opt.id ? '#003566' : '#333',
                      backgroundColor: selectedFault === opt.id ? '#003566' : 'transparent',
                    }}>
                      {selectedFault === opt.id && (
                        <span className="w-2 h-2 rounded-full bg-white" />
                      )}
                    </span>
                    {opt.label}
                  </button>
                ))}
              </div>

              {/* Coaching cue */}
              <div className="space-y-2">
                <label className="block text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">
                  Your Coaching Cue
                </label>
                <textarea
                  value={faultCue}
                  onChange={e => { setFaultCue(e.target.value); setFaultError('') }}
                  placeholder="What would you say to the athlete?"
                  className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-4 py-3 text-white text-sm placeholder-[#444] focus:outline-none focus:border-[#003566] transition-colors resize-none"
                  rows={3}
                />
                {faultError && <p className="text-[#c41e3a] text-xs">{faultError}</p>}
              </div>

              <div className="flex justify-end">
                <button
                  onClick={submitFault}
                  disabled={!selectedFault || !faultCue.trim() || evaluatingFault}
                  className="bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-6 py-3 rounded-lg transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
                >
                  {evaluatingFault ? 'Evaluating...' : 'Submit →'}
                </button>
              </div>
            </>
          ) : (
            <div className="space-y-3">
              <p className="text-[#666] text-sm">
                {faultLoadError ? faultLoadError : 'Could not load fault scenario.'}
              </p>
              <button
                onClick={afterFaultResult}
                className="bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-6 py-3 rounded-lg transition-colors"
              >
                Skip & Complete →
              </button>
            </div>
          )}
        </div>
      </div>
    )
  }

  // ─── STEP: fault-result ───────────────────────────────────────────────────

  if (step === 'fault-result') {
    return (
      <div className="space-y-4">
        <StepIndicator current={4} total={totalSteps} label="Fault Drill" domain={domain!} />

        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-3">
          <div className="flex items-center justify-between">
            <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Fault Evaluation</div>
            {faultEval && <ScoreDots score={faultEval.score} />}
          </div>

          {faultEval && (
            <>
              <div className={`flex items-center gap-2 px-3 py-2 rounded-lg text-xs font-semibold ${
                faultEval.correct_selection
                  ? 'bg-[#34C759]/10 text-[#34C759] border border-[#34C759]/20'
                  : 'bg-[#c41e3a]/10 text-[#c41e3a] border border-[#c41e3a]/20'
              }`}>
                {faultEval.correct_selection ? '✓ Correct fault identified' : '✗ Fault missed'}
              </div>

              <div>
                <div className="text-[#555] text-xs mb-1">Primary fault</div>
                <p className="text-[#e8e8e8] text-sm">{faultEval.primary_fault}</p>
              </div>

              <div>
                <div className="text-[#555] text-xs mb-1">Feedback</div>
                <p className="text-[#e8e8e8] text-sm leading-relaxed">{faultEval.feedback}</p>
              </div>

              <div>
                <div className="text-[#555] text-xs mb-1">Cue assessment</div>
                <p className="text-[#e8e8e8] text-sm leading-relaxed">{faultEval.cue_assessment}</p>
              </div>
            </>
          )}
        </div>

        <button
          onClick={afterFaultResult}
          className="w-full bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-6 py-3 rounded-lg transition-colors"
        >
          Complete Session →
        </button>
      </div>
    )
  }

  // ─── STEP: complete ────────────────────────────────────────────────────────

  if (step === 'complete') {
    const s1 = scenarioEval?.score ?? 0
    const s2 = reinforceEval?.score ?? 0
    const faultScore = faultEval?.score ?? 0
    const hasFault = domain && !DOMAINS_WITHOUT_FAULT.includes(domain) && faultEval != null
    const compositeScore = hasFault
      ? Math.round((s1 + s2 + faultScore) / 3)
      : Math.round((s1 + s2) / 2)

    const reviewConcepts = (scenarioEval?.key_concepts ?? []).filter(
      c => conceptStatus[c] === 'review'
    )

    const flashReview = Object.entries(flashResults)
      .filter(([, v]) => v === 'review')
      .map(([k]) => k)

    return (
      <div className="space-y-4">
        {/* Header */}
        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-3">
          <div className="flex items-center justify-between">
            <div className="text-white font-semibold">Session Complete</div>
            <ScoreDots score={compositeScore} size="md" />
          </div>
          <div className="flex items-center gap-2">
            <span className="text-xs font-bold" style={{ color: DOMAIN_COLORS[domain!] }}>{domain}</span>
            <span className="text-[#333] text-xs">·</span>
            <span className="text-[#555] text-xs">{DOMAIN_LABELS[domain!]}</span>
            <span className="text-[#333] text-xs">·</span>
            <span className="text-[#555] text-xs">
              {totalSteps} steps completed
            </span>
          </div>
        </div>

        {/* Score breakdown */}
        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-3">
          <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Score Breakdown</div>
          <div className="space-y-2">
            <div className="flex items-center justify-between">
              <span className="text-[#666] text-xs">Scenario</span>
              <ScoreDots score={s1} />
            </div>
            <div className="flex items-center justify-between">
              <span className="text-[#666] text-xs">Reinforce</span>
              <ScoreDots score={s2} />
            </div>
            {hasFault && (
              <div className="flex items-center justify-between">
                <span className="text-[#666] text-xs">Fault Drill — {faultMovement}</span>
                <ScoreDots score={faultScore} />
              </div>
            )}
            <div className="border-t border-white/5 pt-2 flex items-center justify-between">
              <span className="text-[#a4a4a4] text-xs font-semibold">Composite</span>
              <ScoreDots score={compositeScore} size="md" />
            </div>
          </div>
        </div>

        {/* Final reinforce feedback */}
        {reinforceEval?.feedback && (
          <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-2">
            <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Final Feedback</div>
            <p className="text-[#e8e8e8] text-sm leading-relaxed">{reinforceEval.feedback}</p>
          </div>
        )}

        {/* Concepts to review */}
        {reviewConcepts.length > 0 && (
          <div className="bg-[#FF9500]/10 border border-[#FF9500]/20 rounded-xl p-4 space-y-2">
            <div className="text-[#FF9500] text-xs font-semibold tracking-widest uppercase">Concepts to Review</div>
            <div className="flex flex-wrap gap-2">
              {reviewConcepts.map(c => (
                <span key={c} className="bg-[#0a0a0a] text-[#a4a4a4] text-xs px-2 py-1 rounded border border-white/5">
                  {c}
                </span>
              ))}
            </div>
          </div>
        )}

        {/* Flashcards to review */}
        {flashReview.length > 0 && (
          <div className="bg-[#1a1a1a] border border-white/5 rounded-xl p-4 space-y-2">
            <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Flashcards to Review</div>
            <div className="flex flex-wrap gap-2">
              {flashReview.map(t => (
                <span key={t} className="bg-[#0a0a0a] text-[#666] text-xs px-2 py-1 rounded border border-white/5">
                  {t}
                </span>
              ))}
            </div>
          </div>
        )}

        {/* Actions */}
        <div className="grid grid-cols-2 gap-3">
          <button
            onClick={reset}
            className="bg-[#1a1a1a] hover:bg-[#222] border border-white/10 text-[#a4a4a4] hover:text-white text-xs font-semibold tracking-[2px] uppercase px-4 py-3 rounded-xl transition-colors"
          >
            New Session
          </button>
          <button
            onClick={() => domain && startDomain(domain)}
            className="bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-4 py-3 rounded-xl transition-colors"
          >
            Same Domain
          </button>
        </div>
      </div>
    )
  }

  return null
}
