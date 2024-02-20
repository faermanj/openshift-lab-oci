resource "oci_identity_dynamic_group" "openshift_master_nodes" {
    compartment_id = var.tenancy_ocid
    description    = "OpenShift master nodes" 
    matching_rule  = "all {instance.compartment.id='${var.instance_compartment_id}', tag.openshift-${var.cluster_name}.instance-role.value='master'}"
    name           = "${replace(var.cluster_name, "-", "_")}_master_nodes"
}

resource "oci_identity_policy" "openshift_master_nodes" {
    compartment_id = var.tenancy_ocid
    description    = "OpenShift master nodes instance principal"
    name           = "${replace(var.cluster_name, "-", "_")}_master_nodes"
    statements     = [
        "Allow dynamic-group ${replace(var.cluster_name, "-", "_")}_master_nodes to manage volume-family in compartment id ${var.instance_compartment_id}",
        "Allow dynamic-group ${replace(var.cluster_name, "-", "_")}_master_nodes to manage instance-family in compartment id ${var.instance_compartment_id}",
        "Allow dynamic-group ${replace(var.cluster_name, "-", "_")}_master_nodes to manage security-lists in compartment id ${var.compartment_id}",
        "Allow dynamic-group ${replace(var.cluster_name, "-", "_")}_master_nodes to use virtual-network-family in compartment id ${var.compartment_id}",
        "Allow dynamic-group ${replace(var.cluster_name, "-", "_")}_master_nodes to manage load-balancers in compartment id ${var.compartment_id}",
    ]
}

resource "oci_identity_dynamic_group" "openshift_worker_nodes" {
  compartment_id = var.tenancy_ocid
  description    = "OpenShift worker nodes"
  matching_rule  = "all {instance.compartment.id='${var.instance_compartment_id}', tag.openshift-${var.cluster_name}.instance-role.value='worker'}"
  name           = "${replace(var.cluster_name, "-", "_")}_worker_nodes"
}