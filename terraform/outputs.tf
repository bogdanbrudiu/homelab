output "rancher_ips" {
  value = ["${hcloud_server.rancher-server.*.ipv4_address}"]
}
