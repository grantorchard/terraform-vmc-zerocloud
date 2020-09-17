locals {
  aws_account_number = data.terraform_remote_state.aws-core.outputs.account_id
}

provider "vmc" {
  refresh_token = var.refresh_token
}

data vmc_connected_accounts "this" {
  account_number = local.aws_account_number
}

data vmc_customer_subnets "this" {
  connected_account_id = data.vmc_connected_accounts.this.ids[0]
  region               = var.region
}

/*
resource "vmc_sddc" "sddc_1" {
  sddc_name           = var.sddc_name
  vpc_cidr            = var.vpc_cidr
  num_host            = var.sddc_num_hosts
  provider_type       = "AWS"
  region              = data.vmc_customer_subnets.my_subnets.region
  vxlan_subnet        = var.vxlan_subnet
  delay_account_link  = false
  skip_creating_vxlan = false
  sso_domain          = "vmc.local"

  deployment_type = "SingleAZ"

  account_link_sddc_config {
    customer_subnet_ids  = [data.vmc_customer_subnets.my_subnets.ids[0]]
    connected_account_id = data.vmc_connected_accounts.my_accounts.ids[0]
  }
  timeouts {
    create = "300m"
    update = "300m"
    delete = "180m"
  }
}
*/

