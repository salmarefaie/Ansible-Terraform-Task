# target group
resource "aws_lb_target_group" "target-group" {
  target_type = var.target_type
  name        = var.target_group
  port        = var.port80
  protocol    = var.protocol-Http
  vpc_id      = var.vpcID

}

# attach instances to target group
resource "aws_lb_target_group_attachment" "nexus-ec2-target-group" {
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = var.nexus-id
  port             = 8081
}

resource "aws_lb_target_group_attachment" "sonarqube-ec2-target-group" {
  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = var.sonar-id
  port             = 9000
}


#load balancer
resource "aws_lb" "alb" {
  load_balancer_type = var.load_balancer_type
  name               = var.load_balancer_name
  internal           = false
  ip_address_type    = var.ip_address_type

  security_groups = [var.securityID]
  subnets         = [var.public-subnet-id1, var.public-subnet-id2]

}

# listner
resource "aws_lb_listener" "alb_listner" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.port80
  protocol          = var.protocol-Http

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn
  }
}



