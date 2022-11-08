resource "aws_instance" "web-interface-1" {
  ami           = "ami-09d3b3274b6c5d4aa" # us-east-1
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  subnet_id = "subnet-056f34bb347f636d3"
  tags = {
    Name: "web-interface-1"
  }
}

resource "aws_instance" "web-interface-2" {
  ami           = "ami-09d3b3274b6c5d4aa" # us-east-1
  instance_type = "t2.micro"
  availability_zone = "us-east-1b"
  subnet_id = "subnet-0c2f8e48a1593aa2f"
  tags = {
    Name: "web-interface-2"
  }
}

resource "aws_instance" "app-1" {
  ami           = "ami-09d3b3274b6c5d4aa" # us-east-1
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  subnet_id = "subnet-056f34bb347f636d3"
  tags = {
    Name: "app-1"
  }
}

resource "aws_instance" "app-2" {
  ami           = "ami-09d3b3274b6c5d4aa" # us-east-1
  instance_type = "t2.micro"
  availability_zone = "us-east-1b"
  subnet_id = "subnet-0c2f8e48a1593aa2f"
  tags = {
    Name: "app-2"
  }
}

resource "aws_instance" "db-instance-1" {
  ami           = "ami-09d3b3274b6c5d4aa" # us-east-1
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  subnet_id = "subnet-0b7599358548cc6a1"
  tags = {
    Name: "db-instance-1"
  }
}

resource "aws_instance" "db-instance-2" {
  ami           = "ami-09d3b3274b6c5d4aa" # us-east-1
  instance_type = "t2.micro"
  availability_zone = "us-east-1b"
  subnet_id = "subnet-000046db07d2904f3"
  tags = {
    Name: "db-instance-2"
  }
}

resource "aws_lb_target_group" "webserver-group" {
  name     = "webserver-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0b22b3bf78334c6c1"
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
    "subnet-02731f13c6d1c338a", "subnet-05ae0c8702aa1e59f"
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
  vpc_id   = "vpc-0b22b3bf78334c6c1"
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
    "subnet-0c2f8e48a1593aa2f", "subnet-056f34bb347f636d3"
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
