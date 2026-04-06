import { useState, type FormEvent } from 'react'
import { supabase } from '../lib/supabase'

export default function Login() {
  const [email, setEmail] = useState('')
  const [sent, setSent] = useState(false)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')

  async function handleSubmit(e: FormEvent) {
    e.preventDefault()
    setLoading(true)
    setError('')
    const { error } = await supabase.auth.signInWithOtp({
      email,
      options: { emailRedirectTo: window.location.origin },
    })
    if (error) {
      setError(error.message)
      setLoading(false)
    } else {
      setSent(true)
    }
  }

  return (
    <div
      style={{ fontFamily: "'Inter', sans-serif" }}
      className="min-h-screen bg-[#0a0a0a] flex flex-col items-center justify-center px-6"
    >
      <img src="/logo-banner.svg" alt="CrossFit OTL" className="h-10 w-auto mb-10" />

      <div className="w-full max-w-sm bg-[#111] border border-white/5 rounded-2xl p-8">
        {sent ? (
          <div className="text-center">
            <div className="text-3xl mb-4">✓</div>
            <h2
              style={{ fontFamily: "'Bebas Neue', sans-serif", letterSpacing: '3px' }}
              className="text-2xl text-white mb-3"
            >
              CHECK YOUR EMAIL
            </h2>
            <p className="text-[#666] text-sm leading-relaxed">
              Magic link sent to <span className="text-white">{email}</span>.<br />
              Click it to sign in — no password needed.
            </p>
            <button
              onClick={() => { setSent(false); setEmail('') }}
              className="mt-6 text-[#555] text-xs hover:text-white transition-colors"
            >
              Use a different email
            </button>
          </div>
        ) : (
          <>
            <h2
              style={{ fontFamily: "'Bebas Neue', sans-serif", letterSpacing: '3px' }}
              className="text-2xl text-white mb-1"
            >
              CCFT STUDY
            </h2>
            <p className="text-[#666] text-sm mb-6">Enter your email to get a sign-in link.</p>

            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label className="block text-[#a4a4a4] text-[10px] font-semibold tracking-widest uppercase mb-1.5">
                  Email
                </label>
                <input
                  type="email"
                  value={email}
                  onChange={e => setEmail(e.target.value)}
                  placeholder="coach@crossfit-otl.com"
                  required
                  className="w-full bg-[#0a0a0a] border border-white/10 rounded-lg px-4 py-3 text-white text-sm placeholder-[#444] focus:outline-none focus:border-[#003566] transition-colors"
                />
              </div>

              {error && <p className="text-red-400 text-xs">{error}</p>}

              <button
                type="submit"
                disabled={loading}
                className="w-full bg-[#003566] hover:bg-[#004a8f] disabled:opacity-40 text-white text-xs font-semibold tracking-[2px] uppercase py-3 rounded-lg transition-colors"
              >
                {loading ? 'Sending...' : 'Send Magic Link'}
              </button>
            </form>
          </>
        )}
      </div>
    </div>
  )
}
