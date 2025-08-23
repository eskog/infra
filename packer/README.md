# Packer image generation

This project will create a Rocky linux template for use in proxmox.

## Execution
To run this first ``` source setenv.sh ```

Then run ```packer build -var-file=variables.pkr.hcl rocky-cloud.pkr.hcl ```

## Cleanup
In the scripts folder there is a tiny script to cleanout the template in proxmox. This is needed to run before regenerating the template