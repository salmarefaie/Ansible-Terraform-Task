output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "nexus_ec2_id" {
  value = aws_instance.ec2["nexus-instance"].id
}

output "sonarqube_ec2_id" {
  value = aws_instance.ec2["sonarqube-instance"].id
}
