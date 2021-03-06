# Functions Policies

resource "oci_identity_policy" "FoggyKitchenFunctionsServiceReposAccessPolicy" {
  name = "FoggyKitchenFunctionsServiceReposAccessPolicy"
  description = "FoggyKitchenFunctionsServiceReposAccessPolicy"
  compartment_id = var.tenancy_ocid
  statements = ["Allow service FaaS to read repos in tenancy"]
}

resource "oci_identity_policy" "FoggyKitchenFunctionsDevelopersManageAccessPolicy" {
  name = "FoggyKitchenFunctionsDevelopersManageAccessPolicy"
  description = "FoggyKitchenFunctionsDevelopersManageAccessPolicy"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  statements = ["Allow group Administrators to manage functions-family in compartment id ${oci_identity_compartment.FoggyKitchenCompartment.id}",
                "Allow group Administrators to read metrics in compartment id ${oci_identity_compartment.FoggyKitchenCompartment.id}"]
}

resource "oci_identity_policy" "FoggyKitchenFunctionsDevelopersManageNetworkAccessPolicy" {
  name = "FoggyKitchenFunctionsDevelopersManageNetworkAccessPolicy"
  description = "FoggyKitchenFunctionsDevelopersManageNetworkAccessPolicy"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  statements = ["Allow group Administrators to use virtual-network-family in compartment id ${oci_identity_compartment.FoggyKitchenCompartment.id}"]
}

resource "oci_identity_policy" "FoggyKitchenFunctionsServiceNetworkAccessPolicy" {
  name = "FoggyKitchenFunctionsServiceNetworkAccessPolicy"
  description = "FoggyKitchenFunctionsServiceNetworkAccessPolicy"
  compartment_id = var.tenancy_ocid
  statements = ["Allow service FaaS to use virtual-network-family in compartment id ${oci_identity_compartment.FoggyKitchenCompartment.id}"]
}

resource "oci_identity_dynamic_group" "FoggyKitchenFunctionsServiceDynamicGroup" {
    name = "FoggyKitchenFunctionsServiceDynamicGroup"
    description = "FoggyKitchenFunctionsServiceDynamicGroup"
    compartment_id = var.tenancy_ocid
    matching_rule = "ALL {resource.type = 'fnfunc', resource.compartment.id = '${oci_identity_compartment.FoggyKitchenCompartment.id}'}"
}

resource "oci_identity_policy" "FoggyKitchenFunctionsServiceDynamicGroupPolicy" {
  depends_on = [oci_identity_dynamic_group.FoggyKitchenFunctionsServiceDynamicGroup]
  name = "FoggyKitchenFunctionsServiceDynamicGroupPolicy"
  description = "FoggyKitchenFunctionsServiceDynamicGroupPolicy"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  statements = ["allow dynamic-group ${oci_identity_dynamic_group.FoggyKitchenFunctionsServiceDynamicGroup.name} to manage all-resources in compartment id ${oci_identity_compartment.FoggyKitchenCompartment.id}"]
}

# API GW Policies

resource "oci_identity_policy" "FoggyKitchenManageAPIGWFamilyPolicy" {
  name = "FoggyKitchenManageAPIGWFamilyPolicy"
  description = "FoggyKitchenManageAPIGWFamilyPolicy"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  statements = ["Allow group Administrators to manage api-gateway-family in compartment id ${oci_identity_compartment.FoggyKitchenCompartment.id}"]
}

resource "oci_identity_policy" "FoggyKitchenManageVCNFamilyPolicy" {
  name = "FoggyKitchenManageVCNFamilyPolicy"
  description = "FoggyKitchenManageVCNFamilyPolicy"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  statements = ["Allow group Administrators to manage virtual-network-family in compartment id ${oci_identity_compartment.FoggyKitchenCompartment.id}"]
}

resource "oci_identity_policy" "FoggyKitchenUseFnFamilyPolicy" {
  name = "FoggyKitchenUseFnFamilyPolicy"
  description = "FoggyKitchenUseFnFamilyPolicy"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  statements = ["Allow group Administrators to use functions-family in compartment id ${oci_identity_compartment.FoggyKitchenCompartment.id}"]
}

resource "oci_identity_policy" "FoggyKitchenAnyUserUseFnPolicy" {
  name = "FoggyKitchenAnyUserUseFnPolicy"
  description = "FoggyKitchenAnyUserUseFnPolicy"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  statements = ["ALLOW any-user to use functions-family in compartment id ${oci_identity_compartment.FoggyKitchenCompartment.id} where ALL { request.principal.type= 'ApiGateway' , request.resource.compartment.id = '${oci_identity_compartment.FoggyKitchenCompartment.id}'}"]
}