resource "aws_ecs_cluster" "ctf_cluster" {
  name = "ctf-cluster"
}

data "aws_caller_identity" "current" {}

locals {
    user_data = templatefile("modules/fargate/templates/ctf.json.tpl", {
        app_image      = var.app_image
        app_port       = var.app_port
        fargate_cpu    = var.fargate_cpu
        fargate_memory = var.fargate_memory
        aws_region     = var.aws_region
    })
    execution_role_name = "my-execution-role"
    execution_role_arn  = "arn:aws:iam::303981612052:role/ecsTaskExecutionRole"

}

resource "aws_ecs_task_definition" "ctf_task" {
    family                   = "ctf-app-task"
    execution_role_arn       = local.execution_role_arn
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                      = var.fargate_cpu
    memory                   = var.fargate_memory

    container_definitions = local.user_data
}

resource "aws_ecs_service" "ctf_service" {
  name            = "ctf"
  launch_type     = "FARGATE"
  cluster         = aws_ecs_cluster.ctf_cluster.id
  task_definition = aws_ecs_task_definition.ctf_task.arn
  desired_count   = 3
    
    network_configuration {
        security_groups = [aws_security_group.cf.id]
        subnets = aws_subnet.public.*.id
        assign_public_ip = true
    }

}