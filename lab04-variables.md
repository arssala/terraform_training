# Lab 4: Variables

Durée: 15 minutes

Nous ne voulons pas hard-coder toutes nos valeurs dans le fichier `main.tf`. Nous pouvons créer un fichier de variables pour une utilisation plus facile.

- Tâche 1: créer des variables dans un bloc de configuration
- Tâche 2: interpoler ces variables
- Tâche 3: créer un fichier `terraform.tfvars`

## Tâche 1: Créer un nouveau bloc de configuration pour les variables

### Étape 4.1.1

Ajoutez trois variables en haut de votre fichier de configuration:

```hcl
variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "<REGION>"
}
```

## Tâche 2: Interpoler ces variables dans votre code existant

### Étape 4.2.1

Mettez à jour le bloc _provider_ pour remplacer les valeurs hard-coded par les nouvelles variables.

```hcl
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}
```

### Étape 4.2.2

Réexécutez `terraform plan` pour que Terraform récupère les nouvelles variables. Notez que vous serez invité à les entrer maintenant.

```shell
terraform plan
```

```text
var.access_key
  Enter a value:
```

Utilisez Ctrl+C pour quitter.

## Tâche 3: Modifiez votre fichier `terraform.tfvars`

Les variables définies uniquement dans le fichier de configuration seront invitées à la saisie. nous
pouvons éviter cela en créant un fichier de variables.

### Étape 4.3.1

Créez le fichier `terraform.tfvars` contenant ces deux premières paires clé-valeur:

```
access_key = "<ACCESSKEY>"
secret_key = "<SECRETKEY>"

```

Réexécutez `terraform plan` et notez que cela ne vous invite plus à saisir.

### Étape 4.3.2

Ajoutez les variables correspondantes à votre fichier `main.tf` dans `terraform.tfvars`:

```hcl
variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "<REGION>"
}
variable "ami" {}
variable "subnet_id" {}
variable "identity" {}
variable "vpc_security_group_ids" {
  type = list
}
```

### Étape 4.3.3

Modifiez également votre bloc de ressources avec ces modifications.

```hcl
resource "aws_instance" "web" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = {
    "Identity"    = var.identity
    "Name"        = "Student"
    "Environment" = "Training"
  }
}
```

Après avoir effectué ces modifications, réexécutez `terraform plan`. Vous devriez voir qu'il n'y a aucun changement à appliquer, ce qui est correct, car les variables contiennent les mêmes valeurs que nous avions précédemment codées:

```text
...

No changes. Infrastructure is up-to-date.

This means that Terraform did not detect any differences between your
configuration and real physical resources that exist. As a result, no
actions need to be performed.
```

---
[Lab suivant (Les modules) ->](lab05-modules.md)
