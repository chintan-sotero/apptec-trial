output "rds_hostname_prod" {
  description = "RDS Prod instance hostname"
  value       = aws_db_instance.sotero_prod.address
}

output "rds_port_prod" {
  description = "RDS prod instance port"
  value       = aws_db_instance.sotero_prod.port
}

output "rds_username_prod" {
  description = "RDS instance prod root username"
  value       = aws_db_instance.sotero_prod.username
}

output "rds_password_prod" {
  description = "RDS instance prod root password"
  value       = aws_db_instance.sotero_prod.password
  sensitive   = true
}

output "rds_hostname_qa" {
  description = "RDS QA instance hostname"
  value       = aws_db_instance.sotero_qa.address
}

output "rds_port_qa" {
  description = "RDS QA instance port"
  value       = aws_db_instance.sotero_qa.port
}

output "rds_username_qa" {
  description = "RDS instance QA root username"
  value       = aws_db_instance.sotero_qa.username
}

output "rds_password_qa" {
  description = "RDS instance QA root password"
  value       = aws_db_instance.sotero_qa.password
  sensitive   = true
}