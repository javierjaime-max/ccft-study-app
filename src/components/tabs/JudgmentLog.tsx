import { useEffect, useState, type FormEvent } from 'react'
import { supabase } from '../../lib/supabase'

interface Props { userId: string }

interface LogEntry {
  id: string
  judged_date: string
  course: string
  movement: string
  called: string
  standard: string
  result: 'Correct' | 'Close' | 'Missed'
  notes: string
  logged_at: string
}

const MOVEMENTS = [
  'Air Squat', 'Front Squat', 'Overhead Squat',
  'Shoulder Press', 'Push Press', 'Push Jerk',
  'Deadlift', 'Sumo Deadlift High Pull', 'Medicine-Ball Clean',
  'Clean', 'Snatch', 'Clean and Jerk',
  'Pull-Up', 'Muscle-Up', 'Handstand Push-Up', 'Toes-to-Bar',
  'Thruster', 'Wall Ball', 'Box Jump', 'Burpee', 'Row', 'Other',
]

const RESULT_COLORS = {
  Correct: 'text-green-400',
  Close: 'text-amber-400',
  Missed: 'text-red-400',
}

export default function JudgmentLog({ userId }: Props) {
  const [entries, setEntries] = useState<LogEntry[]>([])
  const [loading, setLoading] = useState(true)
  const [date, setDate] = useState(new Date().toISOString().slice(0, 10))
  const [course, setCourse] = useState('Judges Course')
  const [movement, setMovement] = useState('')
  const [called, setCalled] = useState('')
  const [standard, setStandard] = useState('')
  const [result, setResult] = useState<'Correct' | 'Close' | 'Missed'>('Correct')
  const [notes, setNotes] = useState('')
  const [submitting, setSubmitting] = useState(false)

  useEffect(() => {
    supabase
      .from('judgment_log')
      .select('*')
      .eq('user_id', userId)
      .order('logged_at', { ascending: false })
      .then(({ data }) => {
        setEntries((data ?? []) as LogEntry[])
        setLoading(false)
      })
  }, [userId])

  async function handleSubmit(e: FormEvent) {
    e.preventDefault()
    if (!movement) return
    setSubmitting(true)
    const { data } = await supabase.from('judgment_log').insert({
      user_id: userId,
      judged_date: date,
      course,
      movement,
      called,
      standard,
      result,
      notes,
    }).select().single()
    if (data) setEntries(prev => [data as LogEntry, ...prev])
    setCalled('')
    setStandard('')
    setNotes('')
    setSubmitting(false)
  }

  const correct = entries.filter(e => e.result === 'Correct').length
  const close = entries.filter(e => e.result === 'Close').length
  const missed = entries.filter(e => e.result === 'Missed').length

  return (
    <div className="space-y-4">
      {/* Summary */}
      {entries.length > 0 && (
        <div className="bg-[#111] border border-white/5 rounded-xl p-5">
          <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase mb-3">Judgment Summary</div>
          <div className="grid grid-cols-3 gap-3">
            <div className="bg-[#0a0a0a] rounded-lg p-3 text-center">
              <div className="text-2xl font-bold text-green-400">{correct}</div>
              <div className="text-[10px] text-[#666] uppercase tracking-widest mt-0.5">Correct</div>
            </div>
            <div className="bg-[#0a0a0a] rounded-lg p-3 text-center">
              <div className="text-2xl font-bold text-amber-400">{close}</div>
              <div className="text-[10px] text-[#666] uppercase tracking-widest mt-0.5">Close</div>
            </div>
            <div className="bg-[#0a0a0a] rounded-lg p-3 text-center">
              <div className="text-2xl font-bold text-red-400">{missed}</div>
              <div className="text-[10px] text-[#666] uppercase tracking-widest mt-0.5">Missed</div>
            </div>
          </div>
        </div>
      )}

      {/* Log form */}
      <div className="bg-[#111] border border-white/5 rounded-xl p-5">
        <h2
          style={{ fontFamily: "'Bebas Neue', sans-serif", letterSpacing: '3px' }}
          className="text-xl text-white mb-4"
        >
          LOG A JUDGMENT CALL
        </h2>
        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="block text-[#a4a4a4] text-[10px] font-semibold tracking-widest uppercase mb-1.5">Date</label>
              <input
                type="date"
                value={date}
                onChange={e => setDate(e.target.value)}
                className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-3 py-2.5 text-white text-sm focus:outline-none focus:border-[#003566] transition-colors"
              />
            </div>
            <div>
              <label className="block text-[#a4a4a4] text-[10px] font-semibold tracking-widest uppercase mb-1.5">Course</label>
              <select
                value={course}
                onChange={e => setCourse(e.target.value)}
                className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-3 py-2.5 text-white text-sm focus:outline-none focus:border-[#003566] transition-colors"
              >
                <option>Judges Course</option>
                <option>Spot the Flaw</option>
                <option>Force</option>
                <option>Other</option>
              </select>
            </div>
          </div>

          <div>
            <label className="block text-[#a4a4a4] text-[10px] font-semibold tracking-widest uppercase mb-1.5">Movement</label>
            <select
              value={movement}
              onChange={e => setMovement(e.target.value)}
              required
              className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-3 py-2.5 text-white text-sm focus:outline-none focus:border-[#003566] transition-colors"
            >
              <option value="">— Select movement —</option>
              {MOVEMENTS.map(m => <option key={m}>{m}</option>)}
            </select>
          </div>

          <div>
            <label className="block text-[#a4a4a4] text-[10px] font-semibold tracking-widest uppercase mb-1.5">What I Called</label>
            <textarea
              value={called}
              onChange={e => setCalled(e.target.value)}
              placeholder="What did you judge as the fault or standard?"
              rows={2}
              className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-3 py-2.5 text-white text-sm placeholder-[#444] focus:outline-none focus:border-[#003566] transition-colors resize-none"
            />
          </div>

          <div>
            <label className="block text-[#a4a4a4] text-[10px] font-semibold tracking-widest uppercase mb-1.5">What the Standard Requires</label>
            <textarea
              value={standard}
              onChange={e => setStandard(e.target.value)}
              placeholder="What does the CrossFit standard actually require?"
              rows={2}
              className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-3 py-2.5 text-white text-sm placeholder-[#444] focus:outline-none focus:border-[#003566] transition-colors resize-none"
            />
          </div>

          <div>
            <label className="block text-[#a4a4a4] text-[10px] font-semibold tracking-widest uppercase mb-2">Result</label>
            <div className="flex gap-2">
              {(['Correct', 'Close', 'Missed'] as const).map(r => (
                <button
                  key={r}
                  type="button"
                  onClick={() => setResult(r)}
                  className={`flex-1 py-2.5 text-xs font-semibold tracking-widest uppercase rounded-lg border transition-colors ${
                    result === r
                      ? r === 'Correct' ? 'bg-green-900/40 border-green-700 text-green-400'
                        : r === 'Close' ? 'bg-amber-900/30 border-amber-700 text-amber-400'
                        : 'bg-red-900/30 border-red-800 text-red-400'
                      : 'border-white/10 text-[#555] hover:text-white'
                  }`}
                >
                  {r}
                </button>
              ))}
            </div>
          </div>

          <div>
            <label className="block text-[#a4a4a4] text-[10px] font-semibold tracking-widest uppercase mb-1.5">Notes (optional)</label>
            <textarea
              value={notes}
              onChange={e => setNotes(e.target.value)}
              placeholder="What did you learn?"
              rows={2}
              className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-3 py-2.5 text-white text-sm placeholder-[#444] focus:outline-none focus:border-[#003566] transition-colors resize-none"
            />
          </div>

          <button
            type="submit"
            disabled={submitting || !movement}
            className="w-full bg-[#003566] hover:bg-[#004a8f] disabled:opacity-40 text-white text-xs font-semibold tracking-[2px] uppercase py-3 rounded-lg transition-colors"
          >
            {submitting ? 'Saving...' : 'Log Entry'}
          </button>
        </form>
      </div>

      {/* Log table */}
      {!loading && entries.length > 0 && (
        <div className="bg-[#111] border border-white/5 rounded-xl overflow-hidden">
          <div className="px-5 py-4 border-b border-white/5">
            <h3 className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Recent Entries</h3>
          </div>
          <div className="divide-y divide-white/5">
            {entries.slice(0, 20).map(entry => (
              <div key={entry.id} className="px-5 py-3">
                <div className="flex items-start justify-between gap-2">
                  <div className="flex-1 min-w-0">
                    <div className="flex items-center gap-2 flex-wrap">
                      <span className="text-white text-sm font-semibold">{entry.movement}</span>
                      <span className={`text-xs font-semibold ${RESULT_COLORS[entry.result]}`}>{entry.result}</span>
                    </div>
                    <div className="text-[#555] text-xs mt-0.5">{entry.course} · {entry.judged_date}</div>
                    {entry.called && <div className="text-[#a4a4a4] text-xs mt-1">Called: {entry.called}</div>}
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  )
}
