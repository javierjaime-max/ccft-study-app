import { useState } from 'react'
import { supabase } from '../../lib/supabase'
import { DOMAIN_COLORS, DOMAIN_LABELS } from '../../data/vocab'
import { generateFaultScenario, evaluateFaultResponse } from '../../lib/claude'
import type { FaultScenario, FaultEvaluation } from '../../lib/claude'

interface Props { userId: string }

const MOVEMENTS_BY_DOMAIN: Record<string, string[]> = {
  D1: ['Air Squat', 'Push-up', 'Deadlift', 'Overhead Press', 'Lunge'],
  D2: ['Back Squat', 'Deadlift', 'Pull-up', 'Thruster', 'Kettlebell Swing'],
  D3: ['Air Squat', 'Front Squat', 'Overhead Squat', 'Deadlift', 'Press', 'Power Clean', 'Pull-up', 'Handstand Push-up'],
  D4: ['Power Clean', 'Hang Power Clean', 'Power Snatch', 'Thruster', 'Back Squat', 'Deadlift', 'Kettlebell Swing', 'Muscle-up'],
  D5: ['Air Squat', 'Deadlift', 'Push-up', 'Ring Row', 'Box Step-up'],
  D6: [],
  D7: [],
}

type Step = 'pick' | 'loading' | 'identify' | 'evaluating' | 'result'

export default function FaultFinder({ userId }: Props) {
  const [domain, setDomain] = useState<string | null>(null)
  const [movement, setMovement] = useState<string | null>(null)
  const [step, setStep] = useState<Step>('pick')
  const [scenario, setScenario] = useState<FaultScenario | null>(null)
  const [selected, setSelected] = useState<string | null>(null)
  const [cue, setCue] = useState('')
  const [result, setResult] = useState<FaultEvaluation | null>(null)
  const [error, setError] = useState('')

  async function generate() {
    if (!domain || !movement) return
    setStep('loading')
    setError('')
    try {
      const data = await generateFaultScenario(domain, movement)
      setScenario(data)
      setStep('identify')
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err))
      setStep('pick')
    }
  }

  async function evaluate() {
    if (!scenario || !selected || !cue.trim() || !movement) return
    setStep('evaluating')
    setError('')
    try {
      const evaluation = await evaluateFaultResponse(
        movement,
        scenario.athlete_description,
        scenario.fault_options,
        selected,
        cue
      )
      setResult(evaluation)

      // Save attempt
      await supabase.from('fault_finder_attempts').insert({
        user_id: userId,
        domain: domain!,
        movement,
        scenario: scenario.athlete_description,
        fault_options: scenario.fault_options,
        selected_fault: selected,
        cue_response: cue,
        claude_score: evaluation.score,
        claude_feedback: evaluation.feedback,
      })

      setStep('result')
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err))
      setStep('identify')
    }
  }

  function reset() {
    setDomain(null)
    setMovement(null)
    setStep('pick')
    setScenario(null)
    setSelected(null)
    setCue('')
    setResult(null)
    setError('')
  }

  function tryAnother() {
    setStep('pick')
    setScenario(null)
    setSelected(null)
    setCue('')
    setResult(null)
    setError('')
  }

  const movableDomains = ['D1', 'D2', 'D3', 'D4', 'D5']

  // Domain picker
  if (step === 'pick' && !domain) {
    return (
      <div className="space-y-4">
        <div className="bg-[#111] border border-white/5 rounded-xl p-5">
          <h2 className="text-white font-semibold mb-1">Fault Finder</h2>
          <p className="text-[#666] text-sm">
            Identify the primary movement fault using CrossFit's framework. Simulates the video component of the CCFT exam.
          </p>
        </div>

        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-3">
          <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Select Domain</div>
          <div className="grid grid-cols-1 gap-2">
            {movableDomains.map(d => (
              <button
                key={d}
                onClick={() => setDomain(d)}
                className="flex items-center gap-3 bg-[#0a0a0a] hover:bg-[#141414] border border-white/5 hover:border-white/10 rounded-lg px-4 py-3 transition-colors text-left"
              >
                <span className="text-xs font-bold w-6" style={{ color: DOMAIN_COLORS[d] }}>{d}</span>
                <span className="text-[#a4a4a4] text-sm">{DOMAIN_LABELS[d]}</span>
              </button>
            ))}
          </div>
        </div>
      </div>
    )
  }

  // Movement picker
  if (step === 'pick' && domain && !movement) {
    const moves = MOVEMENTS_BY_DOMAIN[domain] ?? []
    return (
      <div className="space-y-4">
        <div className="flex items-center gap-3">
          <button onClick={reset} className="text-[#555] hover:text-white text-xs transition-colors">← Back</button>
          <span className="text-xs font-bold" style={{ color: DOMAIN_COLORS[domain] }}>{domain} — {DOMAIN_LABELS[domain]}</span>
        </div>

        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-3">
          <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Select Movement</div>
          <div className="grid grid-cols-2 gap-2">
            {moves.map(m => (
              <button
                key={m}
                onClick={() => { setMovement(m); generate() }}
                className="bg-[#0a0a0a] hover:bg-[#141414] border border-white/5 hover:border-white/10 rounded-lg px-4 py-3 text-sm text-[#a4a4a4] hover:text-white transition-colors text-left"
              >
                {m}
              </button>
            ))}
          </div>
        </div>
      </div>
    )
  }

  // Loading
  if (step === 'loading') {
    return (
      <div className="flex flex-col items-center justify-center py-16 space-y-3">
        <div className="text-white text-sm">Generating scenario...</div>
        <div className="text-[#555] text-xs">{movement} · {domain}</div>
      </div>
    )
  }

  // Fault identification
  if (step === 'identify' && scenario) {
    return (
      <div className="space-y-4">
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-2">
            <span className="text-xs font-bold" style={{ color: DOMAIN_COLORS[domain!] }}>{domain}</span>
            <span className="text-[#555] text-xs">·</span>
            <span className="text-[#a4a4a4] text-xs">{movement}</span>
          </div>
          <button onClick={reset} className="text-[#555] hover:text-white text-xs transition-colors">Start Over</button>
        </div>

        {/* Athlete description */}
        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-3">
          <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Athlete in Motion</div>
          <p className="text-[#e8e8e8] text-sm leading-relaxed">{scenario.athlete_description}</p>
          <p className="text-[#555] text-xs">Identify the PRIMARY fault — the one CrossFit's framework says to correct first.</p>
        </div>

        {/* Fault options */}
        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-2">
          <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase mb-3">Select the Primary Fault</div>
          {scenario.fault_options.map(opt => (
            <button
              key={opt.id}
              onClick={() => setSelected(opt.id)}
              className={`w-full flex items-start gap-3 px-4 py-3 rounded-lg border transition-colors text-left ${
                selected === opt.id
                  ? 'border-[#003566] bg-[#003566]/10 text-white'
                  : 'border-white/5 bg-[#0a0a0a] text-[#a4a4a4] hover:border-white/10 hover:text-white'
              }`}
            >
              <span className="text-xs font-bold mt-0.5 w-4 shrink-0" style={{ color: selected === opt.id ? '#fff' : DOMAIN_COLORS[domain!] }}>
                {opt.id}
              </span>
              <span className="text-sm">{opt.label}</span>
            </button>
          ))}
        </div>

        {/* Cue */}
        {selected && (
          <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-3">
            <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Your Cue</div>
            <p className="text-[#555] text-xs">What would you say to correct this fault? Use CrossFit's coaching language.</p>
            <textarea
              value={cue}
              onChange={e => setCue(e.target.value)}
              placeholder="e.g. 'Knees out — drive them over your pinky toes...'"
              className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-4 py-3 text-white text-sm placeholder-[#444] focus:outline-none focus:border-[#003566] transition-colors resize-none"
              rows={3}
            />
            {error && <p className="text-[#c41e3a] text-xs">{error}</p>}
            <div className="flex justify-end">
              <button
                onClick={evaluate}
                disabled={!cue.trim()}
                className="bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-6 py-3 rounded-lg transition-colors disabled:opacity-30 disabled:cursor-not-allowed"
              >
                Evaluate →
              </button>
            </div>
          </div>
        )}
      </div>
    )
  }

  // Evaluating
  if (step === 'evaluating') {
    return (
      <div className="flex flex-col items-center justify-center py-16 space-y-3">
        <div className="text-white text-sm">Evaluating your selection...</div>
      </div>
    )
  }

  // Result
  if (step === 'result' && result && scenario) {
    const scoreColor = result.score >= 4 ? '#34C759' : result.score >= 3 ? '#FF9500' : '#c41e3a'
    return (
      <div className="space-y-4">
        {/* Score */}
        <div className="bg-[#111] border border-white/5 rounded-xl p-5">
          <div className="flex items-center justify-between mb-3">
            <div>
              <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Result</div>
              <div className="flex items-center gap-2 mt-1">
                <span
                  className="text-xs font-semibold px-2 py-0.5 rounded"
                  style={{ color: result.correct_selection ? '#34C759' : '#c41e3a', backgroundColor: result.correct_selection ? '#34C75920' : '#c41e3a20' }}
                >
                  {result.correct_selection ? '✓ Correct' : '✗ Incorrect'}
                </span>
                <span className="text-xs font-bold" style={{ color: scoreColor }}>{result.score}/5</span>
              </div>
            </div>
            <div className="text-right">
              <div className="text-[#555] text-[10px] uppercase tracking-widest">{movement}</div>
              <div className="text-[#555] text-[10px]">{domain} — {DOMAIN_LABELS[domain!]}</div>
            </div>
          </div>

          <div className="h-1.5 bg-[#1a1a1a] rounded-full overflow-hidden">
            <div className="h-full rounded-full" style={{ width: `${(result.score / 5) * 100}%`, backgroundColor: scoreColor }} />
          </div>
        </div>

        {/* Primary fault */}
        <div className="bg-[#0a0a0a] border border-[#003566]/30 rounded-xl p-4 space-y-1">
          <div className="text-[#003566] text-[10px] font-semibold tracking-[2px] uppercase">Primary Fault</div>
          <p className="text-[#e8e8e8] text-sm">{result.primary_fault}</p>
        </div>

        {/* Feedback */}
        <div className="bg-[#111] border border-white/5 rounded-xl p-5 space-y-3">
          <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Claude's Evaluation</div>
          <p className="text-[#e8e8e8] text-sm leading-relaxed">{result.feedback}</p>
          {result.cue_assessment && (
            <div className="border-t border-white/5 pt-3">
              <div className="text-[#666] text-[10px] uppercase tracking-widest mb-1">Your Cue</div>
              <p className="text-[#a4a4a4] text-sm">{result.cue_assessment}</p>
            </div>
          )}
        </div>

        {/* Actions */}
        <div className="grid grid-cols-2 gap-3">
          <button
            onClick={tryAnother}
            className="bg-[#1a1a1a] hover:bg-[#222] border border-white/10 text-[#a4a4a4] hover:text-white text-xs font-semibold tracking-[2px] uppercase px-4 py-3 rounded-xl transition-colors"
          >
            Try Another
          </button>
          <button
            onClick={reset}
            className="bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-4 py-3 rounded-xl transition-colors"
          >
            New Domain
          </button>
        </div>
      </div>
    )
  }

  return null
}
