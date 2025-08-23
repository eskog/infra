#!/bin/bash
curl -k -X DELETE \
  -H "Authorization: PVEAPIToken=$PKR_VAR_TOKEN_ID=$PKR_VAR_TOKEN_SECRET" \
  "https://$PVEHOST:8006/api2/json/nodes/$PVENODE/qemu/$VMID?purge=1"