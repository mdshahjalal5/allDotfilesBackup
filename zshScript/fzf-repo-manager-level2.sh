

 # fzf-based GitHub repo manager
#
  gh repo list Apollo-Level2-Web-Dev   --json name --jq '.[].name' --limit 200 | \
  fzf --prompt="Select a repo: " --height=80% \
      --preview="gh repo view  Apollo-Level2-Web-Dev/{}" --preview-window=right:60% \
      --bind "enter:execute-silent(echo -n {} | xclip -selection clipboard)" \
      --bind "ctrl-o:execute(gh repo view Apollo-Level2-Web-Dev/{} --web)" \
      --bind "ctrl-r:execute(git clone https://github.com/Apollo-Level2-Web-Dev/{})"


