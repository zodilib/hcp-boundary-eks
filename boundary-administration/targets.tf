resource "boundary_target" "kube-nginx-target" {
  type                     = "tcp"
  name                     = "nginx"
  description              = "nginx"
  scope_id                 = boundary_scope.project.id
  session_connection_limit = -1
  session_max_seconds      = 10000
  default_port             = 80
  host_source_ids = [
    boundary_host_set_static.nginx-host-set.id
  ]
  worker_filter            = "\"dev-worker\" in \"/tags/type\""
}


resource "boundary_target" "redis" {
  type                     = "tcp"
  name                     = "redis"
  description              = "Redis container"
  scope_id                 = boundary_scope.project.id
  session_connection_limit = -1
  session_max_seconds      = 10000
  default_port             = 6379
  host_source_ids = [
     boundary_host_set_static.redis_containers.id
   ]
  worker_filter            = "\"dev-worker\" in \"/tags/type\""
}


resource "boundary_target" "postgres" {
  type                     = "tcp"
  name                     = "postgres"
  description              = "Postgres container"
  scope_id                 = boundary_scope.project.id
  session_connection_limit = -1
  session_max_seconds      = 10000
  default_port             = 5432
  host_source_ids = [
     boundary_host_set_static.postgres.id
   ]
  worker_filter            = "\"dev-worker\" in \"/tags/type\""
}


