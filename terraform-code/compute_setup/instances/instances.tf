resource "aws_instance" "web-interface-1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  availability_zone = var.zone_1
  subnet_id = var.private_app_subnet_1_id
  tags = {
    Name: "web-interface-1"
  }
}

resource "aws_instance" "web-interface-2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  availability_zone = var.zone_2
  subnet_id = var.private_app_subnet_2_id
  tags = {
    Name: "web-interface-2"
  }
}

resource "aws_instance" "app-1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  availability_zone = var.zone_1
  subnet_id = var.private_app_subnet_1_id
  tags = {
    Name: "app-1"
  }
}

resource "aws_instance" "app-2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  availability_zone = var.zone_2
  subnet_id = var.private_app_subnet_2_id
  tags = {
    Name: "app-2"
  }
}

resource "aws_instance" "db-instance-1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  availability_zone = var.zone_1
  subnet_id = var.private_db_subnet_1_id
  tags = {
    Name: "db-instance-1"
  }
}

resource "aws_instance" "db-instance-2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  availability_zone = var.zone_2
  subnet_id = var.private_db_subnet_2_id
  tags = {
    Name: "db-instance-2"
  }
}

resource "aws_lb_target_group" "webserver-group" {
  name     = "webserver-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
resource "aws_lb_target_group_attachment" "webserver-attachment" {
  target_group_arn = aws_lb_target_group.webserver-group.id
  target_id        = aws_instance.web-interface-1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "webserver-attachment-2" {
  target_group_arn = aws_lb_target_group.webserver-group.id
  target_id        = aws_instance.web-interface-2.id
  port             = 80
}

resource "aws_lb" "webserver-lb" {
  name               = "webserver-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [
    var.public_subnet_1_id, var.public_subnet_2_id
  ]

}

resource "aws_lb_listener" "web_server_listener" {
  load_balancer_arn = aws_lb.webserver-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver-group.arn
  }
}

resource "aws_lb_target_group" "app-group" {
  name     = "app-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_target_group_attachment" "app-attachment" {
  target_group_arn = aws_lb_target_group.app-group.id
  target_id        = aws_instance.app-1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "app-attachment-2" {
  target_group_arn = aws_lb_target_group.app-group.id
  target_id        = aws_instance.app-2.id
  port             = 80
}

resource "aws_lb" "app-lb" {
  name               = "app-lb"
  internal           = true
  subnets            = [
    var.private_app_subnet_1_id, var.private_app_subnet_2_id
  ]
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app-group.arn
  }
}
