data "archive_file" "function_zip" {
  type        = "zip"
  source_dir  = "src"
  output_path = "dist/function.zip"
}

data "aws_lambda_layer_version" "php_73" {
  layer_name = "php-73"
}

resource "aws_lambda_function" "function" {
  filename = "${data.archive_file.function_zip.output_path}"
  function_name = "${var.app_name}-function"
  role = "${aws_iam_role.lambda_exec.arn}"
  handler = "index.php"
  source_code_hash = "${data.archive_file.function_zip.output_base64sha256}"
  runtime = "provided"
  memory_size = 128
  timeout = 60
  layers = [
    "${data.aws_lambda_layer_version.php_73}"
  ]
  vpc_config {
    subnet_ids = [
      "${data.aws_subnet.private_suba.id}", "${data.aws_subnet.private_subc.id}"
    ]
    security_group_ids = [
      "${aws_security_group.lambda_exec.id}"
    ]
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda-${var.app_name}-exec"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_exec" {
  name = "${aws_iam_role.lambda_exec.name}-policy"
  role = "${aws_iam_role.lambda_exec.id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:*:*:*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_vpc_attach" {
  role       = "${aws_iam_role.lambda_exec.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCCrossAccountNetworkInterfaceOperations"
}

resource "aws_iam_role_policy_attachment" "lambda_execute_attach" {
  role       = "${aws_iam_role.lambda_exec.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaExecute"
}

resource "aws_iam_role_policy_attachment" "lambda_basic_attach" {
  role       = "${aws_iam_role.lambda_exec.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
