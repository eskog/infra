# Terraform
Dont forget to source the .env file before running

## After upgrade of plugins
``` terraform init -upgrade```

## Plan and execute
```
terraform plan
terraform apply
```

## To tear down environment

```
terraform destroy
```

## To plan / run specific plays

```
terraform plan
terraform apply --target=<targetfile>
```

## To destroy a specific play

```
terraform destroy --taget=<targetfile>
```
