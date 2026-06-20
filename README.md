# CCFT Study Guide

A static, single-page study guide for the **Certified CrossFit Trainer (CCFT)** exam.

- One chapter per source article, grouped by the 7 exam domains (weighted).
- Each chapter: why it matters, what to focus on while reading, concepts to understand,
  the Content Outline tasks it supports, key terms, red flags, and application-style
  self-test scenarios. Links to each source PDF on Google Drive.
- A focused-reading companion — it makes reading the source articles efficient; it does
  not replace them.

## Tech

Pure static HTML/CSS. **No build, no framework, no backend, no AI, no API keys.** The only
interactivity is native HTML `<details>` toggles on the self-test answers.

Deployed on Vercel as a static site (`vercel.json` sets `framework: null`, no build).
The guide is generated offline; `index.html` is the entire product.
