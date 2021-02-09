resource "aws_cloudwatch_log_group" "log_group" {
  name = var.log_group_name
    tags = {
      created_by = var.created_by
      Environment = var.environment
  }
}