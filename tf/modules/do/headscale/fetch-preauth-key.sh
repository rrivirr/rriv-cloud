#!/bin/bash
set -euo pipefail
VPN_IP="$1"
OUTFILE="./headscale-preauth.env"

if [ -z "$VPN_IP" ]; then
  echo "Usage: $0 <droplet-ip>"
  exit 2
fi

echo "Fetching /root/headscale-preauth.env from $VPN_IP..."
scp -o StrictHostKeyChecking=no root@"${VPN_IP}":/root/headscale-preauth.env "${OUTFILE}"
echo "Saved to ${OUTFILE}"
echo "Parsed key:"
grep -Eo 'key: .*' "${OUTFILE}" | awk '{print $2}' || echo "No key found in ${OUTFILE}; check contents."
