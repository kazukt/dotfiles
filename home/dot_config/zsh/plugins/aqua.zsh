export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
export AQUA_GLOBAL_CONFIG=${AQUA_GLOBAL_CONFIG:-}:${XDG_CONFIG_HOME:-$HOME/.config}/aqua/aqua.yaml
export AQUA_POLICY_CONFIG=${XDG_CONFIG_HOME:-$HOME/.config}/aqua/aqua-policy.yaml:${AQUA_POLICY_CONFIG:-}
