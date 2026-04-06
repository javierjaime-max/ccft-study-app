import { useState, useRef } from 'react'
import { supabase } from '../../lib/supabase'
import { DOMAIN_COLORS, DOMAIN_LABELS } from '../../data/vocab'
import type { VocabTerm } from '../../data/vocab'
import { useVocabTerms } from '../../hooks/useVocabTerms'
import { evaluateScenario } from '../../lib/claude'

interface Props { userId: string }

const DOMAINS = ['D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7']

const SCENARIOS: Record<string, string[]> = {
  D1: [
    'An athlete arrives and mentions they had knee surgery 6 months ago. They say they feel fine. How do you screen them before class?',
    'A new athlete has high blood pressure and is on medication. What is your process before they join their first class?',
    'An athlete collapses during a workout. Walk through your immediate response.',
  ],
  D2: [
    'Your 5am class has 3 beginners and 5 experienced athletes. How do you scale the programming to serve both groups?',
    'You notice your programming has been heavily biased toward pushing movements for 3 weeks. What do you do?',
    'An athlete asks why you scaled their workout. How do you explain the acute:chronic load ratio in plain language?',
  ],
  D3: [
    'A new athlete can\'t perform a squat to depth. Walk through how you would teach the air squat from scratch.',
    'You are teaching the deadlift to a class of 8. How do you structure the demo, cues, and corrections?',
    'An experienced athlete has developed a bad habit with their snatch. How do you correct it without damaging their confidence?',
  ],
  D4: [
    'During a workout you spot an athlete with a muted hip on their cleans. What do you say and when?',
    'An athlete is going too heavy and their form is breaking down. How do you intervene in the middle of an AMRAP?',
    'You see a static fault (butt wink) in the bottom of an athlete\'s squat. How do you cue a correction?',
  ],
  D5: [
    'A 62-year-old masters athlete insists on doing the Rx weight. They have a false positive belief about their capacity. How do you handle it?',
    'A 9-year-old in your kids class is being disruptive. Walk through your behavior management approach.',
    'A coach on your staff is not cueing the points of performance consistently. How do you address it?',
  ],
  D6: [
    'An athlete asks for nutrition advice for weight loss. What can you say within your scope of practice?',
    'An athlete mentions they have been eating very low carb and their performance has dropped. What do you discuss?',
    'A youth athlete\'s parent asks about the Zone Diet for their 12-year-old. How do you respond?',
  ],
  D7: [
    'An athlete asks you to write them a personalized strength program for $150/month. Is this within your scope of practice as a CCFT?',
    'You witness a fellow coach behaving inappropriately toward an athlete. What is your obligation under the Standards of Professional Practice?',
    'Your CCFT expires in 30 days and you haven\'t completed your CEUs. Walk through your options.',
  ],
}

export default function DailySession({ userId }: Props) {
  const { terms } = useVocabTerms()
  const [domain, setDomain] = useState<string | null>(null)
  const [part, setPart] = useState<1 | 2 | 3>(1)
  const [term1, setTerm1] = useState<VocabTerm | null>(null)
  const [term2, setTerm2] = useState<VocabTerm | null>(null)
  const [scenario, setScenario] = useState('')
  const [part2Response, setPart2Response] = useState('')
  const [part3Response, setPart3Response] = useState('')
  const [showDef, setShowDef] = useState(false)
  const [completed, setCompleted] = useState(false)
  const [feedback, setFeedback] = useState('')
  const [evaluating, setEvaluating] = useState(false)
  const [evalError, setEvalError] = useState('')
  const startTime = useRef<number>(Date.now())

  async function evaluate() {
    if (!domain || !part3Response.trim()) return
    setEvaluating(true)
    setEvalError('')
    try {
      const result = await evaluateScenario(domain, scenario, part3Response)
      setFeedback(result.feedback)
    } catch (err) {
      setEvalError(err instanceof Error ? err.message : String(err))
    } finally {
      setEvaluating(false)
    }
  }

  function pickDomain(d: string) {
    setDomain(d)
    setPart(1)
    setShowDef(false)
    setPart2Response('')
    setPart3Response('')
    setCompleted(false)
    setFeedback('')
    setEvalError('')
    startTime.current = Date.now()

    const domainTerms = terms.filter(t => t.domains.includes(d))
    const shuffled = [...domainTerms].sort(() => Math.random() - 0.5)
    setTerm1(shuffled[0] ?? null)
    setTerm2(shuffled[1] ?? null)

    const scenarios = SCENARIOS[d] ?? []
    setScenario(scenarios[Math.floor(Math.random() * scenarios.length)] ?? '')
  }

  async function completeSession() {
    if (!domain || !term1 || !term2) return
    const duration = Math.round((Date.now() - startTime.current) / 1000)
    await supabase.from('study_sessions').insert({
      user_id: userId,
      domain,
      part1_term: term1.term,
      part2_term: term2.term,
      part2_response: part2Response,
      part3_scenario: scenario,
      part3_response: part3Response,
      duration_secs: duration,
    })
    setCompleted(true)
  }

  if (!domain) {
    return (
      <div className="space-y-4">
        <div className="bg-[#111] border border-white/5 rounded-xl p-5">
          <h2
            style={{ fontFamily: "'Bebas Neue', sans-serif", letterSpacing: '3px' }}
            className="text-xl text-white mb-1"
          >
            DAILY SESSION
          </h2>
          <p className="text-[#666] text-sm">30 minutes · Concept → Vocabulary → Scenario</p>
        </div>
        <p className="text-[#a4a4a4] text-sm">Select a domain to begin today's session:</p>
        <div className="grid grid-cols-1 gap-3">
          {DOMAINS.map(d => (
            <button
              key={d}
              onClick={() => pickDomain(d)}
              className="bg-[#111] border border-white/5 hover:border-white/20 rounded-xl p-4 text-left transition-colors flex items-center gap-4"
            >
              <span
                className="text-xs font-bold px-2.5 py-1 rounded"
                style={{ background: DOMAIN_COLORS[d] + '22', color: DOMAIN_COLORS[d] }}
              >
                {d}
              </span>
              <div>
                <div className="text-white text-sm font-semibold">{DOMAIN_LABELS[d]}</div>
              </div>
            </button>
          ))}
        </div>
      </div>
    )
  }

  if (completed) {
    return (
      <div className="space-y-4">
        <div className="bg-[#111] border border-[#003566]/40 rounded-xl p-8 text-center">
          <div className="text-4xl mb-3">✓</div>
          <h2
            style={{ fontFamily: "'Bebas Neue', sans-serif", letterSpacing: '3px' }}
            className="text-2xl text-white mb-2"
          >
            SESSION COMPLETE
          </h2>
          <p className="text-[#666] text-sm mb-6">Domain: {domain} — {DOMAIN_LABELS[domain]}</p>
          <button
            onClick={() => setDomain(null)}
            className="bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-6 py-3 rounded-lg transition-colors"
          >
            New Session
          </button>
        </div>
      </div>
    )
  }

  const d = domain

  return (
    <div className="space-y-4">
      {/* Header */}
      <div className="bg-[#111] border border-white/5 rounded-xl p-5">
        <div className="flex items-center justify-between">
          <div>
            <span
              className="text-xs font-bold px-2.5 py-1 rounded mr-3"
              style={{ background: DOMAIN_COLORS[d] + '22', color: DOMAIN_COLORS[d] }}
            >
              {d}
            </span>
            <span className="text-white font-semibold">{DOMAIN_LABELS[d]}</span>
          </div>
          <button onClick={() => setDomain(null)} className="text-[#555] text-xs hover:text-white transition-colors">
            ← Back
          </button>
        </div>
        {/* Part indicator */}
        <div className="flex gap-2 mt-4">
          {([1, 2, 3] as const).map(p => (
            <div
              key={p}
              className={`flex-1 h-1 rounded-full transition-colors ${part >= p ? 'bg-[#003566]' : 'bg-[#1a1a1a]'}`}
            />
          ))}
        </div>
        <div className="flex justify-between mt-2 text-[10px] text-[#555]">
          <span className={part >= 1 ? 'text-[#a4a4a4]' : ''}>Concept</span>
          <span className={part >= 2 ? 'text-[#a4a4a4]' : ''}>Vocabulary</span>
          <span className={part >= 3 ? 'text-[#a4a4a4]' : ''}>Scenario</span>
        </div>
      </div>

      {/* Part 1 */}
      {part === 1 && term1 && (
        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-4">
          <div className="flex justify-between items-center">
            <h3 className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Part 1 · Concept Review</h3>
            <span className="text-[#555] text-xs">10 min</span>
          </div>
          <div className="bg-[#0a0a0a] border-l-4 rounded-r-lg p-4" style={{ borderColor: DOMAIN_COLORS[d] }}>
            <div className="text-white text-xl font-bold mb-2">{term1.term}</div>
            <div className="text-[#a4a4a4] text-sm leading-relaxed">{term1.def}</div>
            <div className="text-[#555] text-xs mt-3">Source: {term1.src}</div>
          </div>
          <p className="text-[#666] text-xs leading-relaxed">
            Read this definition. Before moving on, recall where you've seen this concept in the study material and how it connects to {DOMAIN_LABELS[d]}.
          </p>
          <div className="flex justify-end">
            <button
              onClick={() => setPart(2)}
              className="bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-5 py-2.5 rounded-lg transition-colors"
            >
              Next: Vocabulary →
            </button>
          </div>
        </div>
      )}

      {/* Part 2 */}
      {part === 2 && term2 && (
        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-4">
          <div className="flex justify-between items-center">
            <h3 className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Part 2 · Vocabulary Bridge</h3>
            <span className="text-[#555] text-xs">15 min</span>
          </div>
          <div className="bg-[#0a0a0a] rounded-lg p-4 border border-white/5">
            <div className="text-white text-xl font-bold">{term2.term}</div>
          </div>
          <div>
            <label className="block text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase mb-2">
              What do you know about this term?
            </label>
            <textarea
              value={part2Response}
              onChange={e => setPart2Response(e.target.value)}
              placeholder="Write your understanding from memory before revealing the definition..."
              className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-4 py-3 text-white text-sm placeholder-[#444] focus:outline-none focus:border-[#003566] transition-colors resize-none"
              rows={4}
            />
          </div>
          <button
            onClick={() => setShowDef(!showDef)}
            className="text-xs text-[#003566] hover:text-[#004a8f] font-semibold tracking-wider uppercase transition-colors"
          >
            {showDef ? 'Hide Definition' : 'Reveal Definition'}
          </button>
          {showDef && (
            <div className="bg-[#0a0a0a] border border-[#003566]/30 rounded-lg p-4">
              <div className="text-[#a4a4a4] text-sm leading-relaxed">{term2.def}</div>
              <div className="text-[#555] text-xs mt-2">Source: {term2.src}</div>
            </div>
          )}
          <div className="flex justify-end">
            <button
              onClick={() => { setPart(3); setShowDef(false) }}
              className="bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-5 py-2.5 rounded-lg transition-colors"
            >
              Next: Scenario →
            </button>
          </div>
        </div>
      )}

      {/* Part 3 */}
      {part === 3 && (
        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-4">
          <div className="flex justify-between items-center">
            <h3 className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Part 3 · Coaching Scenario</h3>
            <span className="text-[#555] text-xs">5 min</span>
          </div>
          <div className="bg-[#0a0a0a] border-l-4 border-[#c41e3a] rounded-r-lg p-4">
            <p className="text-[#e8e8e8] text-sm leading-relaxed">{scenario}</p>
          </div>
          <p className="text-[#666] text-xs">The CCFT tests scenario-based judgment. Think through: assess → act → communicate → follow up.</p>
          <div>
            <label className="block text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase mb-2">
              Your Response
            </label>
            <textarea
              value={part3Response}
              onChange={e => { setPart3Response(e.target.value); setFeedback(''); setEvalError('') }}
              placeholder="What would you do as a certified trainer?"
              className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-4 py-3 text-white text-sm placeholder-[#444] focus:outline-none focus:border-[#003566] transition-colors resize-none"
              rows={5}
            />
          </div>

          {/* Claude evaluation */}
          {!feedback && (
            <div className="flex items-center justify-between">
              {evalError && <p className="text-[#c41e3a] text-xs">{evalError}</p>}
              {!evalError && <span />}
              <button
                onClick={evaluate}
                disabled={!part3Response.trim() || evaluating}
                className="bg-[#1a1a1a] hover:bg-[#222] border border-white/10 hover:border-[#003566]/60 text-[#a4a4a4] hover:text-white text-xs font-semibold tracking-[2px] uppercase px-5 py-2.5 rounded-lg transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
              >
                {evaluating ? 'Evaluating...' : 'Evaluate with Claude →'}
              </button>
            </div>
          )}

          {feedback && (
            <div className="bg-[#0a0a0a] border border-[#003566]/40 rounded-lg p-4 space-y-2">
              <div className="text-[#003566] text-[10px] font-semibold tracking-[2px] uppercase">Claude's Evaluation</div>
              <p className="text-[#e8e8e8] text-sm leading-relaxed">{feedback}</p>
            </div>
          )}

          <div className="flex justify-end">
            <button
              onClick={completeSession}
              className="bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-6 py-3 rounded-lg transition-colors"
            >
              Complete Session ✓
            </button>
          </div>
        </div>
      )}
    </div>
  )
}
