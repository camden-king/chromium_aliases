# My Bash Aliases for deleveloping on Chromium 

alias alias_version='echo "Now using chromium_aliases version 1.0"'

# Start of day commands
alias gm_mac='gcert && gm'
alias gm='update_chromium_aliases && goma_ctl ensure_start && gclient sync -D && (cd ~/chromium/src; all_b)'

function update_chromium_aliases() {
    (cd ~/chromium_aliases; git pull && cp bash_aliases ~/.bash_aliases)
    source ~/.bash_aliases
    alias_version
}

# Git commands 
alias g_au='git cl format && git add . && git commit --amend && git cl upload'
function g_mu() {
    git cl format
    git add .
    git commit -m *"$1"*
    git cl upload
}
alias g_mm='git fetch origin && git merge origin/main && gclient sync' # merge main into current branch

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

function ut_b_r() {
 ut_b && ut_r
}

# used to run a text multiple times
function run() {
 number=$1
 shift
 for i in seq $number; do
  $@
  echo "Running test : $i" 1>&2
 done
}

export -f bt_r
export -f ut_r
