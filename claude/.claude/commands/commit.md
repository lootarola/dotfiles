# Commit Changes

Analyze all changes, group them by logical concern, and create conventional commits automatically.

## Conventional Commits Reference

Types (select the dominant one based on the diff):
- `feat` — new capability, behavior, or user-facing functionality
- `fix` — bug fix, error correction, incorrect behavior
- `refactor` — code restructuring with no behavior change
- `chore` — dependencies, tooling, config, build scripts, maintenance
- `enhancement` — improve an existing feature (not a new one)
- `docs` — documentation only
- `test` — add or update tests
- `style` — formatting, whitespace, linting (no logic change)
- `perf` — performance improvement
- `ci` — CI/CD pipeline changes
- `build` — build system or external dependency changes
- `revert` — revert a previous commit

Subject line rules:
- Format: `type(scope): description` or `type: description`
- Imperative mood: "add", not "added" or "adds"
- Lowercase after colon
- No period at end
- Max 72 characters
- Must complete the sentence: "If applied, this commit will ___"

Scope rules:
- Derive from the common directory, package, or module of changed files
- If all changes are in `pkg/worker/`, scope is `worker`
- If all changes are in `src/components/`, scope is `components`
- If changes span multiple top-level directories or have no clear grouping, omit scope
- Prefer the most specific meaningful boundary

Body rules (only when needed):
- Separate from subject with a blank line
- Explain what and why, not how
- Bullet points for multiple secondary concerns
- Add `BREAKING CHANGE:` footer if public API or interface changes

## Instructions

1. Check the working tree state:
   - Run `git status` to see all changes
   - If there are no changes at all (clean tree, no untracked files): tell the user there is nothing to commit and stop
   - If there are unmerged paths: tell the user to resolve merge conflicts first and stop

2. Gather all changes:
   - Run `git add -A` to stage everything
   - Scan for sensitive files matching: `.env*`, `*.pem`, `*.key`, `*.p12`, `*.pfx`, `*credentials*`, `*secret*`
   - If sensitive files are found: warn the user, unstage them with `git reset HEAD <file>`, and proceed with the rest
   - Run `git diff --cached --stat` for the full file-level overview
   - Run `git diff --cached --name-only` to get the complete list of changed files

3. Analyze and group changes:
   - Read the staged diff (`git diff --cached`) to understand what changed
   - If the diff is very large (50+ files), focus on `--stat` output and read only representative files per group
   - Check `git log --oneline -10` to match the project's existing commit style
   - Group the changed files into logical commits using these criteria, in priority order:
     1. **By clear type separation** — test files (`*_test.*`, `*_spec.*`, `test/**`, `tests/**`, `__tests__/**`) go in a `test:` commit; docs (`*.md`, `docs/**`) go in a `docs:` commit; CI/CD (`.github/**`, `.gitlab-ci*`, `Jenkinsfile`, `.circleci/**`) go in a `ci:` commit
     2. **By module/scope** — files in the same package/directory that serve the same purpose form a group (e.g., all changes in `pkg/auth/` for a new auth feature)
     3. **By logical concern** — a bug fix touching files across directories still belongs in one `fix:` commit if they address the same issue
   - If all changes are cohesive (same type, same scope, same concern): use a single commit — do not split for the sake of splitting
   - Each group gets: a type, an optional scope, and the list of files it contains

   Grouping example for 100 files:
   ```
   Group 1: feat(runner)    → src/runner/timeout.go, src/runner/context.go, src/runner/config.go
   Group 2: fix(worker)     → src/worker/healthcheck.go, src/worker/cleanup.go
   Group 3: test(runner)    → src/runner/timeout_test.go, src/runner/context_test.go
   Group 4: chore(deps)     → go.mod, go.sum
   Group 5: docs            → README.md, docs/timeouts.md
   ```

4. Check for amend candidates (per group):
   - Determine if the branch tracks a remote: `git rev-parse --abbrev-ref @{upstream}` (if this fails, all commits are local)
   - If the branch tracks a remote, get unpushed commits: `git log --oneline @{upstream}..HEAD`
   - For each group, check if an unpushed commit touches overlapping files AND has a matching type/scope
   - If a match is found: mark that group as an amend candidate (note which commit)

5. Generate commit messages:
   - For each group, generate a conventional commit message
   - Select the type based on the group's content
   - Derive scope from the group's file paths
   - Add a body only when the group has multiple sub-concerns or non-obvious rationale

   Subject Examples:

   ```
   feat: add bind-port functionality to port spec
   ```

   ```
   fix(telemetry): add status to module spans
   ```

   ```
   refactor(worker): rename healthchecks to heartbeat
   ```

   With body:

   ```
   feat(runner): add timeout support for step execution

   - Add timeout field to step definition schema
   - Update context implementation for timeout propagation
   - Fix service container cleanup on healthcheck timeout
   ```

   ```
   chore(deps): bump go dependencies

   - mvdan.cc/sh/v3 from 3.7.0 to 3.12.0
   - golang.org/x/tools from 0.20.0 to 0.21.0

   BREAKING CHANGE: minimum Go version is now 1.22
   ```

6. Present the commit plan to the user:
   - Show all groups with their commit messages in the order they will be committed
   - For amend candidates: indicate which existing commit will be amended
   - Show the files in each group
   - Wait for the user to confirm, request changes, or cancel
   - If cancelled: run `git reset HEAD` to unstage everything and stop

   Example output:
   ```
   Commit plan (4 commits):

   1. feat(runner): add timeout support for step execution
      → src/runner/timeout.go, src/runner/context.go, src/runner/config.go

   2. fix(worker): fix healthcheck cleanup on error
      → src/worker/healthcheck.go, src/worker/cleanup.go
      ⟳ amends: abc1234 fix(worker): add healthcheck error handling

   3. test(runner): add timeout tests
      → src/runner/timeout_test.go, src/runner/context_test.go

   4. chore(deps): bump go dependencies
      → go.mod, go.sum
   ```

7. Execute commits in order:
   - Do NOT include `Co-Authored-By` trailers or any AI attribution
   - For each group:
     - Reset the staging area: `git reset HEAD`
     - Stage only the group's files: `git add <file1> <file2> ...`
     - If amending: `git commit --amend -m "<message>"`
     - If new commit: `git commit -m "<message>"`
     - Use a HEREDOC for multi-line messages:
       ```
       git commit -m "$(cat <<'EOF'
       type(scope): subject

       - body line 1
       - body line 2
       EOF
       )"
       ```

8. Show result:
   - Run `git log --oneline -<N>` where N is the number of commits created
   - Display all the new/amended commits

## Notes
- If all changes are cohesive, make a single commit — grouping is for when changes span multiple concerns
- Prefer clean subject-only messages; add body only when it provides real signal
- When in doubt about type: `feat` for new things, `fix` for corrections, `refactor` for restructuring
- Only suggest amending unpushed commits — never amend commits already on the remote
- For scope: if the scope would be the project root or overly generic (e.g., `src`), omit it
- Keep the message about what changed, not how the code works
- Commit order: infrastructure/config first, then features/fixes, then tests, then docs
