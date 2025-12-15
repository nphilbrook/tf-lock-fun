terraform {
  cloud {
    hostname     = "tfe-pi-new.nick-philbrook.sbx.hashidemos.io"
    organization = "philbrook-tfe"
    workspaces {
      name = "lock-file-test"
    }
  }
  required_providers {
    random = {
      source  = "tfe-pi-new.nick-philbrook.sbx.hashidemos.io/philbrook-tfe/random"
      version = "3.7.2"
    }
    terracurl = {
      source  = "devops-rob/terracurl"
      version = "~>2.1"
    }
  }
}

# Force this resource to be re-created on every apply to have the intended effect (wait during apply)
# TF_CLI_ARGS="-replace=terracurl_request.wait" in your workspace ENV variables will do the trick
resource "terracurl_request" "wait" {
  method         = "GET"
  name           = "wait"
  response_codes = ["200"]
  url            = "http://localhost:8080/"
  timeout        = 7200
}

# This will be called on every plan
data "terracurl_request" "wait" {
  method         = "GET"
  name           = "wait"
  response_codes = ["200"]
  url            = "http://localhost:8080/"
  timeout        = 7200
}

resource "random_pet" "name" {
  prefix = timestamp()
}

output "name" {
  value = random_pet.name.id
}

output "wait_timestamp" {
  value = data.terracurl_request.wait.response
}
