// Frontend service for Claude API calls via Supabase Edge Functions.
// The API key never touches the browser — it lives in Supabase secrets.

import { supabase } from './supabase'

export interface ScenarioEvaluation {
  feedback: string
}

/**
 * Evaluate a coach's scenario response using Claude.
 * Calls the evaluate-scenario Edge Function.
 *
 * @param domain - e.g. 'D4'
 * @param scenario - the scenario prompt shown to the coach
 * @param response - what the coach wrote
 */
export async function evaluateScenario(
  domain: string,
  scenario: string,
  response: string
): Promise<ScenarioEvaluation> {
  const { data, error } = await supabase.functions.invoke('evaluate-scenario', {
    body: { domain, scenario, response },
  })

  if (error) throw new Error(error.message)
  return data as ScenarioEvaluation
}
