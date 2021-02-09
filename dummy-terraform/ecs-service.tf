resource "aws_ecs_service" "service" {
  cluster                = "arn:aws:ecs:ap-south-1:294238557692:cluster/dummy"                             
  desired_count          = 1                                                      
  launch_type            = "EC2" 
  name                   = var.service_name 
  task_definition        = aws_ecs_task_definition.task_definition.arn 
  network_configuration {
    subnets               = [var.subnet1, var.subnet2]
    assign_public_ip      = "false"
    security_groups = ["sg-089c596651504c426"]
  }
}
