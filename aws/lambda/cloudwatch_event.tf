resource "aws_lambda_permission" "allow_to_invoke_func" {
  statement_id  = "AllowExecutionFromCloudWatch"
  function_name = aws_lambda_function.func.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.minutely.arn
  /*
  To enable trigger, uncomment this line instead of the line below.
  action        = "lambda:InvokeFunction"
  */
  action = "lambda:DisableInvokeFunction"
}

resource "aws_cloudwatch_event_rule" "minutely" {
  name                = "minutely"
  schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_event_target" "invoke_func_minutely" {
  rule      = aws_cloudwatch_event_rule.minutely.name
  target_id = "invoke-arch-taskmgr"
  arn       = aws_lambda_function.func.arn
}

resource "aws_lambda_function" "func" {
  filename         = data.archive_file.function_zip.output_path
  function_name    = "${var.app_name}-function"
  handler          = "index.handler"
  source_code_hash = data.archive_file.function_zip.output_base64sha256
  runtime          = "ruby2.5"
}
