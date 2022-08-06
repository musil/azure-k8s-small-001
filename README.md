# K8S in Azure
It will Create resource group, vnet and K8S cluster in azure. 
To limit access to cluster API from specific IP edit file "k8s-small.tf" and change  "YOUR_IP" to your public IP.

```
api_server_authorized_ip_ranges = ["YOUR_IP/32/"]
```

As worker node is used "Standard_B2s"

# How to create cluster via terraform
```
terraform init 
terraform plan
terraform apply
```

# How to destroy cluster
```
terraform destroy
```

# Infracost details
https://www.infracost.io/
```
infracost breakdown --path .
```

## output:

```
Module path: k8s-small-001

 Name                                                     Monthly Qty  Unit              Monthly Cost (EUR)

 azurerm_kubernetes_cluster.k8s-small-001
 ├─ default_node_pool
 │  ├─ Instance usage (pay as you go, Standard_B2s)               730  hours                         €34.36
 │  └─ os_disk
 │     └─ Storage (P10)                                             1  months                        €21.26
 ├─ Load Balancer
 │  └─ Data processed                                Monthly cost depends on usage: €0.004903285 per GB
 └─ DNS
    └─ Hosted zone                                                  1  months                         €0.49

 Project total (EUR)                                                                                 €56.11

 OVERALL TOTAL (EUR)                                                                                 €56.11
 ```
