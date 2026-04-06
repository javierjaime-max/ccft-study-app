-- Add score tracking to study_sessions
alter table study_sessions add column if not exists claude_score smallint check (claude_score between 1 and 5);
alter table study_sessions add column if not exists session_type text default 'daily';

-- Fault finder attempts
create table if not exists fault_finder_attempts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade not null,
  domain text not null,
  movement text not null,
  scenario text not null,
  fault_options jsonb not null,
  selected_fault text not null,
  cue_response text not null,
  claude_score smallint check (claude_score between 1 and 5),
  claude_feedback text,
  attempted_at timestamptz default now()
);

alter table fault_finder_attempts enable row level security;

create policy "Users can manage own fault finder attempts"
  on fault_finder_attempts for all
  using (auth.uid() = user_id);

create index on fault_finder_attempts(user_id, domain);
create index on fault_finder_attempts(user_id, attempted_at desc);
