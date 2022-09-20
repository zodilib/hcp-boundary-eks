resource "boundary_scope" "org" {
  scope_id                 = "global"
  name                     = "Platform_Engg"
  description              = "Platform Engg Team"
  auto_create_default_role = true
  auto_create_admin_role   = true
}


resource "boundary_scope" "project" {
  name             = "Platform_Tests"
  description      = "Manage test machines"

  # scope_id is taken from the org resource defined for 'Platform_Engg'
  scope_id                 = boundary_scope.org.id
  auto_create_admin_role   = true
  auto_create_default_role = true
}
