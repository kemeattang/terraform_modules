terraform {
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = "0.50.0"
    }
  }
  required_version = ">= 1.3.9"
}
