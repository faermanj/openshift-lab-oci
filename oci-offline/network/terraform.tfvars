user_ocid="ocid1.user.oc1..aaaaaaaaqxfk2f2bruksl7ddzuyvihcuih5nflo7wtukvbwnht6kf3bapfea"
fingerprint="88:6e:d4:c7:6e:2c:25:f2:da:8e:53:af:88:d9:c9:be"
private_key_path="/home/opc/.ssh/admin_sn_private.pem"
region="us-phoenix-1"

tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaaazpr6sxedtynouhqva35ythaoivr2oftg5xjsuivm2xo56rrqgzq"
compartment_id="ocid1.compartment.oc1..aaaaaaaa6ten5njagrbwkagh5jjlnqdrd2a4vww6bhx6u4jx6dr2ctu2xnfa"
instance_compartment_id="ocid1.compartment.oc1..aaaaaaaadlatkmjlmeiicl3oin4zzvoo5kux7b62r3cipkeajygqvog557ta"
lpg_ocid="ocid1.localpeeringgateway.oc1.phx.aaaaaaaan2rrwwspqgqe3e7bbh5v6d5kcj5xjbpwyjqtlqvst56eirx3vvwa"

subnets = {
  "openshift-services"  : {
    "route_table_name"  : "openshift-services-rt",
    "cidr_block"        : "10.234.56.0/24",
    "security_list_name"  : "openshift-services-sl"
  },
  "openshift-worker"  : {
    "route_table_name"  : "openshift-worker-rt",
    "cidr_block"        : "10.234.57.0/26"
    "security_list_name"  : "openshift-worker-sl"
  }
}
