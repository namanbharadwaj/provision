function fish_prompt
	
  if not set -q -g __fish_robbyrussell_functions_defined
    set -g __fish_robbyrussell_functions_defined
    function _git_branch_name
      echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
    end
	
    function _is_git_dirty
      echo (git status -s --ignore-submodules=dirty ^/dev/null)
    end
  end

  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l normal (set_color normal)

  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)

    if [ (_is_git_dirty) ]
      set git_info " $yellow$git_branch"
    else
      set git_info " $cyan$git_branch"
    end
  end

  if [ (whoami) = "root" ]
    set me sudo
    set me "$red$me "
  end

  set -l cwd (prompt_pwd)
  if set -q VIRTUAL_ENV
    set cwd "$cwd ×"
  end
  set cwd "$blue$cwd"

  set -l arrow " $normal➜ "

  echo -n -s "$me$venv$cwd$git_info$arrow"
end