import { useState } from 'react'
import type { User } from '@supabase/supabase-js'
import { useAuth } from '../hooks/useAuth'
import Today from './tabs/Today'
import Practice from './tabs/Practice'
import Progress from './tabs/Progress'

type Tab = 'today' | 'practice' | 'progress'

interface Props {
  user: User
}

const TABS: { id: Tab; label: string; short: string }[] = [
  { id: 'today', label: 'Today', short: 'Today' },
  { id: 'practice', label: 'Practice', short: 'Practice' },
  { id: 'progress', label: 'Progress', short: 'Progress' },
]

export default function Layout({ user }: Props) {
  const { signOut } = useAuth()
  const [activeTab, setActiveTab] = useState<Tab>('today')

  return (
    <div
      style={{ fontFamily: "'Inter', sans-serif" }}
      className="min-h-screen bg-[#0a0a0a] text-white flex flex-col"
    >
      {/* Top Nav */}
      <nav className="flex items-center justify-between px-4 md:px-8 h-[60px] border-b border-white/5 bg-[rgba(10,10,10,0.95)] backdrop-blur-xl sticky top-0 z-50">
        <img src="/logo-banner.svg" alt="CrossFit OTL" className="h-7 w-auto" />
        <div className="flex items-center gap-4">
          <span className="text-[#666] text-xs hidden md:block">{user.email}</span>
          <button
            onClick={signOut}
            className="text-[#666] hover:text-white text-xs tracking-widest uppercase transition-colors"
          >
            Sign Out
          </button>
        </div>
      </nav>

      {/* Desktop Tab Bar */}
      <div className="hidden md:flex border-b border-white/5 bg-[#0a0a0a] sticky top-[60px] z-40">
        {TABS.map(tab => (
          <button
            key={tab.id}
            onClick={() => setActiveTab(tab.id)}
            className={`px-8 py-4 text-xs font-semibold tracking-[2px] uppercase transition-colors border-b-2 ${
              activeTab === tab.id
                ? 'text-white border-[#003566]'
                : 'text-[#666] border-transparent hover:text-[#a4a4a4]'
            }`}
          >
            {tab.label}
          </button>
        ))}
      </div>

      {/* Content */}
      <main className="flex-1 pb-20 md:pb-0 overflow-y-auto">
        <div className="max-w-3xl mx-auto px-4 py-6">
          {activeTab === 'today' && <Today userId={user.id} />}
          {activeTab === 'practice' && <Practice userId={user.id} />}
          {activeTab === 'progress' && <Progress userId={user.id} />}
        </div>
      </main>

      {/* Mobile Bottom Tab Bar */}
      <nav className="md:hidden fixed bottom-0 left-0 right-0 bg-[#111] border-t border-white/5 flex z-50">
        {TABS.map(tab => (
          <button
            key={tab.id}
            onClick={() => setActiveTab(tab.id)}
            className={`flex-1 py-3 flex flex-col items-center gap-1 transition-colors ${
              activeTab === tab.id ? 'text-white' : 'text-[#555]'
            }`}
          >
            <span className="text-[9px] font-semibold tracking-wider uppercase">{tab.short}</span>
            {activeTab === tab.id && (
              <span className="w-4 h-0.5 bg-[#003566] rounded-full" />
            )}
          </button>
        ))}
      </nav>
    </div>
  )
}
