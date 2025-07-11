resource "aws_instance" "vprofile-bastion" {
  ami           = lookup(var.AMI, var.AWS_REGION)
  instance_type = "t2.micro"
  key_name      = aws_key_pair.vprofilekey.key_name

  vpc_security_group_ids = [aws_security_group.vprofile-bastion-sg.id]
  subnet_id              = module.vpc.public_subnets[0]
  count                  = var.instance_count

  tags = {
    Name    = "vProfile Bastion Host"
    Project = "vProfile"
  }

  provisioner "file" {
    content = templatefile("templates/db-deploy.tmpl", {
      rds-endpoint = aws_db_instance.vprofile-rds.address,
      dbuser       = var.dbuser,
      dbpass       = var.dbpass,
      dbname       = var.dbname,
    })
    destination = "/tmp/vprofile-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/vprofile-dbdeploy.sh",
      "sudo /tmp/vprofile-dbdeploy.sh"
    ]
    connection {
      type        = "ssh"
      user        = var.USERNAME
      private_key = file(var.PRIV_KEY_PATH)
      host        = self.public_ip
    }

  }

  depends_on = [aws_db_instance.vprofile-rds]

  lifecycle {
    create_before_destroy = true
  }

}