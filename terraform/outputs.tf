output "instance_id" {
  value = aws_instance.k3s_node.id
}

output "instance_public_ip" {
  value = aws_instance.k3s_node.public_ip
}

output "ssh_user" {
  value = "ubuntu"
}

output "ssh_key_pair_name" {
  value = aws_key_pair.this.key_name
}

output "ssh_public_key_openssh" {
  value = tls_private_key.ssh.public_key_openssh
}

# Only output if needed; keep it sensitive and write it to a repo-local file with chmod 600.
output "ssh_private_key_openssh" {
  value     = tls_private_key.ssh.private_key_openssh
  sensitive = true
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "security_group_id" {
  value = aws_security_group.instance.id
}
