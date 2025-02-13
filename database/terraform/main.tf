resource "postgresql_role" "api" {
  name     = "api"
  login    = true
  password = "password"
}

resource "postgresql_database" "api" {
  name  = "api"
  owner = "postgres"
  template = "template0"
}