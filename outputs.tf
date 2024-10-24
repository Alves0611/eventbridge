output "event_rule_arn" {
  description = "ARN da regra do EventBridge"
  value       = aws_cloudwatch_event_rule.this.arn
}

output "event_target_arn" {
  description = "ARN do alvo do evento"
  value       = aws_cloudwatch_event_target.this.arn
}
