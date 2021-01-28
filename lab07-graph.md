# Lab 7: Terraform Graph

Durée: 5 minutes

Terraform sait beaucoup sur votre configuration. Nous avons déjà vu comment utiliser `terraform show` pour afficher des informations sur vos ressources. Terraform peut également présenter ces données au format DOT, qui est utilisé par GraphVis et des programmes similaires pour générer des graphiques.

- Tâche 1: générer un graphique par rapport à votre configuration Terraform actuelle

## Tache 1

### Étape 7.1.1

Exécutez `terraform graph` dans votre répertoire terraform et notez la sortie.

```shell
terraform graph
```

```text
digraph {
	compound = "true"
	newrank = "true"
	subgraph "root" {
# ...
  }
}
```

### Étape 7.1.2

Collez cette sortie dans [webgraphviz](http://www.webgraphviz.com) pour obtenir une représentation visuelle des dépendances que Terraform crée pour votre configuration.

---
[Lab suivant ->](lab08-meta-arguments.md)
