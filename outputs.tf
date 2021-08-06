output "address" {
  value = "${aws_instance.instance-MW.public_ip}"
}