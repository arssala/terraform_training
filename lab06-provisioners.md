# Lab 6: Provisioners

Durée: 10 minutes

Terraform peut se connecter et provisionner l'instance à distance avec un bloc d'approvisionnement.

- Tâche 1: créer un bloc de connexion à l'aide des sorties de votre module de paire de clés.
- Tâche 2: créer un bloc d'approvisionnement pour télécharger à distance du code sur votre instance.
- Tâche 3: appliquez votre configuration et surveillez la connexion à distance.

## Tâche 1: Créez un bloc de connexion à l'aide des sorties de votre module de paire de clés.

### Étape 6.1.1

Dans `server/server.tf`, ajoutez un bloc de connexion dans votre ressource d'instance Web sous `tags`:

```hcl
resource "aws_instance" "web" {
# Leave the first part of the block unchanged, and add a connection block:
# ...

  connection {
    user        = "ubuntu"
    private_key = var.private_key
    host        = self.public_ip
  }
```

**La variable `private_key` a été définie dans le lab précédent.**

La valeur de «self» fait référence à la ressource définie par le bloc courant. Donc, `self.public_ip` fait référence à l'adresse IP publique de notre` aws_instance.web`.

## Tâche 2: Créez un bloc d'approvisionnement pour envoyer un code sur votre instance.

### Étape 6.2.1

Le provisioner des fichiers s'exécutera après la création de l'instance et y copiera le contenu du répertoire _assets_. Ajoutez ceci au bloc _aws_instance_ dans `server/server.tf`, juste après le bloc de connexion que vous venez d'ajouter:

```hcl
  provisioner "file" {
    source      = "assets"
    destination = "/tmp/"
  }
```

### Étape 6.2.2

Le provisioner remote-exec exécute des commandes à distance. Nous pouvons exécuter le script à partir de notre répertoire de ressources. Ajoutez ceci après le bloc `provisioner "file"`:

```hcl
  provisioner "remote-exec" {
    inline = [
      "sudo sh /tmp/assets/setup-web.sh",
    ]
  }
```

Assurez-vous que les deux approvisionneurs se trouvent dans le bloc de ressources _aws_instance_.

### Étape 6.2.3

Créons maintenant notre script `setup-web.sh`sous un répertoire local `assets`:

```shell
#!/bin/bash
apt-get update
apt-get install -y apache2
systemctl start apache2
systemctl enable  apache2
echo "<html><h1>Welcome to Aapache Web Server</h2></html>" > /var/www/html/index.html
```

Ce script sera exécuté sur l'instance par Terraform, pour installer le serveur Apache et créer la page index.html

## Tâche 3: appliquez votre configuration et surveillez la connexion à distance.

### Étape 6.3.1

Un point important à retenir concernant les _provisioners_ est que les ajouter ou les supprimer d'une instance ne provoquera pas la mise à jour ou la recréation de l'instance par terraform. Vous pouvez voir ceci maintenant si vous exécutez `terraform apply`:

```text
...

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

...
```

Afin de vous assurer que les _provisioners_ s'exécutent, utilisez la commande `terraform taint`. Une ressource qui a été marquée comme _tainted_ sera détruite et recréée.

```shell
terraform taint module.server.aws_instance.web
```

```
Resource instance module.server.aws_instance.web has been marked as tainted.
```


Lors de l'exécution de `terraform apply`, vous devriez voir une nouvelle sortie:

```shell
terraform apply
```

```text
...
module.server.aws_instance.web: Provisioning with 'remote-exec'...
module.server.aws_instance.web (remote-exec): Connecting to remote host via SSH...
module.server.aws_instance.web (remote-exec):   Host: 18.222.77.212
module.server.aws_instance.web (remote-exec):   User: ubuntu
module.server.aws_instance.web (remote-exec):   Password: false
module.server.aws_instance.web (remote-exec):   Private key: true
module.server.aws_instance.web (remote-exec):   SSH Agent: false
module.server.aws_instance.web (remote-exec): Connected!
module.server.aws_instance.web (remote-exec): Created symlink from /etc/systemd/system/multi-user.target.wants/webapp.service to /lib/systemd/system/webapp.service.
module.server.aws_instance.web: Creation complete after 41s (ID: i-0a869f781ab03b248)

Apply complete! Resources: 1 added, 0 changed, 1 destroyed.
...
```

Vous pouvez maintenant visiter votre application Web en pointant votre navigateur sur la sortie public_dns de votre instance EC2. Si vous le souhaitez, vous pouvez également ssh sur votre instance EC2 avec une commande du type `ssh -i keys/<your_private_key>.pem ubuntu@<your_dns>`. Tapez `yes` lorsque vous êtes invité à utiliser la clé. Tapez `exit` pour quitter la session ssh.


```shell
ssh -i keys/<your_private_key>.pem ubuntu@<your_dns>
```

```text
The authenticity of host 'ec2-54-203-220-176.us-west-2.compute.amazonaws.com (54.203.220.176)' can't be established.
ECDSA key fingerprint is SHA256:Q/IWQRIOcb1h46ic7mHR2oBCk9XOTPHCHQOy0A/pezs.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'ec2-54-203-220-176.us-west-2.compute.amazonaws.com,54.203.220.176' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 16.04.6 LTS (GNU/Linux 4.4.0-1088-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

0 packages can be updated.
0 updates are security updates.

New release '18.04.2 LTS' available.
Run 'do-release-upgrade' to upgrade to it.


Last login: Fri Aug 16 20:58:44 2020 from 34.222.21.235
ubuntu@ip-10-1-1-96:~$ exit
logout
Connection to ec2-54-203-220-176.us-west-2.compute.amazonaws.com closed.
```

---
[Lab suivant ->](lab07-graph.md)
