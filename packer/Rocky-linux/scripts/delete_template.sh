#!/bin/bash
curl -k -X DELETE \
  -H "Authorization: PVEAPIToken=$TOKEN_ID=$TOKEN_SECRET" \
  "https://$PVEHOST:8006/api2/json/nodes/$PVENODE/qemu/$VMID?purge=1"
