# #  # fzf-based GitHub repo manager
#
#    gh repo list mdshahjalal5 --json name --jq '.[].name' --limit 200 | \
#    fzf --prompt="Select a repo: " --height=80% \
#        --preview="gh repo view mdshahjalal5/{}" --preview-window=right:60% \
#        --bind "enter:execute-silent(echo -n {} | xclip -selection clipboard)" \
#        --bind "ctrl-o:execute(gh repo view mdshahjalal5/{} --web)" \
#        --bind "ctrl-r:execute(git clone https://github.com/mdshahjalal5/{})"



 gh repo list mdshahjalal5 --json name --jq '.[].name' --limit 200 | \
 fzf --prompt="Select a repo: " --height=80% \
     --preview="gh repo view mdshahjalal5/{}" --preview-window=right:60% \
     --bind "enter:execute-silent(echo -n {} | xclip -selection clipboard)" \
     --bind "ctrl-o:execute(gh repo view mdshahjalal5/{} --web)" \
     --bind "ctrl-r:execute(git clone https://github.com/mdshahjalal5/{})" \
     --bind "ctrl-x:execute-silent(gh repo delete mdshahjalal5/{} --yes)"





