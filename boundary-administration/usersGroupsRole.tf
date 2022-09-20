##############   USER 1 ######################

resource "boundary_auth_method" "password" {
  name        = "org_auth_method"
  description = "Password auth method for org"
  type        = "password"
  scope_id    = boundary_scope.org.id
}

resource "boundary_account_password" "test_account" {
  name           = "test_account"
  description    = "Test password account"
  type           = "password"
  login_name     = "tester01"
  password       = "supersecure"
  auth_method_id = boundary_auth_method.password.id
}

resource "boundary_user" "tester01" {
  name        = "tester01"
  description = "A test user"
  account_ids = [
     boundary_account_password.test_account.id
  ]
  scope_id    = boundary_scope.org.id
}

resource "boundary_group" "platform-team-group" {
  name        = "PlatformTeamGroup"
  description = "Platform Team Group"
  member_ids  = [boundary_user.tester01.id]
  scope_id    = boundary_scope.org.id
}

resource "boundary_role" "read-only" {
  name            = "read-only"
  description     = "Role with read-only permission"
  scope_id        = boundary_scope.org.id
  principal_ids   = [boundary_user.tester01.id]
  grant_strings   = ["id=*;type=*;actions=read,list"]
}

######################################################