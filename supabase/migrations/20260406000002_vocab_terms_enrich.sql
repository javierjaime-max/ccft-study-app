-- =============================================
-- CCFT Brain — Enrich vocab_terms schema
-- Add related_terms and parent_term columns
-- =============================================

alter table public.vocab_terms
  add column if not exists related_terms text[] default '{}',
  add column if not exists parent_term   text;

create index if not exists idx_vocab_terms_related
  on public.vocab_terms using gin(related_terms);

create index if not exists idx_vocab_terms_parent
  on public.vocab_terms(parent_term);
