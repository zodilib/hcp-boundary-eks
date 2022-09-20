resource "kubernetes_config_map" "nginx" {
  metadata {
    name = "nginx-config"
  }

  data = {
    "index.html" = <<EOF
<html>
<head>
    <title>Boundary Intranet Connection</title>
</head>
<body>
Your IP address is: <? echo $_SERVER["REMOTE_ADDR"]; ?>
</body>
</html>
EOF
  }
}
