# Terraform

Don't forget to copy `setenv.example` to `setenv.sh`, update values, and source it before running.

## After upgrade of plugins

```shell
terraform init -upgrade
```

## Plan and execute

```shell
terraform plan
terraform apply
```

## To tear down environment

```shell
terraform destroy
```

## To plan / run specific plays

```shell
terraform plan
terraform apply --target=<tf_resourceaddress>
```

## To destroy a specific play

```shell
terraform destroy --target=<tf_resourceaddress>
```
where 'tf_resourceaddress' is an defined resource. for example "proxmox_vm_qemu_k8s_workers"
