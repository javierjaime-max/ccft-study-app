import { useEffect, useState } from 'react'
import { supabase } from '../../lib/supabase'
import { DOCUMENTS, DOMAIN_WEIGHTS } from '../../data/documents'
import { DOMAIN_COLORS, DOMAIN_LABELS } from '../../data/vocab'

interface Props { userId: string }

export default function DailyReading({ userId }: Props) {
  const [readIds, setReadIds] = useState<Set<string>>(new Set())
  const [domainFilter, setDomainFilter] = useState('all')
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    supabase
      .from('reading_progress')
      .select('doc_id')
      .eq('user_id', userId)
      .then(({ data }) => {
        setReadIds(new Set((data ?? []).map(r => r.doc_id)))
        setLoading(false)
      })
  }, [userId])

  async function markRead(docId: string) {
    await supabase.from('reading_progress').upsert({ user_id: userId, doc_id: docId })
    setReadIds(prev => new Set([...prev, docId]))
  }

  async function markUnread(docId: string) {
    await supabase.from('reading_progress').delete().eq('user_id', userId).eq('doc_id', docId)
    setReadIds(prev => { const next = new Set(prev); next.delete(docId); return next })
  }

  const filtered = domainFilter === 'all' ? DOCUMENTS : DOCUMENTS.filter(d => d.domain === domainFilter)
  const readCount = [...readIds].filter(id => DOCUMENTS.find(d => d.id === id)).length
  const pct = Math.round((readCount / DOCUMENTS.length) * 100)

  if (loading) return <div className="text-[#666] text-sm py-8 text-center">Loading...</div>

  return (
    <div className="space-y-4">
      {/* Progress */}
      <div className="bg-[#111] border border-white/5 rounded-xl p-5">
        <div className="flex justify-between items-center mb-3">
          <span className="text-xs text-[#a4a4a4] font-semibold tracking-widest uppercase">Reading Progress</span>
          <span className="text-white text-sm font-bold">{readCount} / {DOCUMENTS.length}</span>
        </div>
        <div className="h-1.5 bg-[#1a1a1a] rounded-full overflow-hidden">
          <div className="h-full bg-[#003566] rounded-full transition-all" style={{ width: `${pct}%` }} />
        </div>
        <div className="mt-3 grid grid-cols-7 gap-1">
          {Object.entries(DOMAIN_WEIGHTS).map(([domain, weight]) => (
            <div key={domain} className="text-center">
              <div className="text-[10px] text-[#666]">{domain}</div>
              <div className="text-[10px] font-bold" style={{ color: DOMAIN_COLORS[domain] }}>{weight}%</div>
            </div>
          ))}
        </div>
      </div>

      {/* Filter */}
      <div className="flex gap-2 flex-wrap">
        {['all', 'D1', 'D2', 'D3', 'D4', 'D5', 'D6', 'D7'].map(d => (
          <button
            key={d}
            onClick={() => setDomainFilter(d)}
            className={`text-[10px] font-semibold tracking-widest uppercase px-3 py-1.5 rounded-full border transition-colors ${
              domainFilter === d
                ? 'bg-[#003566] border-[#003566] text-white'
                : 'bg-transparent border-white/10 text-[#666] hover:text-white'
            }`}
          >
            {d === 'all' ? 'All' : `${d} — ${DOMAIN_LABELS[d]}`}
          </button>
        ))}
      </div>

      {/* Document list */}
      {filtered.map(doc => {
        const isRead = readIds.has(doc.id)
        return (
          <div
            key={doc.id}
            className={`bg-[#111] border rounded-xl p-5 transition-colors ${isRead ? 'border-[#003566]/40' : 'border-white/5'}`}
          >
            <div className="flex items-start justify-between gap-3 mb-3">
              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2 mb-1 flex-wrap">
                  <span
                    className="text-[10px] font-bold px-2 py-0.5 rounded tracking-wider"
                    style={{ background: DOMAIN_COLORS[doc.domain] + '22', color: DOMAIN_COLORS[doc.domain] }}
                  >
                    {doc.domain}
                  </span>
                  <span className={`text-[10px] font-semibold tracking-widest uppercase ${
                    doc.priority === 'critical' ? 'text-red-400' : doc.priority === 'high' ? 'text-amber-400' : 'text-[#666]'
                  }`}>
                    {doc.priority}
                  </span>
                  {isRead && <span className="text-[10px] text-[#003566] font-semibold tracking-widest uppercase">✓ Read</span>}
                </div>
                <h3 className="text-white font-semibold text-sm">{doc.title}</h3>
                <p className="text-[#666] text-xs mt-1 leading-relaxed">{doc.description}</p>
              </div>
            </div>

            <div className="mb-4">
              <div className="text-[10px] text-[#555] font-semibold tracking-widest uppercase mb-1.5">Focus Areas</div>
              <ul className="space-y-0.5">
                {doc.focusAreas.map(area => (
                  <li key={area} className="text-xs text-[#a4a4a4] flex items-start gap-1.5">
                    <span className="text-[#003566] mt-0.5">›</span>{area}
                  </li>
                ))}
              </ul>
            </div>

            <div className="flex gap-2">
              {doc.url !== 'ONEDRIVE_LINK_PLACEHOLDER' && (
                <a
                  href={doc.url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="bg-[#003566] hover:bg-[#004a8f] text-white text-[10px] font-semibold tracking-[2px] uppercase px-4 py-2 rounded-lg transition-colors"
                >
                  Open PDF
                </a>
              )}
              <button
                onClick={() => isRead ? markUnread(doc.id) : markRead(doc.id)}
                className={`text-[10px] font-semibold tracking-[2px] uppercase px-4 py-2 rounded-lg border transition-colors ${
                  isRead
                    ? 'border-white/10 text-[#666] hover:text-white'
                    : 'border-[#003566] text-[#003566] hover:bg-[#003566] hover:text-white'
                }`}
              >
                {isRead ? 'Mark Unread' : 'Mark as Read'}
              </button>
            </div>
          </div>
        )
      })}
    </div>
  )
}
