function system__get_string_or_default() {
	[[ -n "$1" ]] \
	  && system__print "$1" \
	  || system__print "$2"
}

function system__get_date_in_seconds() {
	date +%s
}

function system__print_line_with_color() {
  system__print_with_color "$@"
  system__print_new_line
}

function system__print_with_color() {
	if [[ "${SBU_USE_COLORS}" == "${SBU_YES}" ]]; then
		printf "$2$1${SBU_DEFAULT_COLOR_CODE}"
	else
		system__print "$1"
	fi
}

function system__print_line() {
  system__print "$1"
  system__print_new_line
}


function system__print() {
  printf "%s" "$1"
}

function system__print_new_line() {
  printf "\n"
}

function system__array_contains() {
	local value=$1
	shift 1
	local i
	for (( i=1; i <= $#; i++ )); do
		if [[ "${!i}" == "${value}" ]]; then
			return ${SBU_SUCCESS_STATUS_CODE}
		fi
	done
	return ${SBU_FAILURE_STATUS_CODE}
}

function system__print_array() {
  local element
  for element in "$@"; do
    system__print_line "${element}"
  done
}

function system__pretty_print_array() {
	local array_as_string=""
	local i
	for (( i=1; i <= $#; i++ )); do
		array_as_string+="${!i}, "
	done
	array_as_string=${array_as_string/%, /}
	printf "[%s]" "${array_as_string}"
}

function system__string_contains() {
	[[ "$1" == *"$2"* ]]
}

function system__randomize_array() {
  local copy=("$@")
  while (( ${#copy[@]} > 0 )); do
    local random_index=$(( $(system__random) % ${#copy[@]} ))
    system__print_line "${copy[${random_index}]}"
    unset copy[${random_index}]
    copy=(${copy[@]})
  done
}

function system__random() {
  system__print "${RANDOM}"
}

function system__substitute_variable() {
    local string=$1
    local key="\$\{$2\}"
    local value=$3
    printf "%s" "${string//${key}/${value}}"
}