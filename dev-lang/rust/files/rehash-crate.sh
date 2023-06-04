#!/bin/sh
# $1 = crate patch file

set -euf

cargo='.cargo-checksum.json'

grep -- '+++' "${1:?}" | while read -r _ f; do
	file="${f#*/}"
	orig_sum="$(grep -Po "(?<=\"${file}\":\")[0-9a-fA-F]+(?=\")" \
		"${cargo}")"
	if [ -n "${orig_sum}" ]; then
		sum="$(sha256sum "${file}")"
		sed -i "s|${orig_sum}|${sum%% *}|" "${cargo}"
	fi
done

exit 0
