// Frontend service for Claude API calls via Supabase Edge Functions.
// API key never touches the browser — lives in Supabase secrets.

import { supabase } from './supabase'

export interface ScenarioEvaluation {
  feedback: string
  score: number
  key_concepts: string[]
}

export interface FaultScenario {
  athlete_description: string
  fault_options: { id: string; label: string }[]
  _answer_hint: string
}

export interface FaultEvaluation {
  correct_selection: boolean
  primary_fault: string
  feedback: string
  score: number
  cue_assessment: string
}

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

export async function generateFaultScenario(
  domain: string,
  movement: string
): Promise<FaultScenario> {
  const { data, error } = await supabase.functions.invoke('generate-fault-scenario', {
    body: { action: 'generate', domain, movement },
  })
  if (error) throw new Error(error.message)
  return data as FaultScenario
}

export async function evaluateFaultResponse(
  movement: string,
  scenario: string,
  fault_options: { id: string; label: string }[],
  selected_fault: string,
  cue_response: string
): Promise<FaultEvaluation> {
  const { data, error } = await supabase.functions.invoke('generate-fault-scenario', {
    body: { action: 'evaluate', movement, scenario, fault_options, selected_fault, cue_response },
  })
  if (error) throw new Error(error.message)
  return data as FaultEvaluation
}
