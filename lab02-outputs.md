# Lab 2: Outputs

Durée: 10 minutes

Les outputs nous permettent de rechercher des valeurs spécifiques plutôt que d'analyser les métadonnées dans `terraform show`.

- Tâche 1: créer des variables de output dans votre fichier de configuration
- Tâche 2: utiliser la commande de output pour trouver des variables spécifiques

## Tâche 1: créer des variables de output dans votre fichier de configuration

### Étape 2.1.1

Créez deux nouvelles variables de output nommées "public_dns" et "public_ip" pour générer les attributs public_dns et public_ip de l'instance

```hcl
output "public_ip" {
  value = aws_instance.web.public_ip
}

output "public_dns" {
  value = aws_instance.web.public_dns
}
```

### Étape 2.1.2

Exécutez la commande `refresh` pour récupérer la nouvelle sortie

```shell
terraform refresh
```

## Tâche 2: Utilisez la commande `output` pour trouver des variables spécifiques

### Étape 2.2.1 Essayez la commande `terraform output` sans spécifications

```shell
terraform output
```

### Étape 2.2.2 Requête spécifique pour les attributs public_dns

```shell
terraform output public_dns
```

---
[Lab suivant (La Console) ->](lab03-console.md)
