resource "oci_core_security_list" "services-sl" {
  compartment_id = var.compartment_id
  vcn_id         = data.oci_core_vcn.vcn.id

  #Optional
  display_name = var.subnets["openshift-services"]["security_list_name"]

  #TODO
  # Add ingress as needed

  ingress_security_rules {
     protocol    = "6"
     source      = "0.0.0.0/0"
     source_type = "CIDR_BLOCK"
     stateless   = false

     tcp_options {
         max = 443
         min = 443
      }
  }

  ingress_security_rules {
      #Required
      protocol = "all"
      source = var.subnets["openshift-worker"]["cidr_block"]

      #Optional
      description = "Allows worker to services communication."
      source_type = "CIDR_BLOCK"
  }

  egress_security_rules {
     description      = "All traffic "
     destination      = "0.0.0.0/0"
     destination_type = "CIDR_BLOCK"
     protocol         = "6"
     stateless        = false
  }

  egress_security_rules {
    #Required
    destination = var.subnets["openshift-worker"]["cidr_block"]
    protocol = "all"

    description = "Services to Worker communication"
    destination_type = "CIDR_BLOCK"
  }

  egress_security_rules {
      #Required
      destination = "all-phx-services-in-oracle-services-network"
      protocol = "6"

      #Optional
      description = "All OSN traffic"
      destination_type = "SERVICE_CIDR_BLOCK"
  }
}