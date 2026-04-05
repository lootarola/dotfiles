#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract data directly from JSON (correct nested paths)
session_costs=$(echo "$input" | jq -r '.cost.total_cost_usd // 0' 2>/dev/null | awk '{printf "%.2f", $1}')
context_used=$(echo "$input" | jq -r '.context_window.used_percentage // ""' 2>/dev/null)
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // ""' 2>/dev/null)
model_name=$(echo "$input" | jq -r '.model.display_name // ""' 2>/dev/null)

# Get git branch (suppress errors if not in a git repo)
git_branch=$(cd "$current_dir" 2>/dev/null && git branch --show-current 2>/dev/null || echo "")

# Get ZMX session name from environment
zmx_session="${ZMX_SESSION}"

# Build status line components
components=()

# ZMX Session (cyan, like in user's zshrc)
if [[ -n "$zmx_session" ]]; then
  components+=("$(printf '\033[36m%s\033[0m' "$zmx_session")")
fi

# Current directory (show last 2 path components)
short_dir=$(echo "$current_dir" | awk -F'/' '{if(NF>2) print $(NF-1)"/"$NF; else print $0}')
components+=("$(printf '\033[34m%s\033[0m' "$short_dir")")

# Git branch (if available, no icon)
if [[ -n "$git_branch" ]]; then
  components+=("$(printf '\033[35m%s\033[0m' "$git_branch")")
fi

# Context used percentage - color code based on usage (no prefix)
if [[ -n "$context_used" && "$context_used" != "null" ]]; then
  # Color code: green when low usage, red when high usage
  if (( $(echo "$context_used > 80" | bc -l) )); then
    color="\033[31m"  # Red for >80% used
  elif (( $(echo "$context_used > 50" | bc -l) )); then
    color="\033[33m"  # Yellow for >50% used
  else
    color="\033[32m"  # Green for <=50% used
  fi
  components+=("$(printf "${color}%.0f%%\033[0m" "$context_used")")
fi

# Session costs - only show if > 0
if [[ -n "$session_costs" && "$session_costs" != "null" && "$session_costs" != "0.00" ]]; then
  components+=("$(printf '\033[33m$%s\033[0m' "$session_costs")")
fi

# Current model
if [[ -n "$model_name" && "$model_name" != "null" ]]; then
  components+=("$(printf '\033[37m%s\033[0m' "$model_name")")
fi

IFS=" | "
echo "${components[*]}"
