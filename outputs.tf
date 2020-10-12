output "hosted_zone" {
    value = {
        id = aws_route53_zone.organization.id
        name = aws_route53_zone.organization.name
        name_servers = aws_route53_zone.organization.name_servers
    }
}
