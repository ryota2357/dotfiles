function fish_prompt
    set -l dir (set_color yellow)(pwd)(set_color normal)
    set -l next $(set_color brgreen)"❯ "$(set_color normal)

    if test (git rev-parse --is-inside-work-tree 2> /dev/null)
        set -l branch_name (git rev-parse --abbrev-ref HEAD)
        echo -e "\n$dir  $branch_name\n$next"
    else
        echo -e "\n$dir\n$next"
    end
end
