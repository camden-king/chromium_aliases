# My Bash Aliases for deleveloping on Chromium 

# Start of day commands
alias gm_mac='gcert && goma_ctl ensure_start'
alias gm_linux='goma_ctl ensure_start'

# Git commands 
alias g_au='git cl format && git add . && git commit --amend && git cl upload'
alias g_mm='git fetch origin && git merge origin/master && gclient sync' # merge main into current branch

# Build commands
alias build_default='autoninja -C out/Default'

alias all_b='build_default chrome browser_tests unit_tests'
alias cr_b='build_default chrome'
alias bt_b='build_default browser_tests'
alias ut_b='build_default unit_tests'

function bt_r() {
 testing/run_with_dummy_home.py testing/xvfb.py out/Default/browser_tests --gtest_filter=*$1* 
}
function ut_r() {
 testing/run_with_dummy_home.py testing/xvfb.py out/Default/unit_tests --gtest_filter=*$1* 
}
alias ut_r_all='testing/run_with_dummy_home.py testing/xvfb.py out/Default/unit_tests'

export -f bt_r
export -f ut_r