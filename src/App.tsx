import './index.css'
import { useAuth } from './hooks/useAuth'
import Login from './components/Login'
import Layout from './components/Layout'

export default function App() {
  const { user, loading } = useAuth()

  if (loading) return <div className="min-h-screen bg-[#0a0a0a]" />
  if (!user) return <Login />
  return <Layout user={user} />
}
