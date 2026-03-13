# PS1 Prompt
# Two-line prompt: path + git branch, then prompt character.
# Colors loosely based on Ayu palette.

# -- Colors ----------------------------------------------------------------- #
__C_BLUE='\[\e[38;2;57;186;230m\]'
__C_ORANGE='\[\e[38;2;255;180;84m\]'
__C_GREEN='\[\e[38;2;170;217;76m\]'
__C_RED='\[\e[38;2;255;85;85m\]'
__C_DIM='\[\e[38;2;106;115;125m\]'
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
        git_info=" ${__C_DIM}on${__C_RESET} ${__C_ORANGE}${branch}${__C_RESET}"
    fi

    # Show user@host when SSHed in, so you know which machine you're on
    local host_info=""
    if [ -n "$SSH_CONNECTION" ]; then
        host_info="${__C_DIM}\u@\h ${__C_RESET}"
    fi

    # Prompt character: green if last command succeeded, red if it failed
    local prompt_char="${__C_GREEN}>>${__C_RESET}"
    if [ $exit_code -ne 0 ]; then
        prompt_char="${__C_RED}>>${__C_RESET}"
    fi

    PS1="\n${host_info}${__C_BLUE}\w${__C_RESET}${git_info}\n${prompt_char} "
}

PROMPT_COMMAND=__build_prompt
