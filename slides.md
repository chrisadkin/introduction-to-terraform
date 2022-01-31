# An Introduction to Terraform

---

<img src="images/01.png">

---

## Infrastructure-As-Code 101

Infrastructure as code (IaC) is the process of managing and provisioning computer data centers through machine-readable definition files, rather than physical hardware configuration or interactive configuration tools.[1] The IT infrastructure managed by this process comprises both physical equipment, such as bare-metal servers, as well as virtual machines, and associated configuration resources. The definitions may be in a version control system. The code in the definition files may use either scripts or declarative definitions . . .

---

## Important Terms

- Imperitive

- Declarative

- Idempotency

- Drift

---

<img src="images/02.png" width="1920" height="550">

---

<img src="images/03.png" width="1920" height="550">

---

<img src="images/04.png" width="1920" height="550">

---

## Terraform in A Nutshell

- terraform comes in single executable form

- Declarative

- Stateful

- Agentless

- Written in GOLANG, the same language used for Kubernetes 

---

## Configurations

- A configuration is the unit of deployment

- Configurations are written in Hashicorp Control Language

- Cofigurations consist of one or more resources

- Resources are created via providers 

---

## A Basic Resource
```
resource "kubectl_manifest" "arc_sql_mi" {
  wait = true
  yaml_body = <<YAML
  .
  .
YAML

  provisioner "local-exec" {
    command = "This is a local provisioner"
  }

  depends_on = [
    kubernetes_secret.arc_sql_mi_login_secret
  ]
}
```

---

## Use Provisioners With **Caution**

- The code inside any provisioner cannot be modelled as a plan

- To undo the action of a provisioner, a destroy provisioner must be written

- Variables cannot be used inside of destroy provisioners

- Per [Hashicorp's documentation](https://www.terraform.io/language/resources/provisioners/syntax); provisioners are a last resort

- Never say to anyone that knows Terraform "You can put all the code inside a provisioner"
