#!/usr/bin/env bash

set -euo pipefail

REPO_NAME='reproducible-containers/diffoci'
TOOL_NAME='diffoci'
TOOL_TEST='diffoci -version'

GH_REPO="https://github.com/${REPO_NAME}"
GH_API_REPO="https://api.github.com/repos/${REPO_NAME}"
GH_API_VERSION='2026-03-10'

fail() {
	echo -e "asdf-${TOOL_NAME}: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token ${GITHUB_API_TOKEN}")
fi

_arch() {
	case "$(uname -m | tr '[:upper:]' '[:lower:]')" in
	x86_64)
		echo "amd64"
		;;
	arm64 | aarch64)
		echo "arm64"
		;;
	armv7l)
		echo "arm-v7"
		;;
	ppc64le)
		echo "ppc64le"
		;;
	riscv64)
		echo "riscv64"
		;;
	s390x)
		echo "s390x"
		;;
	*)
		exit 1
		;;
	esac
}

_system() {
	uname -s | tr '[:upper:]' '[:lower:]'
}

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
	git ls-remote --tags --refs "${GH_REPO}" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//'
}

download_release() {
	local version filename system arch download_url metadata_url metadata immutable

	version="$1"
	filename="$2"

	system="$(_system)" || fail 'Could not get the kernel name'
	arch="$(_arch)" || fail 'Unknown machine (hardware) type'
	download_url="${GH_REPO}/releases/download/v${version}/diffoci-v${version}.${system}-${arch}"

	echo "* Downloading ${TOOL_NAME} release ${version}..."
	curl "${curl_opts[@]}" -o "${filename}" -C - "${download_url}" || fail "Could not download ${download_url}"
	chmod +x "${filename}"

	metadata_url="${GH_API_REPO}/releases/tags/v${version}"
	metadata=$(curl "${curl_opts[@]}" -H 'Accept: application/vnd.github+json' -H "X-GitHub-Api-Version: ${GH_API_VERSION}" "${metadata_url}" 2>/dev/null || true)
	if [[ -n ${metadata} ]]; then
		immutable=$(echo "${metadata}" | grep '"immutable": true,' || true)
		if [[ -z ${immutable} ]]; then
			echo "! Release ${version} of ${TOOL_NAME} is NOT an 'Immutable release'"
		fi
	fi
}

install_version() {
	local install_type version install_path

	install_type="$1"
	version="$2"
	install_path="${3%/bin}/bin"

	if [ "${install_type}" != 'version' ]; then
		fail "supports release installs only"
	fi

	(
		mkdir -p "${install_path}"
		cp -r "${ASDF_DOWNLOAD_PATH}"/* "${install_path}"

		local tool_cmd
		tool_cmd="$(echo "${TOOL_TEST}" | cut -d' ' -f1)"
		test -x "${install_path}/${tool_cmd}" || fail "Expected ${install_path}/${tool_cmd} to be executable."

		echo "${TOOL_NAME} ${version} installation was successful!"
	) || (
		rm -rf "${install_path}"
		fail "An error occurred while installing ${TOOL_NAME} ${version}"
	)
}
