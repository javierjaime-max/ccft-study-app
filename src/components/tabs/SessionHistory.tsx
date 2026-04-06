import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'
import { DOMAIN_COLORS, DOMAIN_LABELS } from '../../data/vocab'

interface Props { userId: string }

interface Session {
  id: string
  completed_at: string
  domain: string
  part1_term: string
  duration_secs: number
}

export default function SessionHistory({ userId }: Props) {
  const [sessions, setSessions] = useState<Session[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    supabase
      .from('study_sessions')
      .select('id, completed_at, domain, part1_term, duration_secs')
      .eq('user_id', userId)
      .order('completed_at', { ascending: false })
      .limit(50)
      .then(({ data }) => {
        setSessions((data ?? []) as Session[])
        setLoading(false)
      })
  }, [userId])

  const streak = calcStreak(sessions)
  const totalSessions = sessions.length
  const domainCounts = sessions.reduce<Record<string, number>>((acc, s) => {
    acc[s.domain] = (acc[s.domain] ?? 0) + 1
    return acc
  }, {})

  function formatDuration(secs: number) {
    const m = Math.floor(secs / 60)
    const s = secs % 60
    return `${m}m ${s}s`
  }

  function formatDate(iso: string) {
    return new Date(iso).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })
  }

  if (loading) return <div className="text-[#666] text-sm py-8 text-center">Loading...</div>

  return (
    <div className="space-y-4">
      {/* Streak + stats */}
      <div className="bg-[#111] border border-white/5 rounded-xl p-5">
        <div className="grid grid-cols-2 gap-3">
          <div className="bg-[#0a0a0a] rounded-lg p-4 text-center">
            <div className="text-3xl font-bold text-white">{streak}</div>
            <div className="text-[10px] text-[#666] uppercase tracking-widest mt-1">Day Streak</div>
          </div>
          <div className="bg-[#0a0a0a] rounded-lg p-4 text-center">
            <div className="text-3xl font-bold text-white">{totalSessions}</div>
            <div className="text-[10px] text-[#666] uppercase tracking-widest mt-1">Total Sessions</div>
          </div>
        </div>
      </div>

      {/* Domain coverage */}
      {totalSessions > 0 && (
        <div className="bg-[#111] border border-white/5 rounded-xl p-5">
          <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase mb-4">Domain Coverage</div>
          <div className="space-y-2.5">
            {['D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7'].map(d => {
              const count = domainCounts[d] ?? 0
              const pct = totalSessions > 0 ? Math.round((count / totalSessions) * 100) : 0
              return (
                <div key={d}>
                  <div className="flex justify-between items-center mb-1">
                    <span className="text-xs text-[#a4a4a4]">
                      <span className="font-semibold" style={{ color: DOMAIN_COLORS[d] }}>{d}</span>
                      {' '}— {DOMAIN_LABELS[d]}
                    </span>
                    <span className="text-[#555] text-xs">{count} sessions</span>
                  </div>
                  <div className="h-1 bg-[#1a1a1a] rounded-full overflow-hidden">
                    <div
                      className="h-full rounded-full transition-all"
                      style={{ width: `${pct}%`, background: DOMAIN_COLORS[d] }}
                    />
                  </div>
                </div>
              )
            })}
          </div>
        </div>
      )}

      {/* Session log */}
      {sessions.length > 0 ? (
        <div className="bg-[#111] border border-white/5 rounded-xl overflow-hidden">
          <div className="px-5 py-4 border-b border-white/5">
            <h3 className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase">Session Log</h3>
          </div>
          <div className="divide-y divide-white/5">
            {sessions.map(s => (
              <div key={s.id} className="px-5 py-3 flex items-center gap-3">
                <span
                  className="text-[10px] font-bold px-2 py-0.5 rounded shrink-0"
                  style={{ background: DOMAIN_COLORS[s.domain] + '22', color: DOMAIN_COLORS[s.domain] }}
                >
                  {s.domain}
                </span>
                <div className="flex-1 min-w-0">
                  <div className="text-white text-sm truncate">{s.part1_term || DOMAIN_LABELS[s.domain]}</div>
                  <div className="text-[#555] text-xs">{formatDate(s.completed_at)}</div>
                </div>
                {s.duration_secs > 0 && (
                  <span className="text-[#555] text-xs shrink-0">{formatDuration(s.duration_secs)}</span>
                )}
              </div>
            ))}
          </div>
        </div>
      ) : (
        <div className="bg-[#111] border border-white/5 rounded-xl p-8 text-center text-[#555] text-sm">
          No sessions yet. Complete your first Daily Session to start tracking.
        </div>
      )}
    </div>
  )
}

function calcStreak(sessions: Session[]): number {
  if (sessions.length === 0) return 0
  const dates = [...new Set(sessions.map(s => s.completed_at.slice(0, 10)))].sort().reverse()
  let streak = 0
  let current = new Date().toISOString().slice(0, 10)
  for (const date of dates) {
    if (date === current) {
      streak++
      const d = new Date(current)
      d.setDate(d.getDate() - 1)
      current = d.toISOString().slice(0, 10)
    } else {
      break
    }
  }
  return streak
}
