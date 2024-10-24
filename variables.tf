variable "rule_name" {
  description = "Nome da regra do EventBridge"
  type        = string
}

variable "rule_description" {
  description = "Descrição da regra do EventBridge"
  type        = string
  default     = ""
}

variable "schedule_expression" {
  description = "Expressão de agendamento (cron ou rate) para o EventBridge"
  type        = string
}

variable "target_arn" {
  description = "ARN do alvo da regra do EventBridge (Lambda, ECS Task, EC2, etc.)"
  type        = string
}

variable "event_input" {
  description = "Entrada opcional enviada para o alvo (ex: parâmetros JSON)"
  type        = string
  default     = null
}

variable "enable_lambda_permission" {
  description = "Habilita permissões para invocar a função Lambda"
  type        = bool
  default     = true
}

variable "enable_ec2_role" {
  description = "Se for iniciar/parar instâncias EC2, habilite para criar permissões de EC2"
  type        = bool
  default     = false
}

variable "region" {
  description = "Região da AWS"
  type        = string
}

variable "account_id" {
  description = "ID da conta AWS"
  type        = string
}
