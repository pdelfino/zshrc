# ┌──────────────────────────────────────────────────────────────────────────────┐
# │                          claude-queue Run Tracker                            │
# │                                                                              │
# │  Wraps `claude-queue` to time every run, log to TSV + org, and print a       │
# │  tidy summary when it finishes.                                              │
# │                                                                              │
# │  Logs:                                                                       │
# │    $XDG_DATA_HOME/claude-queue/history.tsv  (parseable, one row per run)     │
# │    $XDG_DATA_HOME/claude-queue/history.org  (human-readable, one heading     │
# │                                              per run, properties drawer)     │
# └──────────────────────────────────────────────────────────────────────────────┘

claude-queue() {
  local data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/claude-queue"
  mkdir -p "$data_dir"
  local tsv="$data_dir/history.tsv"
  local org="$data_dir/history.org"

  # Resolve to git root if we're in a repo, else just cwd
  local repo_path
  repo_path=$(git rev-parse --show-toplevel 2>/dev/null) || repo_path="$PWD"
  local repo="${repo_path##*/}"

  local args="$*"
  local start_ts=$(date +%s)
  local start_human=$(date '+%Y-%m-%d %H:%M:%S')
  local start_org=$(date '+[%Y-%m-%d %a %H:%M:%S]')

  # Run the real claude-queue
  command claude-queue "$@"
  local exit_code=$?

  local end_ts=$(date +%s)
  local end_human=$(date '+%Y-%m-%d %H:%M:%S')
  local end_org=$(date '+[%Y-%m-%d %a %H:%M:%S]')
  local duration=$((end_ts - start_ts))
  local mm=$((duration / 60))
  local ss=$((duration % 60))

  # Heading-line emoji based on exit
  local status_glyph="✅"
  [[ $exit_code -ne 0 ]] && status_glyph="❌"

  # ── TSV append ───────────────────────────────────────────────────────────────
  # Columns: start_time | repo | full_path | duration_sec | exit_code | args
  printf '%s\t%s\t%s\t%d\t%d\t%s\n' \
    "$start_human" "$repo" "$repo_path" "$duration" "$exit_code" "$args" \
    >> "$tsv"

  # ── Org append ───────────────────────────────────────────────────────────────
  {
    print -- "* $(date '+%Y-%m-%d %H:%M') [$repo] ${mm}m ${ss}s $status_glyph"
    print -- "  :PROPERTIES:"
    print -- "  :CWD:        $repo_path"
    print -- "  :ARGS:       $args"
    print -- "  :STARTED:    $start_org"
    print -- "  :FINISHED:   $end_org"
    print -- "  :DURATION_S: $duration"
    print -- "  :EXIT:       $exit_code"
    print -- "  :END:"
    print -- ""
  } >> "$org"

  # ── Pretty terminal summary ──────────────────────────────────────────────────
  print -P "%F{cyan}── claude-queue done ──%f"
  print  "  repo:     $repo"
  print  "  args:     $args"
  print  "  started:  $start_human"
  print  "  finished: $end_human"
  print  "  duration: ${mm}m ${ss}s"
  print  "  exit:     $exit_code $status_glyph"
  print  "  history:  $tsv"
  print  "            $org"

  return $exit_code
}

# Quick helper: tail the history files
claude-queue-history() {
  local data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/claude-queue"
  local n="${1:-10}"
  if [[ -f "$data_dir/history.tsv" ]]; then
    print -P "%F{cyan}── last $n claude-queue runs ──%f"
    print "start_time\trepo\tduration_sec\texit\targs"
    tail -n "$n" "$data_dir/history.tsv" | awk -F'\t' '{printf "%s\t%s\t%ds\t%d\t%s\n", $1, $2, $4, $5, $6}'
  else
    print "no history yet at $data_dir/history.tsv"
  fi
}
