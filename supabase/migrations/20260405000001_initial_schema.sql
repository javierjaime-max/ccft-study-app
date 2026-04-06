-- =============================================
-- CCFT Study App — Initial Schema
-- =============================================

-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- =============================================
-- TABLE: study_sessions
-- One row per daily study session completed
-- =============================================
create table public.study_sessions (
  id            uuid primary key default uuid_generate_v4(),
  user_id       uuid not null references auth.users(id) on delete cascade,
  completed_at  timestamptz not null default now(),
  domain        text not null,           -- D1–D7
  part1_term    text,                    -- concept term shown
  part2_term    text,                    -- vocabulary bridge term shown
  part2_response text,                   -- coach's written response
  part3_scenario text,                   -- scenario shown
  part3_response text,                   -- coach's written response
  duration_secs integer,                 -- total time in seconds
  notes         text
);

alter table public.study_sessions enable row level security;

create policy "Users can manage their own sessions"
  on public.study_sessions
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- =============================================
-- TABLE: flashcard_progress
-- One row per term per user — upserted on rating
-- =============================================
create table public.flashcard_progress (
  id          uuid primary key default uuid_generate_v4(),
  user_id     uuid not null references auth.users(id) on delete cascade,
  term        text not null,
  status      text not null default 'unseen'
                check (status in ('unseen', 'learning', 'known')),
  last_seen   timestamptz not null default now(),
  unique (user_id, term)
);

alter table public.flashcard_progress enable row level security;

create policy "Users can manage their own flashcard progress"
  on public.flashcard_progress
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- =============================================
-- TABLE: judgment_log
-- One row per judgment call logged
-- =============================================
create table public.judgment_log (
  id           uuid primary key default uuid_generate_v4(),
  user_id      uuid not null references auth.users(id) on delete cascade,
  logged_at    timestamptz not null default now(),
  judged_date  date not null,
  course       text not null,            -- Judges Course, Spot the Flaw, etc.
  movement     text not null,
  called       text,                     -- what the coach called
  standard     text,                     -- what the standard requires
  result       text not null
                check (result in ('Correct', 'Close', 'Missed')),
  notes        text
);

alter table public.judgment_log enable row level security;

create policy "Users can manage their own judgment log"
  on public.judgment_log
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- =============================================
-- TABLE: reading_progress
-- One row per document per user
-- =============================================
create table public.reading_progress (
  id          uuid primary key default uuid_generate_v4(),
  user_id     uuid not null references auth.users(id) on delete cascade,
  doc_id      text not null,             -- matches document ID in app data
  read_at     timestamptz not null default now(),
  unique (user_id, doc_id)
);

alter table public.reading_progress enable row level security;

create policy "Users can manage their own reading progress"
  on public.reading_progress
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- =============================================
-- INDEXES for performance
-- =============================================
create index idx_study_sessions_user_id on public.study_sessions(user_id);
create index idx_study_sessions_completed_at on public.study_sessions(completed_at desc);
create index idx_flashcard_progress_user_id on public.flashcard_progress(user_id);
create index idx_judgment_log_user_id on public.judgment_log(user_id);
create index idx_reading_progress_user_id on public.reading_progress(user_id);
