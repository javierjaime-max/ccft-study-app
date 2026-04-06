import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'
import { DOMAIN_COLORS, DOMAIN_LABELS } from '../../data/vocab'

interface Props {
  userId: string
  onNavigate: (tab: string) => void
}

interface DomainStat {
  domain: string
  sessions: number
  avgScore: number
  lastSession: string | null
}

const DOMAINS = ['D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7']

function calcStreak(dates: string[]): number {
  if (dates.length === 0) return 0
  const unique = Array.from(new Set(dates.map(d => d.slice(0, 10)))).sort().reverse()
  const today = new Date().toISOString().slice(0, 10)
  const yesterday = new Date(Date.now() - 86400000).toISOString().slice(0, 10)
  if (unique[0] !== today && unique[0] !== yesterday) return 0
  let streak = 1
  for (let i = 1; i < unique.length; i++) {
    const prev = new Date(unique[i - 1])
    const curr = new Date(unique[i])
    const diff = (prev.getTime() - curr.getTime()) / 86400000
    if (diff === 1) streak++
    else break
  }
  return streak
}

export default function Dashboard({ userId, onNavigate }: Props) {
  const [stats, setStats] = useState<DomainStat[]>([])
  const [streak, setStreak] = useState(0)
  const [totalSessions, setTotalSessions] = useState(0)
  const [faultAttempts, setFaultAttempts] = useState(0)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    async function load() {
      const { data } = await supabase
        .from('study_sessions')
        .select('domain, claude_score, completed_at')
        .eq('user_id', userId)
        .order('completed_at', { ascending: false })

      const sessions = data ?? []
      setTotalSessions(sessions.length)
      setStreak(calcStreak(sessions.map(s => s.completed_at)))

      const byDomain: DomainStat[] = DOMAINS.map(d => {
        const ds = sessions.filter(s => s.domain === d)
        const scored = ds.filter(s => s.claude_score != null)
        const avgScore = scored.length > 0
          ? scored.reduce((sum, s) => sum + (s.claude_score ?? 0), 0) / scored.length
          : 0
        return {
          domain: d,
          sessions: ds.length,
          avgScore,
          lastSession: ds[0]?.completed_at ?? null,
        }
      })
      setStats(byDomain)

      const { count } = await supabase
        .from('fault_finder_attempts')
        .select('id', { count: 'exact', head: true })
        .eq('user_id', userId)
      setFaultAttempts(count ?? 0)

      setLoading(false)
    }
    load()
  }, [userId])

  const weakest = [...stats]
    .filter(s => s.sessions > 0)
    .sort((a, b) => a.avgScore - b.avgScore)[0]

  const untouched = stats.filter(s => s.sessions === 0)

  const focusDomain = weakest ?? (untouched[0] ? { domain: untouched[0].domain, avgScore: 0 } : null)

  const hour = new Date().getHours()
  const greeting = hour < 12 ? 'Good morning' : hour < 17 ? 'Good afternoon' : 'Good evening'

  if (loading) return <div className="text-[#666] text-sm py-12 text-center">Loading...</div>

  return (
    <div className="space-y-4">

      {/* Header */}
      <div className="bg-[#111] border border-white/5 rounded-xl p-5">
        <div className="flex items-start justify-between">
          <div>
            <div className="text-[#666] text-xs uppercase tracking-widest mb-1">{greeting}</div>
            <h1 className="text-white text-xl font-semibold">CCFT Prep</h1>
          </div>
          <div className="text-right">
            <div className="text-3xl font-bold text-white">{streak}</div>
            <div className="text-[10px] text-[#666] uppercase tracking-widest">Day Streak</div>
          </div>
        </div>

        <div className="mt-4 grid grid-cols-3 gap-3">
          <div className="bg-[#0a0a0a] rounded-lg p-3 text-center">
            <div className="text-xl font-bold text-white">{totalSessions}</div>
            <div className="text-[9px] text-[#666] uppercase tracking-widest mt-0.5">Sessions</div>
          </div>
          <div className="bg-[#0a0a0a] rounded-lg p-3 text-center">
            <div className="text-xl font-bold text-white">{faultAttempts}</div>
            <div className="text-[9px] text-[#666] uppercase tracking-widest mt-0.5">Fault Drills</div>
          </div>
          <div className="bg-[#0a0a0a] rounded-lg p-3 text-center">
            <div className="text-xl font-bold text-white">
              {stats.filter(s => s.avgScore >= 4).length}/7
            </div>
            <div className="text-[9px] text-[#666] uppercase tracking-widest mt-0.5">Domains ≥4</div>
          </div>
        </div>
      </div>

      {/* Focus recommendation */}
      {focusDomain && (
        <div
          className="border rounded-xl p-4 cursor-pointer hover:opacity-90 transition-opacity"
          style={{
            backgroundColor: `${DOMAIN_COLORS[focusDomain.domain]}12`,
            borderColor: `${DOMAIN_COLORS[focusDomain.domain]}30`,
          }}
          onClick={() => onNavigate('session')}
        >
          <div className="text-[10px] uppercase tracking-widest mb-1" style={{ color: DOMAIN_COLORS[focusDomain.domain] }}>
            Focus Today
          </div>
          <div className="flex items-center justify-between">
            <div>
              <span className="text-white font-semibold">{focusDomain.domain}</span>
              <span className="text-[#666] text-sm ml-2">— {DOMAIN_LABELS[focusDomain.domain]}</span>
            </div>
            <span className="text-[#666] text-xs">Start →</span>
          </div>
        </div>
      )}

      {/* Domain readiness */}
      <div className="bg-[#111] border border-white/5 rounded-xl p-5">
        <div className="text-[#a4a4a4] text-xs font-semibold tracking-widest uppercase mb-4">Domain Readiness</div>
        <div className="space-y-3">
          {stats.map(({ domain, sessions, avgScore }) => {
            const pct = sessions === 0 ? 0 : Math.round((avgScore / 5) * 100)
            const color = DOMAIN_COLORS[domain]
            return (
              <div key={domain}>
                <div className="flex items-center justify-between mb-1">
                  <div className="flex items-center gap-2">
                    <span className="text-xs font-semibold" style={{ color }}>{domain}</span>
                    <span className="text-[#666] text-xs">{DOMAIN_LABELS[domain]}</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <span className="text-[#555] text-[10px]">{sessions} {sessions === 1 ? 'session' : 'sessions'}</span>
                    <span className="text-white text-xs font-semibold w-8 text-right">{pct > 0 ? `${pct}%` : '—'}</span>
                  </div>
                </div>
                <div className="h-1.5 bg-[#1a1a1a] rounded-full overflow-hidden">
                  <div
                    className="h-full rounded-full transition-all duration-700"
                    style={{ width: `${pct}%`, backgroundColor: color }}
                  />
                </div>
              </div>
            )
          })}
        </div>
      </div>

      {/* Quick actions */}
      <div className="grid grid-cols-2 gap-3">
        <button
          onClick={() => onNavigate('session')}
          className="bg-[#003566] hover:bg-[#004a8f] text-white text-xs font-semibold tracking-[2px] uppercase px-4 py-4 rounded-xl transition-colors"
        >
          Start Session
        </button>
        <button
          onClick={() => onNavigate('faultfinder')}
          className="bg-[#1a1a1a] hover:bg-[#222] border border-white/10 text-[#a4a4a4] hover:text-white text-xs font-semibold tracking-[2px] uppercase px-4 py-4 rounded-xl transition-colors"
        >
          Fault Finder
        </button>
      </div>

    </div>
  )
}
