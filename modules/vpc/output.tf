output "availability_zones" {
  value = [local.az1, local.az2]
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "rds_subnets" {
  value = [aws_subnet.rds1.id, aws_subnet.rds2.id]
}

output "nat_subnet_id" {
  value = aws_subnet.nat.id
}

output "appserver_subnet_id" {
  value = aws_subnet.app.id
}

output "appserver_route_table_id" {
  value = aws_route_table.app.id
}

output "tailscale_subnet_id" {
  value = aws_subnet.ts.id
}
