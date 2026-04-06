import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'
import { VOCAB_DATA, DOMAIN_COLORS } from '../../data/vocab'

interface Props { userId: string }
type Status = 'unseen' | 'learning' | 'known'

export default function Flashcards({ userId }: Props) {
  const [progress, setProgress] = useState<Record<string, Status>>({})
  const [domainFilter, setDomainFilter] = useState('all')
  const [statusFilter, setStatusFilter] = useState<'all' | Status>('all')
  const [currentIndex, setCurrentIndex] = useState(0)
  const [flipped, setFlipped] = useState(false)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    supabase
      .from('flashcard_progress')
      .select('term, status')
      .eq('user_id', userId)
      .then(({ data }) => {
        const map: Record<string, Status> = {}
        ;(data ?? []).forEach(r => { map[r.term] = r.status as Status })
        setProgress(map)
        setLoading(false)
      })
  }, [userId])

  const filtered = VOCAB_DATA.filter(t => {
    const domainMatch = domainFilter === 'all' || t.domains.includes(domainFilter)
    const status = progress[t.term] ?? 'unseen'
    const statusMatch = statusFilter === 'all' || status === statusFilter
    return domainMatch && statusMatch
  })

  const card = filtered[currentIndex] ?? null

  async function rate(status: Status) {
    if (!card) return
    await supabase.from('flashcard_progress').upsert({
      user_id: userId,
      term: card.term,
      status,
      last_seen: new Date().toISOString(),
    }, { onConflict: 'user_id,term' })
    setProgress(prev => ({ ...prev, [card.term]: status }))
    next()
  }

  function next() {
    setFlipped(false)
    setCurrentIndex(i => (i + 1) % Math.max(filtered.length, 1))
  }

  const known = Object.values(progress).filter(s => s === 'known').length
  const learning = Object.values(progress).filter(s => s === 'learning').length
  const unseen = VOCAB_DATA.length - known - learning
  const pct = Math.round((known / VOCAB_DATA.length) * 100)

  if (loading) return <div className="text-[#666] text-sm py-8 text-center">Loading...</div>

  return (
    <div className="space-y-4">
      {/* Stats */}
      <div className="bg-[#111] border border-white/5 rounded-xl p-5">
        <div className="grid grid-cols-3 gap-3 mb-4">
          <div className="bg-[#0a0a0a] rounded-lg p-3 text-center">
            <div className="text-2xl font-bold text-green-400">{known}</div>
            <div className="text-[10px] text-[#666] uppercase tracking-widest mt-0.5">Got It</div>
          </div>
          <div className="bg-[#0a0a0a] rounded-lg p-3 text-center">
            <div className="text-2xl font-bold text-amber-400">{learning}</div>
            <div className="text-[10px] text-[#666] uppercase tracking-widest mt-0.5">Learning</div>
          </div>
          <div className="bg-[#0a0a0a] rounded-lg p-3 text-center">
            <div className="text-2xl font-bold text-[#666]">{unseen}</div>
            <div className="text-[10px] text-[#666] uppercase tracking-widest mt-0.5">Unseen</div>
          </div>
        </div>
        <div className="h-1.5 bg-[#1a1a1a] rounded-full overflow-hidden">
          <div className="h-full bg-green-500 rounded-full transition-all" style={{ width: `${pct}%` }} />
        </div>
        <div className="text-[10px] text-[#555] mt-1 text-right">{pct}% mastered</div>
      </div>

      {/* Filters */}
      <div className="flex gap-2 flex-wrap">
        {['all', 'D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7'].map(d => (
          <button
            key={d}
            onClick={() => { setDomainFilter(d); setCurrentIndex(0); setFlipped(false) }}
            className={`text-[10px] font-semibold tracking-widest uppercase px-3 py-1.5 rounded-full border transition-colors ${
              domainFilter === d ? 'bg-[#003566] border-[#003566] text-white' : 'border-white/10 text-[#666] hover:text-white'
            }`}
          >
            {d === 'all' ? 'All' : d}
          </button>
        ))}
      </div>
      <div className="flex gap-2">
        {(['all', 'unseen', 'learning', 'known'] as const).map(s => (
          <button
            key={s}
            onClick={() => { setStatusFilter(s); setCurrentIndex(0); setFlipped(false) }}
            className={`text-[10px] font-semibold tracking-widest uppercase px-3 py-1.5 rounded-full border transition-colors ${
              statusFilter === s ? 'bg-[#003566] border-[#003566] text-white' : 'border-white/10 text-[#666] hover:text-white'
            }`}
          >
            {s === 'all' ? 'All' : s === 'unseen' ? 'Unseen' : s === 'learning' ? 'Learning' : 'Got It'}
          </button>
        ))}
        <span className="ml-auto text-[#555] text-xs self-center">{filtered.length} cards</span>
      </div>

      {/* Flashcard */}
      {card ? (
        <>
          <div
            onClick={() => setFlipped(f => !f)}
            className="cursor-pointer"
            style={{ perspective: '1000px' }}
          >
            <div
              style={{
                transformStyle: 'preserve-3d',
                transform: flipped ? 'rotateY(180deg)' : 'rotateY(0deg)',
                transition: 'transform 0.4s',
                position: 'relative',
                minHeight: '220px',
              }}
            >
              {/* Front */}
              <div
                style={{ backfaceVisibility: 'hidden' }}
                className="absolute inset-0 bg-[#111] border border-white/5 rounded-xl p-6 flex flex-col items-center justify-center text-center"
              >
                <div className="flex gap-1 mb-4 flex-wrap justify-center">
                  {card.domains.map(d => (
                    <span key={d} className="text-[10px] font-bold px-2 py-0.5 rounded" style={{ background: DOMAIN_COLORS[d] + '22', color: DOMAIN_COLORS[d] }}>{d}</span>
                  ))}
                </div>
                <div className="text-white text-xl font-bold">{card.term}</div>
                <div className="text-[#555] text-xs mt-4">Tap to reveal definition</div>
              </div>
              {/* Back */}
              <div
                style={{ backfaceVisibility: 'hidden', transform: 'rotateY(180deg)' }}
                className="absolute inset-0 bg-[#0a1a0a] border border-green-900/30 rounded-xl p-6 flex flex-col items-center justify-center text-center"
              >
                <p className="text-[#e8e8e8] text-sm leading-relaxed">{card.def}</p>
                <div className="text-[#555] text-xs mt-4">{card.src}</div>
              </div>
            </div>
          </div>

          {/* Rating buttons */}
          <div className="grid grid-cols-3 gap-2">
            <button
              onClick={() => rate('known')}
              className="bg-green-900/30 hover:bg-green-900/50 border border-green-900/50 text-green-400 text-xs font-semibold tracking-widest uppercase py-3 rounded-lg transition-colors"
            >
              Got It
            </button>
            <button
              onClick={() => rate('learning')}
              className="bg-amber-900/20 hover:bg-amber-900/40 border border-amber-900/40 text-amber-400 text-xs font-semibold tracking-widest uppercase py-3 rounded-lg transition-colors"
            >
              Learning
            </button>
            <button
              onClick={() => rate('unseen')}
              className="bg-[#111] hover:bg-[#1a1a1a] border border-white/10 text-[#666] text-xs font-semibold tracking-widest uppercase py-3 rounded-lg transition-colors"
            >
              Again
            </button>
          </div>
          <button onClick={next} className="w-full text-[#555] text-xs hover:text-white transition-colors py-2">
            Skip →
          </button>
        </>
      ) : (
        <div className="bg-[#111] border border-white/5 rounded-xl p-8 text-center text-[#555] text-sm">
          No cards match this filter.
        </div>
      )}
    </div>
  )
}
