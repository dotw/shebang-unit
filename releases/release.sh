_RELEASED_ARTIFACT_FILENAME='shebang_unit'
_RELEASE_DIRECTORY="$(dirname "${BASH_SOURCE[0]}")"
_SOURCES_DIRECTORY="${_RELEASE_DIRECTORY}/../sources/production"

_ORDERED_SOURCES=('constants.sh' 'system.sh' 'assertion.sh' 'parser.sh' 'runner.sh')

function release::concatenate_sources_in_release_file() {
	release::_initialise_release_file
	release::_concatenate_sources_in_release_file
	release::_append_runner_call_in_release_file
	release::_make_release_file_executable
}

function release::_initialise_release_file() {
	release::_delete_release_file_if_existing
	release::_print_header_in_release_file
}

function release::_concatenate_sources_in_release_file() {
	local file; for file in "${_ORDERED_SOURCES[@]}"; do
		release::_concatenate_source_in_release_file "${_SOURCES_DIRECTORY}/${file}"
	done
}

function release::_append_runner_call_in_release_file() {
	printf "\n# Beginning of executable code\n"  >> "$(release::get_released_artifact_file)"
	printf 'runner::run_all_test_files_in_directory $@' >> "$(release::get_released_artifact_file)"
	printf "\n#End of executable code\n" >> "$(release::get_released_artifact_file)"
}

function release::_delete_release_file_if_existing() {
	echo "$(release::get_released_artifact_file)"
	if [[ -f "$(release::get_released_artifact_file)" ]]; then
		rm "$(release::get_released_artifact_file)"
	fi
}

function release::_print_header_in_release_file() {
	printf "#!/bin/bash\n" >> "$(release::get_released_artifact_file)"
	printf "\n# Shebang unit all in one source file\n" >> "$(release::get_released_artifact_file)"
}

function release::_concatenate_source_in_release_file() {
	local file=$1
	local filename="$(basename "${file}")"
	printf "\n#Beginning of ${filename}\n" >> "$(release::get_released_artifact_file)"
	cat "${file}" >> "$(release::get_released_artifact_file)"
	printf "\n#End of ${filename}\n" >> "$(release::get_released_artifact_file)"
}

function release::_make_release_file_executable() {
	chmod +x "$(release::get_released_artifact_file)"
}

function release::get_released_artifact_file() {
	printf "${_RELEASE_DIRECTORY}/${_RELEASED_ARTIFACT_FILENAME}"
}