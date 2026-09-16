# Agent Skills

This directory serves as the centralized, version-controlled source of truth for modular AI agent skills across different CLI agent harnesses.

Skills defined here use progressive disclosure (a `SKILL.md` file with YAML frontmatter). The companion script, `symlink-agent-skills.sh`, synchronizes these skills to the global discovery paths of supported agent tools using symbolic links.

## Directory Structure

```text
agent-skills/
├── README.md                  # Documentation
├── symlink-agent-skills.sh    # Synchronization script
└── technical-writing/         # Example skill directory
    └── SKILL.md               # Skill definition and instructions
```

Each skill must reside in its own subdirectory and contain a valid `SKILL.md` file.

## Supported Agent Targets

The script currently supports the following targets:

| Target Key | Agent Harness | Global Discovery Path | Mechanism |
| :--- | :--- | :--- | :--- |
| `gemini` | Google Antigravity / Gemini CLI (`agy`) | `~/.gemini/config/skills/` | On-demand skill activation via progressive disclosure |
| `oh-my-pi` | Oh My Pi CLI (`omp`) | `~/.agents/skills/` | Home-level skill directory discovery |

## Usage

Make the script executable if it is not already:

```bash
chmod +x symlink-agent-skills.sh
```

### 1. List Available Targets and Skills
Inspect the registered target harnesses and local skills without modifying files:

```bash
./symlink-agent-skills.sh --list
```

### 2. Preview Changes (Dry-Run)
Check the symlinks that will be created:

```bash
./symlink-agent-skills.sh --dry-run
```

### 3. Synchronize All Targets
Link all available skills to all registered agent harnesses:

```bash
./symlink-agent-skills.sh
# or explicitly:
./symlink-agent-skills.sh all
```

### 4. Synchronize a Specific Target
To sync only a specific agent harness, pass its target key:

```bash
./symlink-agent-skills.sh gemini
./symlink-agent-skills.sh oh-my-pi
```

## Adding a New Skill

1. Create a subdirectory under `agent-skills/` named after the skill:
   ```bash
   mkdir -p agent-skills/<skill-name>
   ```
2. Add a `SKILL.md` file with YAML frontmatter:
   ```markdown
   ---
   name: <skill-name>
   description: Specific description of what this skill does and when to activate it.
   ---

   # Skill Title

   Instructions and rules for the agent.
   ```
3. Run `./symlink-agent-skills.sh` to link the new skill to your agent harnesses.

## Adding a New Agent Target

To support an additional agent harness:

1. Open `symlink-agent-skills.sh`.
2. Add the target key to `REGISTERED_TARGETS`:
   ```bash
   REGISTERED_TARGETS=("gemini" "oh-my-pi" "new-agent")
   ```
3. Add the mapping cases in `get_target_path` and `get_target_description`:
   ```bash
   get_target_path() {
       local target="$1"
       case "$target" in
           "gemini")    echo "$HOME/.gemini/config/skills" ;;
           "oh-my-pi")  echo "$HOME/.agents/skills" ;;
           "new-agent") echo "$HOME/.config/new-agent/skills" ;;
           *)           return 1 ;;
       esac
   }
   ```
