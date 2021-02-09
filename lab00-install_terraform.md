# Lab 0: Terraform installation

Pour utiliser Terraform, vous devrez l'installer. HashiCorp distribue Terraform sous forme de package binaire . Vous pouvez également installer Terraform à l'aide des gestionnaires de packages courants.

## Installez Terraform sur CentOS
Installez yum-config-managerpour gérer vos référentiels.
```
$ sudo yum install -y yum-utils
```

Utilisez yum-config-managerpour ajouter le référentiel Linux officiel HashiCorp.
```
$ sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
```

Installer.
```
$ sudo yum -y install terraform
```
Installer sur Ubuntu / Debian

Ajoutez la clé GPG HashiCorp .
```
$ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
```

Ajoutez le référentiel Linux officiel HashiCorp.
```
$ sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
```

Mettez à jour et installez.
```
$ sudo apt-get update && sudo apt-get install terraform
```
