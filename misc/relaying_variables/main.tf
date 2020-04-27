variable "dbhost" {}
variable "dbname" {}
variable "dbuser" {}
variable "dbpass" {}
variable "dbport" {}

module "db" {
  source = "./db"
  /*
  * By passing variables in a map can simplify declarations on the module side.
  */
  params = {
    host = var.dbhost
    name = var.dbname
    user = var.dbuser
    pass = var.dbpass
    port = var.dbport
  }
}
