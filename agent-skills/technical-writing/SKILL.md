---
name: technical-writing
description: Guidelines for drafting and revising non-creative technical text, including engineering blogs, papers, documentation, RFCs, and postmortems. Enforces direct, literal, unadorned prose, removes AI writing cliches and mannered metaphors, and prioritizes author consultation over guessing.
---

# Technical Writing Style Guide

Use this guide whenever drafting or editing non-creative text: blog posts, papers, design documents, postmortems, and READMEs.

## 1. Core Principles
- **Convey, do not perform**: Prose exists to explain mechanisms, decisions, and data. Do not showcase the writer.
- **Literal over figurative**: If a literal technical phrase exists, use it. Never substitute a mechanism with a metaphor.
- **Data-backed precision**: Use exact figures, percentages, and benchmark values from source documents.

## 2. Source Data and Verification
- **Prioritize provided documents**: If reference documents, notes, or data files are already provided, rely on them as the primary source of truth.
- **Conditional script execution**: Do not run arbitrary commands or scripts by default. Only run scripts or search commands if:
  1. The user explicitly asks to verify or compute data, or
  2. Specific required metrics are missing from the provided material and must be extracted.
- **Never fabricate metrics**: If a number, baseline, or configuration parameter is not in the source material, do not approximate it.

## 3. Ambiguity and Consultation
- **Ask rather than guess**: If an experimental setup, data point, or technical concept is ambiguous, inconsistent, or confusing, stop and ask the user for clarification before continuing.
- **Do not smooth over gaps**: If a logical gap or missing step exists in the explanation, explicitly flag it to the user instead of inventing a bridge.

## 4. Prohibited AI Vocabulary & Clichés
Never use these words or their variants:
- *delve / delve into* -> examine, analyze, inspect, test
- *pivotal / crucial / critical / vital* -> necessary, required, central (or state the specific consequence)
- *testament / testament to* -> evidence of, indicates, demonstrates
- *tapestry / mosaic / ecosystem* -> architecture, system, components
- *foster / cultivate* -> enable, produce, build
- *intricate / complex landscape* -> state the specific variables or constraints
- *seamless / effortlessly* -> describe the actual protocol or automated mechanism
- *meticulous / painstakingly* -> systematic, standard, or omit
- *realm of / sphere of* -> in [domain], e.g., "in distributed systems"

## 5. Syntax & Style Rules
- **No Em Dashes (`—`)**: Use parentheses, commas, or split the thought into two sentences.
- **Strip Unearned Adjectives**: Remove intensifiers like "remarkable," "striking," "fascinating," or "game-changing." Present the evidence and allow the reader to judge.
- **Remove Mannered Metaphors**:
  - Avoid: *"A dial worth turning."* -> Use: *"A parameter worth adjusting."*
  - Avoid: *"Navigating the data."* -> Use: *"Parsing the data."*
  - Avoid: *"This point earns its keep."* -> Use: *"This point matters."*
- **No Conversational Bookends**: Avoid filler transitions like "It is worth noting that...", "Importantly,...", or formulaic summaries like "In conclusion, the future is bright."
