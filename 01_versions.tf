terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.72"
    }    
    local = {
        source  = "hashicorp/local"
        version = "2.4.0"
    }
    template = {
        source  = "hashicorp/template"
        version = "2.2.0"
    }
    null = {
      source  = "hashicorp/null"
        version = ">= 3.2.1"
    }
    http = {
      source  = "hashicorp/http"
        version = ">= 3.4.0"
    }   
  }
  required_version = ">= 1.5.0"
}
