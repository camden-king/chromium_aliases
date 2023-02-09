# My Bash Aliases for deleveloping on Chromium 

alias alias_version='echo "Now using chromium_aliases version 1.0"'

# Start of day commands
alias gm_mac='gcert && export PATH="$PATH:/Users/camdenking/depot_tools" && gm'
alias gm='update_chromium_aliases && goma_ctl ensure_start && gclient sync -D && (cd ~/chromium/src; all_b)'

function update_chromium_aliases() {
    (cd ~/chromium_aliases; git pull && cp bash_profile ~/.bash_profile)
    source ~/.bash_profile
    alias_version
}

# Git commands 
# TODO: add a check here similar to https://github.com/camden-king/chromium_aliases/commit/c790ae14f4ff429e566cb032ecfc534168c87c34 which was reverted
alias g_au='git add . && git commit --amend && git cl upload'
alias g_cu='g_mu'
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
alias b_all='all_b'
alias cr_b='build_default chrome'
alias b_cr='cr_b'
alias bt_b='build_default browser_tests'
alias b_bt='bt_b'
alias ut_b='build_default unit_tests'
alias b_ut='ut_b'

alias cr_r='./out/Default/chrome --enable-logging --user-data-dir=$HOME/Documents/test_data'
alias cr_r_mac='out/Default/Chromium.app/Contents/MacOS/Chromium'

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
