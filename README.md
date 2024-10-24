# Módulo EventBridge Scheduler

## Explicação

- **event_pattern**: Aqui você pode definir o padrão de evento específico para o serviço de interesse. Isso pode ser EC2, ECS, CloudWatch, S3, etc.
- **target_arn**: O alvo do evento. Pode ser uma função Lambda, uma tarefa ECS, um SNS Topic, uma fila SQS, entre outros. Basta fornecer o ARN correto do recurso.
- **enable_lambda_permission**: Quando o alvo for uma função Lambda, essa variável garante que o EventBridge tenha as permissões necessárias para invocar a Lambda. Se o alvo for um ECS ou outro recurso, defina-a como `false`.

O módulo aceita diferentes padrões de evento, então você pode configurá-lo para qualquer serviço da AWS que seja compatível com o EventBridge.

**Multi-Alvo**: É possível disparar qualquer alvo suportado pelo EventBridge, como tarefas ECS, filas SQS, tópicos SNS, etc.

## Exemplo: Agendar Execução de Lambda com Cron Expression

```hcl
module "lambda_eventbridge_schedule" {
  source              = ""
  rule_name           = "lambda-trigger"
  rule_description    = "Dispara a função Lambda diariamente às 8h UTC"
  schedule_expression = "cron(0 8 * * ? *)"
  target_arn          = ""
  enable_lambda_permission = true
}
```

# Módulo para iniciar instância EC2

```hcl
module "ec2_start_schedule" {
  source              = ""
  rule_name           = "ec2-start"
  rule_description    = "Inicia a instância EC2 diariamente às 7h UTC"
  schedule_expression = "cron(0 7 * * ? *)"
  target_arn          = ""
  enable_ec2_role     = true
  region              = "us-east-1"
  account_id          = ""
}
```

# Módulo para parar instância EC2

```hcl
module "ec2_stop_schedule" {
  source              = ""
  rule_name           = "ec2-stop"
  rule_description    = "Para a instância EC2 diariamente às 19h UTC"
  schedule_expression = "cron(0 19 * * ? *)"
  target_arn          = ""
  enable_ec2_role     = true
  region              = "us-east-1"
  account_id          = ""
}

```

# Exemplo: Agendar Execução de Tarefa ECS

```hcl
module "ecs_eventbridge_schedule" {
  source              = "./modules/eventbridge_scheduler"
  rule_name           = "ecs-task"
  rule_description    = "Executa uma tarefa ECS toda segunda-feira às 9h UTC"
  schedule_expression = "cron(0 9 ? * 2 *)"
  target_arn          = ""
  enable_lambda_permission = false
}

```