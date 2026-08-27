#!/usr/bin/env bash
# usage: window-name.sh <pane_tty> <pane_current_path>

tty="${1#/dev/}"
fallback="$(basename "${2:-/}")"

args=$(ps -t "$tty" -o args= 2>/dev/null | grep -E '^([^ ]*/)?(ssh|autossh|mosh) ' | tail -n1)

if [ -n "$args" ]; then
  # shellcheck disable=SC2086
  set -- $args; shift
  host=""
  while [ $# -gt 0 ]; do
    case "$1" in
      -[BbcDEeFIiJLlmOopQRSWw]) shift 2 ;;
      -*) shift ;;
      *)  host="$1"; break ;;
    esac
  done
  host="${host##*@}"
  host="${host%%:*}"
  if [ -n "$host" ]; then
    host=$(ssh -G "$host" 2>/dev/null | awk '/^hostname /{print $2; exit}') || :
    printf '%s' "${host%%.*}"
    exit 0
  fi
fi
printf '%s' "$fallback"
