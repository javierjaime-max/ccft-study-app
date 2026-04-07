import { useState } from 'react'
import FaultFinder from './FaultFinder'
import JudgmentLog from './JudgmentLog'

interface Props { userId: string }

type View = 'fault' | 'judgment'

export default function Practice({ userId }: Props) {
  const [view, setView] = useState<View>('fault')

  return (
    <div className="space-y-4">
      <div className="bg-[#111] border border-white/5 rounded-xl p-5">
        <h2 className="text-white font-semibold mb-1">Practice</h2>
        <p className="text-[#666] text-sm">On-demand drilling. No structure — just reps.</p>
      </div>

      <div className="flex gap-2 mb-4">
        <button
          onClick={() => setView('fault')}
          className={`px-4 py-2 rounded-full text-xs font-semibold tracking-widest uppercase border transition-colors ${
            view === 'fault'
              ? 'bg-[#003566] border-[#003566] text-white'
              : 'border-white/10 text-[#666] hover:text-white'
          }`}
        >
          Fault Finder
        </button>
        <button
          onClick={() => setView('judgment')}
          className={`px-4 py-2 rounded-full text-xs font-semibold tracking-widest uppercase border transition-colors ${
            view === 'judgment'
              ? 'bg-[#003566] border-[#003566] text-white'
              : 'border-white/10 text-[#666] hover:text-white'
          }`}
        >
          Judgment Log
        </button>
      </div>

      {view === 'fault' ? (
        <FaultFinder userId={userId} />
      ) : (
        <JudgmentLog userId={userId} />
      )}
    </div>
  )
}
