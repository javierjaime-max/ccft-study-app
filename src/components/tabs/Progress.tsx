import { useState } from 'react'
import Dashboard from './Dashboard'
import SessionHistory from './SessionHistory'
import DailyReading from './DailyReading'

interface Props { userId: string }

type View = 'stats' | 'history' | 'reading'

export default function Progress({ userId }: Props) {
  const [view, setView] = useState<View>('stats')

  return (
    <div className="space-y-4">
      <div className="flex gap-2 mb-4">
        <button
          onClick={() => setView('stats')}
          className={`px-4 py-2 rounded-full text-xs font-semibold tracking-widest uppercase border transition-colors ${
            view === 'stats'
              ? 'bg-[#003566] border-[#003566] text-white'
              : 'border-white/10 text-[#666] hover:text-white'
          }`}
        >
          Stats
        </button>
        <button
          onClick={() => setView('history')}
          className={`px-4 py-2 rounded-full text-xs font-semibold tracking-widest uppercase border transition-colors ${
            view === 'history'
              ? 'bg-[#003566] border-[#003566] text-white'
              : 'border-white/10 text-[#666] hover:text-white'
          }`}
        >
          History
        </button>
        <button
          onClick={() => setView('reading')}
          className={`px-4 py-2 rounded-full text-xs font-semibold tracking-widest uppercase border transition-colors ${
            view === 'reading'
              ? 'bg-[#003566] border-[#003566] text-white'
              : 'border-white/10 text-[#666] hover:text-white'
          }`}
        >
          Reading
        </button>
      </div>

      {view === 'stats' && (
        <Dashboard userId={userId} onNavigate={() => {}} />
      )}
      {view === 'history' && (
        <SessionHistory userId={userId} />
      )}
      {view === 'reading' && (
        <DailyReading userId={userId} />
      )}
    </div>
  )
}
