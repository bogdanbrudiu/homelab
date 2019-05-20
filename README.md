Hetzner Cloud terraform example 
-----------------------------

* Will create one cx11 Ubuntu host with defined ssh key and install Docker and Rancher 2 Server on the host

How to setup?
--------------

* cp .env.dist .env
* edit .env variables and save
* run: 
  * docker-compose run --rm terraform init
  * docker-compose run --rm terraform plan
  * docker-compose run --rm terraform apply
  * docker-compose run --rm terraform destroy

If running in WSL:
--------------
```console
sudo mkdir /c
sudo mount --bind /mnt/c /c
cd /c/mywork/homelab/
```

```console
export HTTP_PROXY=""
export HTTPS_PROXY=""
export NO_PROXY=""
```

Docker for Windows - unable to use ssh-agent
--------------------------------------------
```console
gpg --list-secret-keys --keyid-format short
gpg --edit-key SSH_A_KEYID & remove password 
gpg --export-secret-keys SSH_A_KEYID | openpgp2ssh SSH_A_KEYID  > /mnt/c/Users/<user>/.ssh/id_rsa
gpg --edit-key SSH_A_KEYID & add password again
gpg --export-ssh-key SSH_A_KEYID > /mnt/c/Users/<user>/.ssh/id_rsa.pub
```
