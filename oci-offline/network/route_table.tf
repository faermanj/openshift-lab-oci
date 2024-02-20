resource "oci_core_route_table" "services_rt" {
  compartment_id = var.compartment_id
  vcn_id         = data.oci_core_vcn.vcn.id
  display_name  = var.subnets["openshift-services"]["route_table_name"]

  route_rules {
    network_entity_id = var.lpg_ocid
    description       = "Route for Quad 0"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }

}

resource "oci_core_route_table" "worker_rt" {
  compartment_id = var.compartment_id
  vcn_id         = data.oci_core_vcn.vcn.id
  display_name  = var.subnets["openshift-worker"]["route_table_name"]

  route_rules {
    network_entity_id = var.lpg_ocid
    description       = "Route for Quad 0"
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }

}