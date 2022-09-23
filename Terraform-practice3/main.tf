
#main.tf for count meta argument

resource "aws_iam_user" "clovis" {
  count = "${length(var.username)}"
  name = "${element(var.username,count.index )}"
}

#main.tf using for each meta argument

resource "aws_iam_user" "neba" {
  for_each = toset(var.username)
  name     = each.value
}