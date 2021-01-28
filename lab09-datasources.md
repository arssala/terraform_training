# Lab 9: Source de données (facultatif)

Il s'agit d'un laboratoire facultatif que vous pouvez effectuer seul à la fin du cours Terraform 101 si vous avez le temps. Il utilise la source de données [aws_ami](https://www.terraform.io/docs/providers/aws/d/ami.html) pour récupérer la même AMI que nous utilisons depuis le début, puis permet au Web aws_instance d'utiliser cela SUIS-JE. Vous pouvez en savoir plus sur les sources de données [ici](https://www.terraform.io/docs/configuration/data-sources.html). Un exemple d'utilisation d'une ressource aws_instance avec l'AMI renvoyée par une source de données aws_ami se trouve dans la documentation de la ressource [aws_instance](https://www.terraform.io/docs/providers/aws/r/instance.html).

Durée: 10 minutes

- Tâche 1: Ajouter une source de données aws_ami
- Tâche 2: faire en sorte que le Web aws_instance utilise l'AMI renvoyée par la source de données

## Tâche 1: Ajouter une source de données aws_ami

### Étape 9.1.1

Ajoutez une source de données aws_ami appelée "ubuntu_16_04" dans server/server.tf après les définitions de variable. Il trouvera l'instance la plus récente d'une AMI Ubuntu 16.04 de Canonical (ID de propriétaire 099720109477).

```hcl
data "aws_ami" "ubuntu_16_04" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}
```

## Tâche 2: faire en sorte que aws_instance utilise l'AMI renvoyée

### Étape 9.2.1

Modifiez aws_instance dans server/server.tf afin que son argument ami utilise l'AMI renvoyée par la source de données.

```hcl
resource "aws_instance" "web" {
  count         = var.num_webs
  ami           = data.aws_ami.ubuntu_16_04.image_id
  instance_type = "t2.nano"
...
}
```

### Étape 9.2.2

De plus, puisque nous n'avons plus besoin de la variable ami, supprimez-la ou commentez-la (avec l'initiale "#") à la fois dans server/server.tf et dans main.tf. Dans ce dernier, supprimez-le ou commentez-le à la fois dans la déclaration de variable elle-même et dans le bloc du module serveur. Vous pouvez également le commenter dans terraform.tfvars.

### Étape 9.2.3

Exécutez `terraform apply` une dernière fois pour appliquer les modifications que vous avez apportées.

```shell
terraform apply
```
