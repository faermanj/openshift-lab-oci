resource "oci_core_subnet" "openshift_services_subnet" {
    cidr_block = var.subnets["openshift-services"]["cidr_block"]
    compartment_id = var.compartment_id
    vcn_id = data.oci_core_vcn.vcn.id

    display_name = "openshift-services"
    prohibit_internet_ingress = true

    route_table_id = oci_core_route_table.services_rt.id
    security_list_ids = [oci_core_security_list.services-sl.id]
}

resource "oci_core_subnet" "openshift_worker_subnet" {
    cidr_block = var.subnets["openshift-worker"]["cidr_block"]
    compartment_id = var.compartment_id
    vcn_id = data.oci_core_vcn.vcn.id

    display_name = "openshift-worker"
    prohibit_internet_ingress = true

    route_table_id = oci_core_route_table.worker_rt.id
    security_list_ids = [oci_core_security_list.worker-sl.id]
}
