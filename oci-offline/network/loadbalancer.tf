resource "oci_network_load_balancer_network_load_balancer" "openshift_lb" {
  compartment_id             = var.compartment_id
  subnet_id                  = oci_core_subnet.openshift_services_subnet.id
  display_name               = "openshift_lb"
  is_private                 = true
  network_security_group_ids = [oci_core_network_security_group.cluster_lb_nsg.id]
}

locals {
  lb_private_addr = element([
    for address in oci_network_load_balancer_network_load_balancer.openshift_lb.ip_addresses :address 
    if address.is_public == false
], 0).ip_address
}

resource "oci_network_load_balancer_backend_set" "openshift_cluster_api_backend" {
    health_checker {
        protocol    = "HTTPS"
        port        = 6443
        return_code = 200
        url_path    = "/readyz"
    }
    name                     = "openshift_cluster_api_backend"
    network_load_balancer_id = oci_network_load_balancer_network_load_balancer.openshift_lb.id
    policy                   = "FIVE_TUPLE"
    is_preserve_source       = false
    depends_on               = [oci_network_load_balancer_network_load_balancer.openshift_lb]
}

resource "oci_network_load_balancer_listener" "openshift_cluster_api" {
    default_backend_set_name = oci_network_load_balancer_backend_set.openshift_cluster_api_backend.name
    name                     = "openshift_cluster_api"
    network_load_balancer_id = oci_network_load_balancer_network_load_balancer.openshift_lb.id
    port                     = 6443
    protocol                 = "TCP"
    depends_on               = [oci_network_load_balancer_backend_set.openshift_cluster_api_backend]
}

resource "oci_network_load_balancer_backend_set" "openshift_cluster_ingress_https_backend" {
    health_checker {
        protocol = "TCP"
        port     = 443
    }
    name                     = "openshift_cluster_ingress_https_backend"
    network_load_balancer_id = oci_network_load_balancer_network_load_balancer.openshift_lb.id
    policy                   = "FIVE_TUPLE"
    is_preserve_source       = false
}

resource "oci_network_load_balancer_listener" "openshift_cluster_ingress_https" {
    default_backend_set_name = oci_network_load_balancer_backend_set.openshift_cluster_ingress_https_backend.name
    name                     = "openshift_cluster_ingress_https"
    network_load_balancer_id = oci_network_load_balancer_network_load_balancer.openshift_lb.id
    port                     = 443
    protocol                 = "TCP"
    depends_on               = [oci_network_load_balancer_backend_set.openshift_cluster_ingress_https_backend]
}

resource "oci_network_load_balancer_backend_set" "openshift_cluster_infra-mcs_backend" {
    health_checker {
        protocol    = "HTTPS"
        port        = 22623
        url_path    = "/healthz"
        return_code = 200
    }
    name                     = "openshift_cluster_infra-mcs_backend"
    network_load_balancer_id = oci_network_load_balancer_network_load_balancer.openshift_lb.id
    policy                   = "FIVE_TUPLE"
    is_preserve_source       = false
    depends_on               = [oci_network_load_balancer_listener.openshift_cluster_ingress_https]
}

resource "oci_network_load_balancer_listener" "openshift_cluster_infra-mcs" {
    default_backend_set_name = oci_network_load_balancer_backend_set.openshift_cluster_infra-mcs_backend.name
    name                     = "openshift_cluster_infra-mcs"
    network_load_balancer_id = oci_network_load_balancer_network_load_balancer.openshift_lb.id
    port                     = 22623
    protocol                 = "TCP"
    depends_on               = [oci_network_load_balancer_backend_set.openshift_cluster_infra-mcs_backend]
}
