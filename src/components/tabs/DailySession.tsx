import { useState, useRef } from 'react'
import { supabase } from '../../lib/supabase'
import { DOMAIN_COLORS, DOMAIN_LABELS } from '../../data/vocab'
import { useVocabTerms } from '../../hooks/useVocabTerms'
import { evaluateScenario } from '../../lib/claude'

interface Props { userId: string }

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
    'You see a static fault — butt wink — in the bottom of an athlete\'s squat. How do you cue a correction?',
    'Three athletes in your class each have a different fault on their pull-ups. How do you prioritize your coaching time?',
    'An athlete gets defensive when you offer a correction. How do you handle the coaching moment?',
  ],
  D5: [
    'A 62-year-old masters athlete insists on doing the Rx weight. They have a false positive belief about their capacity. How do you handle it?',
    'A 9-year-old in your kids class is being disruptive. Walk through your behavior management approach.',
    'A coach on your staff is not cueing the points of performance consistently. How do you address it?',
    'A pregnant athlete in her second trimester wants to continue training. What modifications and considerations apply?',
    'You have an adaptive athlete with limited lower body mobility joining your class. How do you integrate them?',
  ],
  D6: [
    'An athlete asks for nutrition advice for weight loss. What can you say within your scope of practice?',
    'An athlete mentions they have been eating very low carb and their performance has dropped. What do you discuss?',
    'A youth athlete\'s parent asks about the Zone Diet for their 12-year-old. How do you respond?',
    'An athlete is chronically fatigued and sleeping poorly. How do you approach the lifestyle conversation?',
    'An athlete asks about supplementation to improve performance. What is your role and what do you say?',
  ],
  D7: [
    'An athlete asks you to write them a personalized strength program for $150/month. Is this within your scope of practice as a CCFT?',
    'You witness a fellow coach behaving inappropriately toward an athlete. What is your obligation under the Standards of Professional Practice?',
    'Your CCFT expires in 30 days and you have not completed your CEUs. Walk through your options.',
    'A client at a non-affiliated gym asks you to coach them privately. What professional and ethical considerations apply?',
    'An athlete posts a negative review of your coaching online. How do you respond in a way consistent with CrossFit\'s professional standards?',
  ],
}

type Step = 'domain' | 'scenario' | 'evaluating' | 'concepts' | 'reinforce' | 'grading' | 'complete'

export default function DailySession({ userId }: Props) {
  const { terms } = useVocabTerms()
  const [domain, setDomain] = useState<string | null>(null)
  const [scenario, setScenario] = useState('')
  const [step, setStep] = useState<Step>('domain')

  // Part 1 — scenario
  const [part1Response, setPart1Response] = useState('')
  const [part1Feedback, setPart1Feedback] = useState('')
  const [part1Score, setPart1Score] = useState(0)
  const [keyConcepts, setKeyConcepts] = useState<string[]>([])
  const [evaluating1, setEvaluating1] = useState(false)
  const [error1, setError1] = useState('')

  // Part 2 — concepts
  const [conceptStatus, setConceptStatus] = useState<Record<string, 'known' | 'review'>>({})

  // Part 3 — reinforce
  const [reinforceQ, setReinforceQ] = useState('')
  const [part3Response, setPart3Response] = useState('')
  const [part3Feedback, setPart3Feedback] = useState('')
  const [part3Score, setPart3Score] = useState(0)
  const [grading, setGrading] = useState(false)
  const [error3, setError3] = useState('')

  const startTime = useRef<number>(Date.now())

  function pickDomain(d: string) {
    const pool = SCENARIOS[d] ?? []
    const picked = pool[Math.floor(Math.random() * pool.length)]
    setDomain(d)
    setScenario(picked)
    setStep('scenario')
    startTime.current = Date.now()
  }

  async function submitScenario() {
    if (!domain || !part1Response.trim()) return
    setEvaluating1(true)
    setError1('')
    try {
      const result = await evaluateScenario(domain, scenario, part1Response)
      setPart1Feedback(result.feedback)
      setPart1Score(result.score ?? 3)
      setKeyConcepts(result.key_concepts ?? [])

      // Build reinforce question from key concepts
      if (result.key_concepts?.length > 0) {
        setReinforceQ(`Based on this scenario, define "${result.key_concepts[0]}" in your own words and explain how it applies to your answer.`)
      } else {
        setReinforceQ('What is one thing you would do differently based on this feedback?')
      }

      setStep('concepts')
    } catch (err) {
      setError1(err instanceof Error ? err.message : String(err))
    } finally {
      setEvaluating1(false)
    }
  }

  function markConcept(concept: string, status: 'known' | 'review') {
    setConceptStatus(prev => ({ ...prev, [concept]: status }))
  }

  function allConceptsMarked() {
    if (keyConcepts.length === 0) return true
    return keyConcepts.every(c => conceptStatus[c] != null)
  }

  async function submitReinforce() {
    if (!domain || !part3Response.trim()) return
    setGrading(true)
    setError3('')
    try {
      const result = await evaluateScenario(domain, reinforceQ, part3Response)
      setPart3Feedback(result.feedback)
      setPart3Score(result.score ?? 3)
      setStep('complete')

      // Save session
      const finalScore = Math.round((part1Score + (result.score ?? 3)) / 2)
      const duration = Math.round((Date.now() - startTime.current) / 1000)
      await supabase.from('study_sessions').insert({
        user_id: userId,
        domain,
        part1_term: keyConcepts[0] ?? '',
        part2_term: keyConcepts[1] ?? '',
        part2_response: part1Response,
        part3_scenario: scenario,
        part3_response: part3Response,
        duration_secs: duration,
        claude_score: finalScore,
        session_type: 'daily',
      })
    } catch (err) {
      setError3(err instanceof Error ? err.message : String(err))
    } finally {
      setGrading(false)
    }
  }

  function reset() {
    setDomain(null)
    setScenario('')
    setStep('domain')
    setPart1Response('')
    setPart1Feedback('')
    setPart1Score(0)
    setKeyConcepts([])
    setConceptStatus({})
    setReinforceQ('')
    setPart3Response('')
    setPart3Feedback('')
    setPart3Score(0)
    setError1('')
    setError3('')
  }

  const scoreColor = (s: number) => s >= 4 ? '#34C759' : s >= 3 ? '#FF9500' : '#c41e3a'

  // ─── Domain picker ────────────────────────────────────────────────────────
  if (step === 'domain') {
    return (
      <div className="space-y-4">
        <div className="bg-[#111] border border-white/5 rounded-xl p-5">
          <h2 className="text-white font-semibold mb-1">Daily Session</h2>
          <p className="text-[#666] text-sm">Scenario-first. You'll answer cold, then Claude surfaces the concepts in play.</p>
        </div>
        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-2">
          <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase mb-3">Choose Domain</div>
          {['D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7'].map(d => (
            <button
              key={d}
              onClick={() => pickDomain(d)}
              className="w-full flex items-center gap-3 bg-[#0a0a0a] hover:bg-[#141414] border border-white/5 hover:border-white/10 rounded-lg px-4 py-3 transition-colors text-left"
            >
              <span className="text-xs font-bold w-6" style={{ color: DOMAIN_COLORS[d] }}>{d}</span>
              <span className="text-[#a4a4a4] text-sm">{DOMAIN_LABELS[d]}</span>
            </button>
          ))}
        </div>
      </div>
    )
  }

  // ─── Part 1: Scenario (cold) ──────────────────────────────────────────────
  if (step === 'scenario') {
    return (
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <span className="text-xs font-bold" style={{ color: DOMAIN_COLORS[domain!] }}>{domain}</span>
            <span className="text-[#555] text-xs">·</span>
            <span className="text-[#555] text-xs">Step 1 of 3</span>
          </div>
          <button onClick={reset} className="text-[#555] hover:text-white text-xs transition-colors">← Back</button>
        </div>

        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-4">
          <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Coaching Scenario</div>
          <div className="bg-[#0a0a0a] border-l-4 rounded-r-lg p-4" style={{ borderColor: DOMAIN_COLORS[domain!] }}>
            <p className="text-[#e8e8e8] text-sm leading-relaxed">{scenario}</p>
          </div>
          <p className="text-[#555] text-xs">Answer cold — don't look anything up. Think through what you'd actually do.</p>
        </div>

        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-3">
          <label className="block text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Your Response</label>
          <textarea
            value={part1Response}
            onChange={e => { setPart1Response(e.target.value); setError1('') }}
            placeholder="What would you do?"
            className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-4 py-3 text-white text-sm placeholder-[#444] focus:outline-none focus:border-[#003566] transition-colors resize-none"
            rows={6}
          />
          {error1 && <p className="text-[#c41e3a] text-xs">{error1}</p>}
          <div className="flex justify-end">
            <button
              onClick={submitScenario}
              disabled={!part1Response.trim() || evaluating1}
              className="bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-6 py-3 rounded-lg transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
            >
              {evaluating1 ? 'Evaluating...' : 'Get Feedback →'}
            </button>
          </div>
        </div>
      </div>
    )
  }

  // ─── Part 2: Concepts ─────────────────────────────────────────────────────
  if (step === 'concepts') {
    const termMap = Object.fromEntries(terms.map(t => [t.term.toLowerCase(), t]))
    return (
      <div className="space-y-4">
        <div className="flex items-center gap-2">
          <span className="text-xs font-bold" style={{ color: DOMAIN_COLORS[domain!] }}>{domain}</span>
          <span className="text-[#555] text-xs">·</span>
          <span className="text-[#555] text-xs">Step 2 of 3</span>
        </div>

        {/* Score + feedback */}
        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-3">
          <div className="flex items-center justify-between">
            <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Claude's Evaluation</div>
            <div className="flex items-center gap-1.5">
              {[1,2,3,4,5].map(n => (
                <div
                  key={n}
                  className="w-2 h-2 rounded-full"
                  style={{ backgroundColor: n <= part1Score ? scoreColor(part1Score) : '#1a1a1a' }}
                />
              ))}
              <span className="text-xs font-semibold ml-1" style={{ color: scoreColor(part1Score) }}>{part1Score}/5</span>
            </div>
          </div>
          <p className="text-[#e8e8e8] text-sm leading-relaxed">{part1Feedback}</p>
        </div>

        {/* Key concepts */}
        {keyConcepts.length > 0 && (
          <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-3">
            <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Concepts in Play</div>
            <p className="text-[#555] text-xs">These are the framework concepts that applied to this scenario. Mark each one.</p>
            <div className="space-y-3">
              {keyConcepts.map(concept => {
                const match = termMap[concept.toLowerCase()]
                const status = conceptStatus[concept]
                return (
                  <div key={concept} className="bg-[#0a0a0a] border border-white/5 rounded-lg p-4 space-y-2">
                    <div className="flex items-start justify-between gap-2">
                      <div>
                        <div className="text-white text-sm font-semibold">{concept}</div>
                        {match && <p className="text-[#666] text-xs mt-1 leading-relaxed">{match.def}</p>}
                        {!match && <p className="text-[#555] text-xs mt-1 italic">Study this term in your materials</p>}
                      </div>
                    </div>
                    <div className="flex gap-2 pt-1">
                      <button
                        onClick={() => markConcept(concept, 'known')}
                        className={`flex-1 text-xs font-semibold py-1.5 rounded transition-colors ${
                          status === 'known'
                            ? 'bg-[#34C759]/20 text-[#34C759] border border-[#34C759]/30'
                            : 'bg-[#111] text-[#555] border border-white/5 hover:text-white'
                        }`}
                      >
                        Got it
                      </button>
                      <button
                        onClick={() => markConcept(concept, 'review')}
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

  // ─── Part 3: Reinforce ────────────────────────────────────────────────────
  if (step === 'reinforce') {
    return (
      <div className="space-y-4">
        <div className="flex items-center gap-2">
          <span className="text-xs font-bold" style={{ color: DOMAIN_COLORS[domain!] }}>{domain}</span>
          <span className="text-[#555] text-xs">·</span>
          <span className="text-[#555] text-xs">Step 3 of 3</span>
        </div>

        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-4">
          <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Reinforce</div>
          <div className="bg-[#0a0a0a] border-l-4 border-[#003566] rounded-r-lg p-4">
            <p className="text-[#e8e8e8] text-sm leading-relaxed">{reinforceQ}</p>
          </div>

          <textarea
            value={part3Response}
            onChange={e => { setPart3Response(e.target.value); setError3('') }}
            placeholder="Your answer..."
            className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-4 py-3 text-white text-sm placeholder-[#444] focus:outline-none focus:border-[#003566] transition-colors resize-none"
            rows={5}
          />
          {error3 && <p className="text-[#c41e3a] text-xs">{error3}</p>}
          <div className="flex justify-end">
            <button
              onClick={submitReinforce}
              disabled={!part3Response.trim() || grading}
              className="bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-6 py-3 rounded-lg transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
            >
              {grading ? 'Scoring...' : 'Complete Session →'}
            </button>
          </div>
        </div>
      </div>
    )
  }

  // ─── Complete ─────────────────────────────────────────────────────────────
  if (step === 'complete') {
    const finalScore = Math.round((part1Score + part3Score) / 2)
    return (
      <div className="space-y-4">
        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-3">
          <div className="flex items-center justify-between">
            <div className="text-white font-semibold">Session Complete</div>
            <div className="flex items-center gap-1.5">
              {[1,2,3,4,5].map(n => (
                <div key={n} className="w-2.5 h-2.5 rounded-full" style={{ backgroundColor: n <= finalScore ? scoreColor(finalScore) : '#1a1a1a' }} />
              ))}
              <span className="text-xs font-bold ml-1" style={{ color: scoreColor(finalScore) }}>{finalScore}/5</span>
            </div>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-xs font-bold" style={{ color: DOMAIN_COLORS[domain!] }}>{domain}</span>
            <span className="text-[#555] text-xs">·</span>
            <span className="text-[#555] text-xs">{DOMAIN_LABELS[domain!]}</span>
          </div>
        </div>

        {part3Feedback && (
          <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-2">
            <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Final Feedback</div>
            <p className="text-[#e8e8e8] text-sm leading-relaxed">{part3Feedback}</p>
          </div>
        )}

        {Object.values(conceptStatus).includes('review') && (
          <div className="bg-[#FF9500]/10 border border-[#FF9500]/20 rounded-xl p-4">
            <div className="text-[#FF9500] text-xs font-semibold tracking-widest uppercase mb-2">Review These</div>
            <div className="flex flex-wrap gap-2">
              {keyConcepts.filter(c => conceptStatus[c] === 'review').map(c => (
                <span key={c} className="bg-[#0a0a0a] text-[#a4a4a4] text-xs px-2 py-1 rounded border border-white/5">{c}</span>
              ))}
            </div>
          </div>
        )}

        <div className="grid grid-cols-2 gap-3">
          <button
            onClick={reset}
            className="bg-[#1a1a1a] hover:bg-[#222] border border-white/10 text-[#a4a4a4] hover:text-white text-xs font-semibold tracking-[2px] uppercase px-4 py-3 rounded-xl transition-colors"
          >
            New Session
          </button>
          <button
            onClick={() => pickDomain(domain!)}
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
