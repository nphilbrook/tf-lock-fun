terraform {
  cloud {
    hostname = "tfe-pi-new.nick-philbrook.sbx.hashidemos.io"
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
  }
}

variable "sleep_duration_seconds" {
  description = "Number of seconds to sleep"
  type        = number
  default     = 1
}

resource "random_pet" "name" {
  prefix = timestamp()

  provisioner "local-exec" {
    command = "sleep ${var.sleep_duration_seconds}"
  }
}

output "name" {
  value = random_pet.name.id
}
