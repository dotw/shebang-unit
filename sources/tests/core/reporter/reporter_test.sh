function setup() {
  source "${TEST_SOURCES_DIR}/core/reporter/mock/cool_reporter.sh"
  source "${TEST_SOURCES_DIR}/core/reporter/mock/lazy_reporter.sh"
}

function can_execute_for_each_reporters() {
  SBU_REPORTERS=toto,tutu
  local read_reporters=""

  reporter__for_each_reporter _put_read_reporter

  configuration_load
  assertion__equal "toto#tutu" "${read_reporters}"
}

function can_call_for_each_reporter__tests_files_end_running() {
  SBU_REPORTERS=cool,lazy

  local messages="$(reporter__tests_files_end_running a b)"

  configuration_load
  local first="cool_reporter__tests_files_end_running with [a, b]"
  local second="lazy_reporter__tests_files_end_running with [a, b]"
  assertion__equal "${first}"$'\n'"${second}" "${messages}"
}

function can_call_for_each_reporter__test_starts_running() {
  SBU_REPORTERS=cool,lazy

  local messages="$(reporter__test_starts_running a b)"

  configuration_load
  local first="cool_reporter__test_starts_running with [a, b]"
  local second="lazy_reporter__test_starts_running with [a, b]"
  assertion__equal "${first}"$'\n'"${second}" "${messages}"
}

function can_call_for_each_reporter__test_has_succeeded() {
  SBU_REPORTERS=cool,lazy

  local messages="$(reporter__test_has_succeeded a b)"

  configuration_load
  local first="cool_reporter__test_has_succeeded with [a, b]"
  local second="lazy_reporter__test_has_succeeded with [a, b]"
  assertion__equal "${first}"$'\n'"${second}" "${messages}"
}

function can_call_for_each_reporter__test_has_failed() {
  SBU_REPORTERS=cool,lazy

  local messages="$(reporter__test_has_failed a b)"

  configuration_load
  local first="cool_reporter__test_has_failed with [a, b]"
  local second="lazy_reporter__test_has_failed with [a, b]"
  assertion__equal "${first}"$'\n'"${second}" "${messages}"
}

function can_call_for_each_reporter__test_file_starts_running() {
  SBU_REPORTERS=cool,lazy

  local messages="$(reporter__test_file_starts_running a b)"

  configuration_load
  local first="cool_reporter__test_file_starts_running with [a, b]"
  local second="lazy_reporter__test_file_starts_running with [a, b]"
  assertion__equal "${first}"$'\n'"${second}" "${messages}"
}

function can_call_for_each_reporter__test_file_ends_running() {
  SBU_REPORTERS=cool,lazy

  local messages="$(reporter__test_file_ends_running a b)"

  configuration_load
  local first="cool_reporter__test_file_ends_running with [a, b]"
  local second="lazy_reporter__test_file_ends_running with [a, b]"
  assertion__equal "${first}"$'\n'"${second}" "${messages}"
}

function can_call_for_each_reporter__assertion_failed() {
  SBU_REPORTERS=cool,lazy

  local messages="$(reporter__assertion_failed a b)"

  configuration_load
  local first="cool_reporter__assertion_failed with [a, b]"
  local second="lazy_reporter__assertion_failed with [a, b]"
  assertion__equal "${first}"$'\n'"${second}" "${messages}"
}

function _put_read_reporter() {
  [[ -z "${read_reporters}" ]] \
    && read_reporters="${reporter}" \
    || read_reporters="${read_reporters}#${reporter}"
}