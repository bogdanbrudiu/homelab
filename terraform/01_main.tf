provider "hcloud" {
  token = "${var.hcloud_token}"
}

resource "hcloud_ssh_key" "admin" {
  name       = "${var.ssh_key_name}"
  public_key = "${file(var.ssh_public_key)}"
}

resource "hcloud_server" "rancher-server" {
  count       = "1"
  name        = "rancher"
  server_type = "cx11-ceph"
  image       = "ubuntu-18.04"
  location    = "nbg1"
  ssh_keys    = ["${hcloud_ssh_key.admin.id}"]

  connection {
    agent = "false"
    private_key = "${file(var.ssh_private_key)}"
  }

  provisioner "file" {
    source      = "scripts/cloudflare-ddns-update.sh"
    destination = "/root/cloudflare-ddns-update.sh"
  }

  provisioner "remote-exec" {
    inline = "CLOUDFLARE_AUTH_EMAIL=${var.cloudflare_auth_email} CLOUDFLARE_AUTH_KEY=${var.cloudflare_auth_key} CLOUDFLARE_DOMAIN=${var.acme_domain} bash /root/cloudflare-ddns-update.sh"
  }

  provisioner "file" {
    source      = "scripts/bootstrap.sh"
    destination = "/root/bootstrap.sh"
  }

  provisioner "remote-exec" {
    inline = "DOCKER_VERSION=${var.docker_version} bash /root/bootstrap.sh"
  }
  
  provisioner "file" {
    source      = "scripts/rancher.sh"
    destination = "/root/rancher.sh"
  }

  provisioner "remote-exec" {
    inline = "RANCHER_VERSION=${var.rancher_version} ACME_DOMAIN=${var.acme_domain} bash /root/rancher.sh"
  }

  
  provisioner "file" {
    source      = "scripts/rancher_change_password.sh"
    destination = "/root/rancher_change_password.sh"
  }

  provisioner "remote-exec" {
    inline = [
        "ACME_DOMAIN=${var.acme_domain} RANCHER_SERVER_ADDRESS=${hcloud_server.rancher-server.0.ipv4_address} RANCHER_PASSWORD=${var.rancher_password} RANCHER_KUBERNETES_VERSION=${var.rancher_kubernetes_version} RANCHER_CLUSTER_NAME=${var.rancher_cluster_name} bash /root/rancher_change_password.sh",
    ]
  }

  provisioner "file" {
    source      = "scripts/pagekite.sh"
    destination = "/root/pagekite.sh"
  }
  provisioner "file" {
    source      = "scripts/pagekiteDockerfile"
    destination = "/root/pagekite/Dockerfile"
  }

  provisioner "remote-exec" {
    inline = [
        "KITE_PASSWORD=${var.kite_password} KITE_DOMAIN=${var.acme_domain}bash /root/pagekite.sh",
    ]
  }
}

