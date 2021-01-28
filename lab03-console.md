# Lab 3: Console Terraform

Durée: 10 minutes

Les configurations et commandes Terraform utilisent souvent des [expressions] (https://www.terraform.io/docs/configuration/expressions.html) comme `aws_instance.web.ami` pour référencer les ressources Terraform et leurs attributs.

Terraform comprend une console interactive pour évaluer les expressions par rapport à l'état actuel de Terraform (state). Ceci est particulièrement utile pour vérifier les valeurs lors de la modification des configurations.

- Tâche 1: Utilisez `terraform console` pour interroger des informations d'instance spécifiques.

## Tâche 1: Utilisez `terraform console` pour interroger des informations d'instance spécifiques.

### Étape 3.1.1

Trouvez l'ID AMI de votre instance

```shell
terraform console
```

```
> aws_instance.web.ami
ami-0f9cf087c1f27d9b1
```

Ctrl+C quitte la console Terraform

### Étape 3.1.2

Vous pouvez également diriger les informations de requête vers le stdin de la console pour évaluation

```shell
echo "aws_instance.web.ami" | terraform console
```

```
ami-0f9cf087c1f27d9b1
```

---
[Lab suivant (les variables) ->](lab04-variables.md)
