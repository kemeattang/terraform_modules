# Examples
## Create alarms

``` hcl
module "cloudwatch" {
  source = "git@github.com:kemeattang/terraform_modules.git//aws/cloudwatch-alarm?ref=v1.1.0"

  alarm_description = "This metric monitors ${aws_autoscaling_group.this.name}"

  statistic = "Average"
  unit      = "Percent"

  metrics = {
    "${var.name}-CPUUtilization" = {
      namespace   = "AWS/EC2"
      threshold   = 80
      metric_name = "CPUUtilization"
      dimensions = {
        AutoScalingGroupName = aws_autoscaling_group.this.name
      }
    }
  }

  tags = local.tags
}
```
