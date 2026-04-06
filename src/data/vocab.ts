// Terms now live in Supabase `vocab_terms` table.
// Use the useVocabTerms() hook to fetch at runtime.
// See: supabase/migrations/20260405000002_vocab_terms.sql (seed batch 1)
//      supabase/migrations/20260405000003_vocab_terms_seed_batch2.sql
//      supabase/migrations/20260405000004_vocab_terms_seed_batch3.sql

export interface VocabTerm {
  term: string
  def: string
  src: string
  domains: string[]
}

export const DOMAIN_COLORS: Record<string, string> = {
  D1: '#6366f1',
  D2: '#2563eb',
  D3: '#0891b2',
  D4: '#c41e3a',
  D5: '#7c3aed',
  D6: '#16a34a',
  D7: '#b45309',
}

export const DOMAIN_LABELS: Record<string, string> = {
  D1: 'Screening',
  D2: 'Programming',
  D3: 'Educating',
  D4: 'Training',
  D5: 'Leadership',
  D6: 'Lifestyle',
  D7: 'Professional',
}
