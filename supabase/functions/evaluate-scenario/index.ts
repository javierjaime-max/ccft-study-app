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
    const { scenario, response, domain } = await req.json()

    if (!scenario || !response || !domain) {
      return new Response(
        JSON.stringify({ error: 'Missing scenario, response, or domain' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    const apiKey = Deno.env.get('Claude')
    if (!apiKey) {
      return new Response(
        JSON.stringify({ error: 'Missing API key secret' }),
        { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    const client = new Anthropic({ apiKey })

    const message = await client.messages.create({
      model: 'claude-haiku-4-5-20251001',
      max_tokens: 600,
      messages: [
        {
          role: 'user',
          content: `You are a CCFT (CrossFit Level 3) exam evaluator. A coach answered a scenario in domain ${domain}.

SCENARIO:
${scenario}

COACH'S RESPONSE:
${response}

Evaluate using CrossFit's framework. Be direct and specific.

Return JSON only, no markdown:
{
  "feedback": "3-4 sentences: what they got right, what's missing, one key exam point",
  "score": <1-5 integer where 1=missing key concepts, 3=adequate application, 5=expert level>,
  "key_concepts": ["concept1", "concept2"]
}`,
        },
      ],
    })

    let text = message.content[0].type === 'text' ? message.content[0].text : '{}'
    // Strip markdown code fences if Claude wraps the JSON
    text = text.replace(/^```(?:json)?\s*/i, '').replace(/\s*```$/i, '').trim()
    let parsed: { feedback: string; score: number; key_concepts: string[] }
    try {
      parsed = JSON.parse(text)
    } catch {
      parsed = { feedback: text, score: 3, key_concepts: [] }
    }

    return new Response(
      JSON.stringify(parsed),
      { headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  } catch (err) {
    return new Response(
      JSON.stringify({ error: String(err) }),
      { status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
