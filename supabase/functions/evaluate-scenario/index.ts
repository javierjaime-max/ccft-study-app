// Supabase Edge Function — evaluate-scenario
// Calls Claude API to evaluate a coach's scenario response.
// ANTHROPIC_API_KEY is set as a Supabase secret (never exposed to browser).
//
// Deploy: supabase functions deploy evaluate-scenario
// Secret:  supabase secrets set ANTHROPIC_API_KEY=sk-ant-...

import Anthropic from 'npm:@anthropic-ai/sdk@0.24.3'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  const { scenario, response, domain } = await req.json()

  if (!scenario || !response || !domain) {
    return new Response(
      JSON.stringify({ error: 'Missing scenario, response, or domain' }),
      { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }

  const client = new Anthropic({ apiKey: Deno.env.get('ANTHROPIC_API_KEY') })

  const message = await client.messages.create({
    model: 'claude-haiku-4-5-20251001',
    max_tokens: 400,
    messages: [
      {
        role: 'user',
        content: `You are a CCFT (CrossFit Certified Trainer) exam evaluator. A coach is studying for the CCFT Level 3 exam and just answered a scenario in domain ${domain}.

SCENARIO:
${scenario}

COACH'S RESPONSE:
${response}

Evaluate the response in 3-4 sentences. Be direct and specific:
1. What they got right
2. What's missing or incorrect (if anything)
3. One key thing to remember for the exam

Keep it tight — this is exam prep, not coaching. No filler.`,
      },
    ],
  })

  const feedback = message.content[0].type === 'text' ? message.content[0].text : ''

  return new Response(
    JSON.stringify({ feedback }),
    { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
  )
})
