resource "aws_cloudwatch_event_rule" "this" {
  name                = var.rule_name
  description         = var.rule_description
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "this" {
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = "target"
  arn       = var.target_arn

  input = var.event_input
}

resource "aws_lambda_permission" "allow_eventbridge" {
  count         = var.enable_lambda_permission ? 1 : 0
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = var.target_arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.this.arn
}

resource "aws_iam_role" "ec2_start_stop_role" {
  count = var.enable_ec2_role ? 1 : 0
  name  = "ec2_start_stop_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "events.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "ec2_start_stop_policy" {
  count = var.enable_ec2_role ? 1 : 0
  name  = "ec2_start_stop_policy"
  role  = aws_iam_role.ec2_start_stop_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:StartInstances",
          "ec2:StopInstances"
        ]
        Resource = "arn:aws:ec2:${var.region}:${var.account_id}:instance/*"
      }
    ]
  })
}

resource "aws_cloudwatch_event_target" "ec2_target" {
  count     = var.enable_ec2_role ? 1 : 0
  rule      = aws_cloudwatch_event_rule.this.name
  target_id = "ec2_target"
  arn       = aws_iam_role.ec2_start_stop_role.arn

  input_transformer {
    input_paths = {
      "instance_id" = "$.detail.instance-id"
    }
    input_template = "{ \"instance_id\": \"<instance_id>\" }"
  }
}
