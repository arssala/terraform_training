# Lab 1: Configuration du lab

Durée: 20 minutes

- Tâche 1: se connecter au poste de travail étudiant
- Tâche 2: vérifier l'installation de Terraform
- Tâche 3: Générez votre première configuration Terraform
- Tâche 4: utiliser la CLI Terraform pour obtenir de l'aide
- Tâche 5: Appliquer et mettre à jour votre configuration

## Tâche 1: connexion au poste de travail étudiant


## Tâche 2: Installation de Terraform
### Quelques faits sur Terraform
Terraform est un logiciel qui permet de gérer efficacement les ressources de l'infrastructure cloud à partir du code.

En outre, il est appelé outil «Infrastructure as Code» car il utilise un fichier de configuration pour gérer les ressources.

De plus, il prend en charge les fournisseurs de services cloud tels que AWS, Google Cloud Platform, Azure et bien d'autres.


### Installer terraform sur CentOS 7 / Ubuntu 18.04
Voyons maintenant comment installer Terraform.

#### Installation de Terraform sur CentOS 7
Tout d'abord, mettez à jour les listes de référentiels en exécutant la commande ci-dessous.
```
sudo yum update
```
Ensuite, vous devrez avoir un **wget** et **unzip**. Si vous ne l'avez pas, installez-les en exécutant la commande ci-dessous.
```
sudo yum install wget unzip
```
Téléchargez maintenant Terraform depuis le site Web du développeur en exécutant la commande suivante.
```
sudo wget https://releases.hashicorp.com/terraform/0.12.2/terraform_0.12.2_linux_amd64.zip
```
Puis extrayez le fichier téléchargé.
```
sudo unzip ./terraform_0.12.2_linux_amd64.zip –d /usr/local/bin
```
La sortie doit afficher le chemin du répertoire de Terraform.

Enfin, vérifiez que le Terraform est capable d'accepter les commandes.
```
terraform –v
```
En conséquence, il doit afficher le Terraform v.0.12.6.

####Installer Terraform sur Ubuntu 18.04
Tout d'abord, vous devez mettre à jour les listes de référentiels. Pour cela, exécutez la commande ci-dessous.
```
sudo apt-get update
```
Vous pouvez exécuter la commande ci-dessous pour installer **wget** et **unzip**.
```
sudo apt-get install wget unzip
```
Maintenant, exécutez l'utilitaire wget ci-dessous pour télécharger le Terraform.
```
sudo wget https://releases.hashicorp.com/terraform/0.12.2/terraform_0.12.2_linux_amd64.zip
```
Après le téléchargement, extrayez le fichier.
```
sudo unzip ./ terraform_0.12.2_linux_amd64.zip –d /usr/local/bin
```
Enfin, vérifiez que le Terraform est capable d'accepter les commandes.
```
terraform –v
```
Par conséquent, la sortie doit afficher Terraform v.0.12.6.


## Tâche 3: Générez votre première configuration Terraform

### Étape 1.3.1

Dans le répertoire terraform, créez le fichier intitulé `main.tf` pour créer une instance AWS avec les propriétés suivantes:

- ami
- subnet_id
- vpc_security_group_ids
- tags.Identity

Votre fichier final `main.tf` devrait ressembler à ceci avec des valeurs différentes:

```hcl
provider "aws" {
  access_key = "AKIAIUDVJEEI5KCIKJ6Q"
  secret_key = "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"
  region     = "eu-west-3"
}

resource "aws_instance" "web" {
  ami           = "ami-0ea4a063871686f37"
  instance_type = "t2.micro"

  subnet_id              = "<SUBNET>"
  vpc_security_group_ids = ["<SECURITY_GROUP>"]

  tags = {
    "Identity" = "<IDENTITY>"
  }
}
```

N'oubliez pas de sauvegarder le fichier avant de continuer!

## Tâche 4: utiliser la CLI Terraform pour obtenir de l'aide

### Étape 1.4.1

Exécutez la commande suivante pour afficher les commandes disponibles:

```shell
terraform -help
```

```text
Usage: terraform [-version] [-help] <command> [args]

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.

Common commands:
    apply              Builds or changes infrastructure
    console            Interactive console for Terraform interpolations
    destroy            Destroy Terraform-managed infrastructure
    env                Workspace management
    fmt                Rewrites config files to canonical format
    get                Download and install modules for the configuration
    graph              Create a visual graph of Terraform resources
    import             Import existing infrastructure into Terraform
    init               Initialize a Terraform working directory
    output             Read an output from a state file
    plan               Generate and show an execution plan

    ...
```
* (sortie complète tronquée par souci de brièveté dans ce guide)


Ou, vous pouvez utiliser le raccourci:

```shell
terraform -h
```

### Étape 1.4.2

Accédez au répertoire Terraform et initialisez Terraform
```shell
cd terraform
```

```shell
terraform init
```

```text
Initializing provider plugins...
...

Terraform has been successfully initialized!
```


### Étape 1.4.3

Obtenez de l'aide sur la commande `plan`, puis exécutez-la:

```shell
terraform -h plan
```

```shell
terraform plan
```

## Tâche 5: Appliquer et mettre à jour votre configuration

### Étape 1.5.1

Exécutez la commande `terraform apply` pour générer des ressources réelles dans AWS

```shell
terraform apply
```

Vous serez invité à confirmer les modifications avant leur application. Répondez avec
`yes`.

### Étape 1.5.2

Utilisez la commande `terraform show` pour afficher les ressources créées et trouver l'adresse IP de votre instance.

Envoyez un ping à cette adresse pour vous assurer que l'instance est en cours d'exécution.

### Étape 1.5.3

Terraform peut effectuer des mises à jour sur place sur vos instances une fois que des modifications sont apportées au fichier de configuration `main.tf`.

Ajoutez deux balises à l'instance AWS:

- Name
- Environment

```hcl
  tags = {
    "Identity"    = "terraform"
    "Name"        = "Student"
    "Environment" = "Training"
  }
```

### Étape 1.5.4

Planifiez et appliquez les modifications que vous venez d'effectuer et notez les différences de sortie pour les ajouts, les suppressions et les modifications.

```shell
terraform apply
```

Vous devriez voir une sortie indiquant que _aws_instance.web_ sera modifié:

```text
...

# aws_instance.web will be updated in-place
~ resource "aws_instance" "web" {

...
```

Lorsque vous êtes invité à appliquer les modifications, répondez par `yes`.

---
[Lab suivant (Les outputs) ->](lab02-outputs.md)
