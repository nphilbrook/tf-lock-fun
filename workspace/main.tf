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

data "terracurl_request" "wait" {
  method         = "GET"
  name           = "wait"
  response_codes = ["200"]
  url            = "http://localhost:8080/"
}

resource "random_pet" "name" {
  prefix = timestamp()
}

output "name" {
  value = random_pet.name.id
}
