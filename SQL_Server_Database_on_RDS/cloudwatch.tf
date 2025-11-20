
# Monitors and logs RDS and application performance
# Set up for RDS, ALB, and EC2 instances

resource "aws_sns_topic" "alarm_notifications" {
  name = "alarm-notifications"
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu_alarm" {
  alarm_name          = "rds-cpu-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarm when RDS CPU exceeds 80%"
  alarm_actions       = [aws_sns_topic.alarm_notifications.arn]
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.example.id
  }
}

resource "aws_cloudwatch_metric_alarm" "alb_unhealthy_hosts" {
  alarm_name          = "alb-unhealthy-hosts"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Alarm when ALB has less than 1 healthy host"
  dimensions = {
    LoadBalancer = aws_lb.app_lb.arn_suffix
    TargetGroup  = aws_lb_target_group.app_tg.arn_suffix
  }
  alarm_actions = [aws_sns_topic.alarm_notifications.arn]
}
