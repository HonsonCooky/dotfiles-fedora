# PS1 Prompt
# Two-line prompt: path + git branch + timestamp, then prompt character.
# Uses standard ANSI colors so the prompt follows the terminal theme.

# -- Colors (terminal palette) ----------------------------------------------- #
__C_BLUE='\[\e[34m\]'
__C_YELLOW='\[\e[33m\]'
__C_GREEN='\[\e[32m\]'
__C_RED='\[\e[31m\]'
__C_DIM='\[\e[2m\]'
__C_RESET='\[\e[0m\]'

# -- Git branch -------------------------------------------------------------- #
__git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    [ -n "$branch" ] && echo "$branch"
}

# -- Build prompt ------------------------------------------------------------- #
__build_prompt() {
    local exit_code=$?

    local branch
    branch=$(__git_branch)

    local git_info=""
    if [ -n "$branch" ]; then
        git_info=" ${__C_YELLOW}${branch}${__C_RESET}"
    fi

    # Show user@host when SSHed in, so you know which machine you're on
    local host_info=""
    if [ -n "$SSH_CONNECTION" ]; then
        host_info="${__C_DIM}\u@\h ${__C_RESET}"
    fi

    local timestamp="${__C_DIM}\A${__C_RESET}"

    # Prompt character: green if last command succeeded, red if it failed
    local prompt_char="${__C_GREEN}>>${__C_RESET}"
    if [ $exit_code -ne 0 ]; then
        prompt_char="${__C_RED}>>${__C_RESET}"
    fi

    PS1="\n${host_info}${__C_BLUE}\w${__C_RESET}${git_info} ${timestamp}\n${prompt_char} "
}

PROMPT_COMMAND=__build_prompt
