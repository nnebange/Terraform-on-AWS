# outputs.tf for count meta argument
  
output "user_arn" {
    value = aws_iam_user.clovis.*.arn
  
}

# outputs.tf for each meta argument
output "all_users" {
  value = aws_iam_user.neba
}