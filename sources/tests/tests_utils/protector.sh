protector__protect_symbols() {
  local file=$1
  _protector__protect_all_global_variables "${file}"
  _protector__protect_all_functions "${file}"
}

_protector__protect_all_global_variables() {
  local file=$1
  _protector__sed_in_place "${file}" "s/SBU_STANDARD_FD=42/SBU_STANDARD_FD=52/g"
  _protector__sed_in_place "${file}" "s/SBU_ERROR_FD=43/SBU_ERROR_FD=53/g"
  _protector__sed_in_place "${file}" "s/SBU_/SBU_COPY_/g"
  _protector__sed_in_place "${file}" "s/sbu_/sbu_copy_/g"
}

_protector__protect_all_functions() {
  local file=$1
  release__execute_for_each_module \
    _protector__protect_all_module_functions ${file}
}

_protector__protect_all_module_functions() {
  local module="$(_protector__get_module_from_path ${module_path})"
  _protector__sed_in_place "${file}" "s/${module}__/${module}_copy__/g"
}

_protector__get_module_from_path() {
  local module=$1
  printf "${module_path}" | sed "s|^.*/\(.*\)|\\1|"
}

_protector__sed_in_place() {
  local file=$1
  local command=$2
  local temp_file="$(mktemp /tmp/temp.XXXXXX)"
  sed "${command}" "${file}" > "${temp_file}"
  cat "${temp_file}" > "${file}"
}
