
 # fzf-based GitHub repo manager
#
  gh repo list ProgrammingHero1  --json name --jq '.[].name' --limit 200 | \
  fzf --prompt="Select a repo: " --height=80% \
      --preview="gh repo view ProgrammingHero1/{}" --preview-window=right:60% \
      --bind "enter:execute-silent(echo -n {} | xclip -selection clipboard)" \
      --bind "ctrl-o:execute(gh repo view ProgrammingHero1/{} --web)" \
      --bind "ctrl-r:execute(git clone https://github.com/ProgrammingHero1/{})"



