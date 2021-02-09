resource "aws_ecs_task_definition" "task_definition" {
  container_definitions    = <<DEFINITION
  [
    {
       "name": "celery",
       "image": "${var.ecr_repository_name}:${var.container_tag}",
        "cpu": 256,
        "memory": 512,
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "educollab-celery",
            "awslogs-region": "ap-south-1",
            "awslogs-stream-prefix": "ecs"
          }
        },
        "links": [],
        "essential": true,
        "entryPoint": [],
        "command": [],
        "environment": [],
        "mountPoints": [],
        "volumesFrom": []
    }
  ]  
  DEFINITION                               
  execution_role_arn       = aws_iam_role.task_role.arn         # role for executing task
  family                   = var.task_family                                                                      # task name
  network_mode             = "awsvpc"                                                                                      # network mode awsvpc, brigde
  memory                   = "512"
  cpu                      = "256"
  requires_compatibilities = ["EC2"]                                                                                       # Fargate or EC2
  task_role_arn            = aws_iam_role.task_role.arn                                                                   # TASK running role
} 

