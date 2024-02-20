data "oci_identity_compartment" "network" {
  id = "ocid1.compartment.oc1..aaaaaaaao5xbcknawhdvbgg36bfujcr7btfzexwngggwdwthsg5wzgufs75a"
}

data "oci_core_vcn" "core-hub" {
 vcn_id = "ocid1.vcn.oc1.phx.amaaaaaacplbiayamz5arhgzz33fb7yxgtca6c5y6nvkwnxz3fv2oulfgkoq"
}

data "oci_core_local_peering_gateways" "oke_lpg" {
    compartment_id = var.compartment_id
}

data "oci_core_service_gateways" "oke_sgw" {
    compartment_id = var.compartment_id
}
