# Lab 8: Méta-Arguments

Durée: 10 minutes

Jusqu'à présent, nous avons déjà utilisé des arguments pour configurer vos ressources. Ces arguments sont utilisés par le provider pour spécifier des éléments tels que l'AMI à utiliser et le type d'instance à provisionner. Terraform prend également en charge un certain nombre de _Meta-Arguments_, ce qui change la façon dont Terraform configure les ressources. Par exemple, il n'est pas rare de provisionner plusieurs copies de la même ressource. Nous pouvons le faire avec l'argument _count_.

- Tâche 1: modifier le nombre d'instances AWS avec `count`
- Tâche 2: modifier le reste de la configuration pour prendre en charge plusieurs instances
- Tâche 3: Ajouter une interpolation de variable à la balise Name pour compter la nouvelle instance

## Tâche 1: modifier le nombre d'instances AWS avec `count`

### Étape 8.1.1

Ajoutez un argument count à l'instance AWS dans `server/server.tf` avec une valeur de 2:

```hcl
# ...
resource "aws_instance" "web" {
  count                  = 2
  ami                    = var.ami
  instance_type          = "t2.micro"
# ... leave the rest of the resource block unchanged...
}
```

## Tâche 2: modifier le reste de la configuration pour prendre en charge plusieurs instances

### Étape 8.2.1

Si vous exécutez `terraform apply` maintenant, vous obtiendrez une erreur. Dès que nous avons ajouté _count_ à la ressource aws_instance.web, il fait désormais référence à plusieurs ressources. Pour cette raison, des valeurs telles que `aws_instance.web.public_ip` ne font plus référence au public_ip d'une seule ressource. Nous devons dire à terraform à quelle ressource nous nous référons.

Pour ce faire, modifiez les blocs de sortie dans `server/server.tf` comme suit:

```
output "public_ip" {
  value = aws_instance.web.*.public_ip
}

output "public_dns" {
  value = aws_instance.web.*.public_dns
}
```

La syntaxe `aws_instance.web. *` Fait référence à toutes les instances, donc cela affichera une liste de toutes les adresses IP publiques et des enregistrements DNS publics.

### Étape 8.2.2

Exécutez `terraform apply` pour ajouter la nouvelle instance. Vous devriez voir deux adresses IP et deux adresses DNS dans les sorties.

## Tâche 3: Ajouter une interpolation de variable à la balise Name pour compter les nouvelles instances

### Étape 8.3.1

Interpolez la variable de comptage en modifiant le tag Name pour inclure le nombre actuel par rapport au nombre total. Mettez à jour `server/server.tf` pour ajouter une nouvelle définition de variable et utilisez-la:

```hcl
# ...
variable private_key {}
variable num_webs {
  default = "2"
}

resource "aws_instance" "web" {
  count                  = var.num_webs
  ami                    = var.ami
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name

  tags = {
    "Identity"    = var.identity
    "Name"        = "Student ${count.index + 1}/${var.num_webs}"
    "Environment" = "Training"
  }

# ...
```

La solution s'appuie sur notre discussion précédente sur les variables. Nous devons créer une variable pour contenir notre compte afin que nous puissions référencer ce compte deux fois dans notre ressource. Ensuite, nous remplaçons la valeur du paramètre count par la variable interpolation. Enfin, nous interpolons le compte actuel (+1 car il est indexé à zéro) et la variable elle-même.

### Étape 8.3.2

Exécutez `terraform apply` dans le répertoire terraform. Vous devriez voir les tags révisées qui comptent les instances dans le journal d'application.

```shell
terraform apply
```


---
[Lab suivant ->](lab09-datasources.md)
