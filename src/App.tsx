import './index.css'

export default function App() {
  return (
    <div className="min-h-screen bg-[#111] text-[#e8e8e8] flex flex-col items-center justify-center px-4">
      <div className="text-center max-w-md">
        <div className="inline-block bg-[#c41e3a] text-white text-xs font-bold tracking-widest uppercase px-3 py-1 rounded-full mb-6">
          CrossFit OTL
        </div>
        <h1 className="text-4xl font-bold mb-3 tracking-tight">
          <span className="text-[#c41e3a]">CCFT</span> Study App
        </h1>
        <p className="text-[#888] text-base leading-relaxed mb-8">
          Coach certification prep for CrossFit OTL trainers.
          Coming soon — check back shortly.
        </p>
        <div className="text-[#555] text-sm">
          app.ccft.crossfit-otl.com
        </div>
      </div>
    </div>
  )
}
