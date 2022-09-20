resource "boundary_host_catalog_static" "nginx" {
  name        = "nginx"
  description = "For nginx usage"
  scope_id    = boundary_scope.project.id
}


resource "boundary_host_static" "nginx-host" {
  name            = "nginx"
  description     = "Nginx Host"
  address         = "nginx"
  host_catalog_id = boundary_host_catalog_static.nginx.id
}

resource "boundary_host_set_static" "nginx-host-set" {
  name            = "nginx"
  description     = "Host set for nginx"
  host_catalog_id = boundary_host_catalog_static.nginx.id
  host_ids = [
      boundary_host_static.nginx-host.id
  ]
}


###########   REDIS #########################

resource "boundary_host_catalog_static" "redis" {
  name        = "redis"
  description = "redis targets"
  scope_id = boundary_scope.project.id
}

resource "boundary_host_static" "redis" {
  type            = "static"
  name            = "redis"
  description     = "redis container"
  address         = "redis"
  host_catalog_id = boundary_host_catalog_static.redis.id
}

resource "boundary_host_set_static" "redis_containers" {
  type            = "static"
  name            = "redis_containers"
  description     = "Host set for redis containers"
  host_catalog_id = boundary_host_catalog_static.redis.id
  host_ids        = [boundary_host_static.redis.id]
}


###########   POSTGRES #########################

resource "boundary_host_catalog_static" "postgres" {
  name        = "postgres"
  description = "postgres host catalog"
  scope_id = boundary_scope.project.id
}

resource "boundary_host_static" "postgres" {
  type            = "static"
  name            = "postgres"
  description     = "postgres container"
  address         = "postgres"
  host_catalog_id = boundary_host_catalog_static.postgres.id
}

resource "boundary_host_set_static" "postgres" {
  type            = "static"
  name            = "postgres"
  description     = "Host set for postgres containers"
  host_catalog_id = boundary_host_catalog_static.postgres.id
  host_ids        = [boundary_host_static.postgres.id]
}
