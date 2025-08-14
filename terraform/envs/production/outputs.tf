output "vm_external_ips" {
  description = "IPs públicos das VMs"
  value = [
    for d in nonsensitive(module.compute_instance.instances_details) :
    d.network_interface[0].access_config[0].nat_ip
  ]
}
