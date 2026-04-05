# Create Pull Request

Create a GitHub pull request with example-based description generation.

## Instructions

1. Get the current branch name and recent commits

2. Prompt the user for:
   - **Target Branch**: master | develop
   - **Example Section**
      - Ask whether an examples section is needed
      - If yes, ask for type: json | yaml | logs | images
   - **Related Issues**
      - Issue Number
      - Related Issue Type: Related | Fixes | Closes

3. Check if the branch is up-to-date with the target branch:
   - Run: `git fetch origin [Target Branch]`
   - Check if the branch needs rebasing: `git merge-base --is-ancestor origin/[Target Branch] HEAD`
   - If the branch is behind the target branch, ask the user:
     - **Rebase Required**: Yes | No | Cancel
     - If Yes: Run `git rebase origin/[Target Branch]` and handle any conflicts
     - If No: Warn that the PR may include unintended commits and proceed
     - If Cancel: Stop the PR creation process

4. Generate the PR Title:
   - Read all commits introduced in this PR (commits not present in the target branch)
   - Select the most relevant commit message
   - Use it as the PR title

Title Examples:

```
feat: add BindPort functionality to port spec in service definition
feat(worker): add dot flags to worker
fix(telemetry): add status to module spans
chore(deps): bump mvdan.cc/sh/v3 from 3.7.0 to 3.12.0 
enhancement(runner): refactor runner
refactor(worker): renamed worker healthchecks to heartbeat
docs: standardize acronym case
```

5. Generate the PR Description Summary:
   - Analyze the commit history and diff compared to the target branch
   - Write a natural, conversational description of what the PR does

Summary Examples:

```
This PR represents a major architectural refactoring of the service layer, transforming a monolithic design into a modular, maintainable structure. The changes improve code organization, reduce complexity, and enhance testability.
```

```
This PR adds support for GraphQL subscriptions to the API, building on top of the existing Apollo Server integration. Clients can now subscribe to real-time updates for user notifications and data changes.
```

```
Fix unhandled exception issue introduced in #[Related Issues] which caused the application to hang when encountering invalid input.
```

6. Generate the Description Header (emoji + title):
   - Choose an emoji that represents the type of changes
   - Write a concise title summarizing the overall changes
   - Format as: `# [emoji] [Title]`

Description Header Examples:
```
# ♾️ Fix Infinite Imports Cycle Validation
# 🔒 Default nonroot User
# 🏗️ Refactor Runner
# ⏳ Steps Timeout
```

7. Generate the Changes List:
   - Read all commit messages
   - Read the actual code changes in modified files
   - Identify the main changes introduced by this PR
   - Create a bulleted list where each item:
     - Starts with a relevant emoji
     - Describes one main change concisely

Changes List Examples:

- 🔒 Added security object to pipeline definitions.
- ✨ Support for customizing user and groups on steps and services.
- 👤 Containers will run as nonroot user (65532) by default.
- 🐛 Fix service container and network not correctly being removed on healthcheck error.
- 🏠 Local host runtime implementation.
- 🔧 File utils adjustments for more flexibility
- 🧹 Clean unused configurations
- ⏲️ Timeout field on step definition.
- 📜 Timeout documentation.
- 📝 Friendly error logs on cancellation (CTRL-C) and timeouts.
- 📈 Improve OpenTelemetry logs hierarchy, now correctly sets sub processes where they belong.
- 🧑‍💻 Add graceful shutdowns and forced exits from interruption and termination signals.
- 🧵 Update context implementation, making it easier to implement timeouts, shutdowns, cancellation signals and error handling.
- 🔥 Remove context variables on docker and podman runtime implementations.

8. Generate the Example Section (based on user-selected type):

   **For custom types or unrecognized types:**
   - Create `### Before` and `### After` subsections
   - Find the most relevant code changes in the diff
   - Write a code snippet showing the target branch version (Before)
   - Write a code snippet showing the new version (After), highlighting the biggest changes
   - Use code blocks with the appropriate language type (auto-detect from file extension)

   **For type `yaml`:**
   - Look for changes in YAML configuration files
   - Check `./test*`, `./e2e*`, `./docs`, `./examples`, and `*.md` files for usage examples
   - If examples are found, adapt them; otherwise create a new YAML example demonstrating the change
   - Use a code block with the `yaml` language type

   **For type `json`:**
   - Create `### Before` and `### After` subsections
   - Find JSON configuration, API response, or schema changes in the diff
   - Write a JSON snippet showing the target branch version (Before)
   - Write a JSON snippet showing the new version (After), highlighting the changes
   - Use code blocks with the `json` language type

   **For type `logs`:**
   - Create `### Before` and `### After` subsections
   - Look for changes to CLI commands or application output
   - Write example command execution and an output placeholder TODO:command output showing the change
   - Use code blocks with the `LogTalk` language type

   **For type `images`:**
   - Create `### Before` and `### After` subsections
   - Add image placeholder markdown: `![Before](TODO: upload before image)` and `![After](TODO: upload after image)`
   - Instruct the user to upload images after creating the PR to show visual changes (UI, architecture diagrams, performance screenshots, etc.)

9. Format the final PR Description:

   ```
   [Description Header with emoji and title]

   [Summary]

   ## Changes
   [Changes list with emojis]

   ## Example
   [Example section if requested]

   ## Related
   [Related Issue Type] #[Issue Number]
   ```

10. Push the current branch to origin (if not already pushed)

11. Create the PR:
    - Show the [PR Title] and [Description] to the user and ask for confirmation
    - Run: `gh pr create --base [Target Branch] --title "[PR Title]" --body "[Description]"`
    - Display the created PR URL to the user

## Notes
- The description should be conversational but technical
- Focus on the "what" and "why", not the "how" (code speaks for itself)
- Match the tone to the PR type (features = capabilities, bugfixes = root cause, refactors = benefits)
- Ensure gh CLI is installed and authenticated
