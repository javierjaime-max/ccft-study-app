import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
import type { VocabTerm } from '../data/vocab'

interface UseVocabTermsResult {
  terms: VocabTerm[]
  loading: boolean
}

export function useVocabTerms(): UseVocabTermsResult {
  const [terms, setTerms] = useState<VocabTerm[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    supabase
      .from('vocab_terms')
      .select('term, definition, source, domains')
      .order('term', { ascending: true })
      .then(({ data }) => {
        setTerms(
          (data ?? []).map(row => ({
            term: row.term,
            def: row.definition,
            src: row.source,
            domains: row.domains,
          }))
        )
        setLoading(false)
      })
  }, [])

  return { terms, loading }
}
