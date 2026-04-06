import { useState, type FormEvent } from 'react'
import { useAuth } from '../hooks/useAuth'

export default function Login() {
  const { signIn } = useAuth()
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)

  async function handleSubmit(e: FormEvent) {
    e.preventDefault()
    setError('')
    setLoading(true)
    const { error: authError } = await signIn(email, password)
    if (authError) {
      setError('Invalid email or password.')
      setLoading(false)
    }
  }

  return (
    <div
      style={{ fontFamily: "'Inter', sans-serif" }}
      className="min-h-screen bg-[#0a0a0a] flex flex-col items-center justify-center px-4"
    >
      <div className="w-full max-w-sm">
        {/* Logo */}
        <div className="flex justify-center mb-10">
          <img src="/logo-banner.svg" alt="CrossFit OTL" className="h-8 w-auto" />
        </div>

        {/* Card */}
        <div className="bg-[#111] border border-white/5 rounded-xl p-8">
          <h1
            style={{ fontFamily: "'Bebas Neue', sans-serif", letterSpacing: '3px' }}
            className="text-2xl text-white mb-1"
          >
            CCFT STUDY
          </h1>
          <p className="text-[#666] text-sm mb-8">Coach portal — sign in to continue</p>

          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className="block text-[#a4a4a4] text-xs font-medium tracking-widest uppercase mb-2">
                Email
              </label>
              <input
                type="email"
                value={email}
                onChange={e => setEmail(e.target.value)}
                required
                autoComplete="email"
                className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-4 py-3 text-white text-sm placeholder-[#444] focus:outline-none focus:border-[#003566] transition-colors"
                placeholder="coach@crossfit-otl.com"
              />
            </div>

            <div>
              <label className="block text-[#a4a4a4] text-xs font-medium tracking-widest uppercase mb-2">
                Password
              </label>
              <input
                type="password"
                value={password}
                onChange={e => setPassword(e.target.value)}
                required
                autoComplete="current-password"
                className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-4 py-3 text-white text-sm placeholder-[#444] focus:outline-none focus:border-[#003566] transition-colors"
                placeholder="••••••••"
              />
            </div>

            {error && (
              <p className="text-red-400 text-sm">{error}</p>
            )}

            <button
              type="submit"
              disabled={loading}
              className="w-full bg-[#003566] hover:bg-[#004a8f] disabled:opacity-50 disabled:cursor-not-allowed text-white text-xs font-semibold tracking-[2px] uppercase py-3 rounded-lg transition-colors mt-2"
            >
              {loading ? 'Signing in...' : 'Sign In'}
            </button>
          </form>
        </div>

        <p className="text-center text-[#444] text-xs mt-6">
          Access is invite-only. Contact your gym admin.
        </p>
      </div>
    </div>
  )
}
