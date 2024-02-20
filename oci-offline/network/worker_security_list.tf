resource "oci_core_security_list" "worker-sl" {
  compartment_id = var.compartment_id
  vcn_id         = data.oci_core_vcn.vcn.id

  display_name = var.subnets["openshift-worker"]["security_list_name"]

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

    description = "Pod to Pod communication"
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

  egress_security_rules {
    #Required
    destination = var.subnets["openshift-services"]["cidr_block"]
    protocol = "6"

    description = "Worker to API communication"
    destination_type = "CIDR_BLOCK"

    tcp_options {
        max = 6443
        min = 6443
    }
  }

  ingress_security_rules {
      #Required
      protocol = "all"
      source = var.subnets["openshift-services"]["cidr_block"]

      #Optional
      description = "Allows control plane to worker communication."
      source_type = "CIDR_BLOCK"
  }

  ingress_security_rules {
    #Required
    protocol = "6"
    source = "10.234.8.172/32" #Bastion host

    #Optional
    description = "Allow ssh traffic from Work VM"
    source_type = "CIDR_BLOCK"

    tcp_options {
        max = 22
        min = 22
    }
  }

  ingress_security_rules {
    description = "Allows pods to pods communication from one worker to another."
    protocol    = "all"
    source      = "10.234.57.0/26"
    source_type = "CIDR_BLOCK"
    stateless   = false
  }
}
