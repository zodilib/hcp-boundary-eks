resource "kubernetes_config_map" "boundary" {
  metadata {
    name = "boundary-config"
  }

  data = {
    "boundary.hcl" = <<EOF
disable_mlock = true

hcp_boundary_cluster_id = ""  

listener "tcp" {
  address = "0.0.0.0:9202"
  purpose = "proxy"
}



worker {
  public_addr = ""
  auth_storage_path = "/home/boundary/worker1"
  tags {
    type = ["dev-worker", "aws"]
  }
}
EOF
  }
}
