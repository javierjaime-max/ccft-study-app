import './index.css'

export default function App() {
  return (
    <div
      style={{ fontFamily: "'Inter', sans-serif" }}
      className="min-h-screen bg-[#0a0a0a] text-white flex flex-col"
    >
      {/* Nav */}
      <nav className="flex items-center justify-between px-8 h-[72px] border-b border-white/5 bg-[rgba(10,10,10,0.6)] backdrop-blur-xl">
        <img src="/logo-banner.svg" alt="CrossFit OTL" className="h-9 w-auto" />
        <span
          style={{ fontFamily: "'Bebas Neue', sans-serif", letterSpacing: '3px' }}
          className="text-[#a4a4a4] text-sm"
        >
          CCFT STUDY APP
        </span>
      </nav>

      {/* Main */}
      <div className="flex-1 flex flex-col items-center justify-center px-6 text-center">
        <div
          className="inline-block border border-white/10 text-[#a4a4a4] text-[10px] font-semibold tracking-[3px] uppercase px-4 py-1.5 rounded-full mb-8"
          style={{ background: 'rgba(255,255,255,0.04)' }}
        >
          Coach Certification
        </div>

        <h1
          style={{ fontFamily: "'Bebas Neue', sans-serif", letterSpacing: '4px' }}
          className="text-6xl md:text-8xl mb-4"
        >
          CCFT STUDY
        </h1>

        <p className="text-[#a4a4a4] text-base leading-relaxed max-w-sm mb-10">
          Certification prep for CrossFit OTL coaches.<br />
          Launching soon.
        </p>

        <a
          href="https://crossfit-otl.com"
          className="inline-block bg-[#003566] hover:bg-[#004a8f] text-white text-[11px] font-semibold tracking-[2px] uppercase px-6 py-3 transition-all duration-300"
          style={{ letterSpacing: '2px' }}
        >
          Back to CrossFit OTL
        </a>

        <div className="mt-12 text-[#666] text-xs tracking-widest uppercase">
          app.ccft.crossfit-otl.com
        </div>
      </div>
    </div>
  )
}
