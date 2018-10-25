terraform {
  backend "pg" {}
}

provider "heroku" {
  version = "~> 1.5"
}
