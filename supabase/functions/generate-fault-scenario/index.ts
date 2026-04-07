import Anthropic from 'npm:@anthropic-ai/sdk@0.24.3'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const body = await req.json()
    const { domain, movement, action, scenario, fault_options, selected_fault, cue_response } = body

    const apiKey = Deno.env.get('Claude')
    if (!apiKey) {
      return new Response(
        JSON.stringify({ error: 'Missing API key secret' }),
        { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    const client = new Anthropic({ apiKey })

    if (action === 'generate') {
      const message = await client.messages.create({
        model: 'claude-haiku-4-5-20251001',
        max_tokens: 800,
        messages: [
          {
            role: 'user',
            content: `You are a CrossFit Level 3 exam question generator. Create a movement fault identification question.

Domain: ${domain}
Movement: ${movement}

Generate a scenario describing an athlete performing this movement with one or two faults present.
Create 6 fault description options using CrossFit's exact coaching language and points of performance.
One option is the PRIMARY fault (most important to correct first). Others are plausible distractors — real faults or non-issues for this movement.

Return JSON only, no markdown:
{
  "athlete_description": "2-3 sentences describing the athlete mid-movement. Embed one clear primary fault and possibly a secondary one. Use visual/observable language.",
  "fault_options": [
    {"id": "A", "label": "fault description using CrossFit's exact language"},
    {"id": "B", "label": "..."},
    {"id": "C", "label": "..."},
    {"id": "D", "label": "..."},
    {"id": "E", "label": "..."},
    {"id": "F", "label": "..."}
  ],
  "primary_fault_id": "X",
  "primary_fault_explanation": "Why this is the highest priority fault and what CrossFit's framework says about correcting it first"
}`,
          },
        ],
      })

      let text = message.content[0].type === 'text' ? message.content[0].text : '{}'
      text = text.replace(/^```(?:json)?\s*/i, '').replace(/\s*```$/i, '').trim()
      let parsed
      try {
        parsed = JSON.parse(text)
      } catch {
        return new Response(
          JSON.stringify({ error: 'Failed to parse scenario' }),
          { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
        )
      }

      // Strip the answer before sending to frontend
      const { primary_fault_id, primary_fault_explanation, ...safeResponse } = parsed
      // Store answer server-side via a temporary token approach — for now return it encrypted in response
      // For MVP: we evaluate at submission time using Claude's knowledge, no need to store
      return new Response(
        JSON.stringify({
          ...safeResponse,
          _answer_hint: btoa(JSON.stringify({ primary_fault_id, primary_fault_explanation }))
        }),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    if (action === 'evaluate') {
      const message = await client.messages.create({
        model: 'claude-haiku-4-5-20251001',
        max_tokens: 600,
        messages: [
          {
            role: 'user',
            content: `You are a CrossFit Level 3 exam evaluator scoring a fault identification question.

MOVEMENT: ${movement}
SCENARIO:
${scenario}

FAULT OPTIONS PRESENTED:
${JSON.stringify(fault_options, null, 2)}

COACH SELECTED: "${selected_fault}"
COACH'S CUE: "${cue_response}"

Evaluate:
1. Did they identify the PRIMARY fault (the one CrossFit would correct first)?
2. Is their cue CrossFit-appropriate (specific, observable, actionable)?
3. What should they have seen and said?

Return JSON only:
{
  "correct_selection": true|false,
  "primary_fault": "what the primary fault actually was",
  "feedback": "3-4 sentences: correct/incorrect, why this fault is primary, what an ideal cue sounds like",
  "score": <1-5>,
  "cue_assessment": "one sentence on whether their cue matches CrossFit's language"
}`,
          },
        ],
      })

      let text = message.content[0].type === 'text' ? message.content[0].text : '{}'
      text = text.replace(/^```(?:json)?\s*/i, '').replace(/\s*```$/i, '').trim()
      let parsed
      try {
        parsed = JSON.parse(text)
      } catch {
        parsed = { feedback: text, score: 3, correct_selection: false, primary_fault: '', cue_assessment: '' }
      }

      return new Response(
        JSON.stringify(parsed),
        { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    return new Response(
      JSON.stringify({ error: 'Invalid action' }),
      { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )

  } catch (err) {
    return new Response(
      JSON.stringify({ error: String(err) }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
