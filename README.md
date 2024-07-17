# ansible-terraform-aws
terraform and ansible integration using using aws ec2

### OS 

Ubuntu 24.04

### Packages

* terraform v1.9.2-dev

* aws-cli/2.17.13

* python/3.11.9

### AWS-CLI package installation

 ```sh
  snap install aws-cli --classic
  ```

#### How to run

```sh
aws configure
```
```sh
terraform init
```
```sh
terraform apply
```