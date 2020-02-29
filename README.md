# Validate Deprecated K8s API Versions With Conftest

As the Kubernetes API evolves, APIs are periodically reorganized or upgraded. When APIs evolve, the old API is deprecated and eventually removed.

The v1.16 release will stop serving the following deprecated API versions in favor of newer and more stable API versions.

You can find the full details on the deprecated APIs in 1.16 [here](https://kubernetes.io/blog/2019/07/18/api-deprecations-in-1-16/)

With this major deprecation of old APIs you'll probably find a lot of users still using the older APIs. Usually this is because of copy/paste of older examples or they just don't know that they are using an older API version.

Instead of users finding out the hard way with cryptic error messages we can move the validation into our CI pipline that gives the user immediate feedback with a frindly error message on the deprecated APIs they are using.

## Using Conftest and Open Policy Agent For Validating Kubernetes API Versions

Conftest is a utility to help you write tests against structured configuration data. For instance you could write tests for your Kubernetes configurations, Terraform code, Serverless configs or any other structured data. In our context we will use it to write validation policies for deprecated Kubernetes API versions.

Conftest relies on the Rego language from [Open Policy Agent](https://www.openpolicyagent.org/) for writing the assertions. You can read more about Rego in [How do I write policies](https://www.openpolicyagent.org/docs/how-do-i-write-policies.html) in the Open Policy Agent documentation.

So to test this out, follow the below instructions:

You can find [installation instructions](https://github.com/instrumenta/conftest#installation) in the conftest repo README.

Now with conftest installed we can test our policies

```bash
git clone https://github.com/dstrebel/validate-k8s-apis
```

```bash
cd validate-k8s-apis
```

Let's first take a look at the OPA policies we have defined

```bash
cat ./policy/base.rego
```

You should see the following output

```bash
package main

deny[msg] {
  input.kind = "Deployment"
  not input.apiVersion = "apps/v1"
  validAPI = "apps/v1"
  msg := sprintf("%q API version %s is deprectated and not allowed. Please use %v apiVersion", [input.kind, input.apiVersion, validAPI])
}

deny[msg] {
  input.kind = "DaemonSet"
  not input.apiVersion = "apps/v1"
  validAPI = "apps/v1"
  msg := sprintf("%q API version %s is deprectated and not allowed. Please use %v apiVersion", [input.kind, input.apiVersion, validAPI])
}

deny[msg] {
  input.kind = "StatefulSet"
  not input.apiVersion = "apps/v1"
  validAPI = "apps/v1"
  msg := sprintf("%q API version %s is deprectated and not allowed. Please use %v apiVersion", [input.kind, input.apiVersion, validAPI])
}

deny[msg] {
  input.kind = "ReplicaSet"
  not input.apiVersion = "apps/v1"
  validAPI = "apps/v1"
  msg := sprintf("%q API version %s is deprectated and not allowed. Please use %v apiVersion", [input.kind, input.apiVersion, validAPI])
}

deny[msg] {
  input.kind = "NetworkPolicy"
  not input.apiVersion = "networking.k8s.io/v1"
  validAPI = "networking.k8s.io/v1"
  msg := sprintf("%q API version %s is deprectated and not allowed. Please use %v apiVersion", [input.kind, input.apiVersion, validAPI])
}

deny[msg] {
  input.kind = "PodSecurityPolicy"
  not input.apiVersion = "policy/v1beta1"
  validAPI = "policy/v1beta1"
  msg := sprintf("%q API version %s is deprectated and not allowed. Please use %v apiVersion", [input.kind, input.apiVersion, validAPI])
}
```

The policies here are testing for the following:

- Checking for the object `Kind` in `input.kind`
- Checking for the `apiVersion` in `input.apiVersion` to validate it's not using older API Versions.

Now that we have are policies in place we can run conftest to test for any violations. I have provides a sample YAML file that contains all the deprecated API version for the objects we are interested in.

By default conftest will search the `policy` directory for any policies you have defined.

```bash
conftest all-in-one-test.yaml
```

You should recieve output like the below, as we are using the deprected API versions in our Kubernetes manifest file.

```bash
conftest test all-in-one-test.yaml

FAIL - all-in-one-test.yaml - "Deployment" API version apps/v1beta1 is deprectated and not allowed. Please use apps/v1 apiVersion
FAIL - all-in-one-test.yaml - "DaemonSet" API version apps/v1beta1 is deprectated and not allowed. Please use apps/v1 apiVersion
FAIL - all-in-one-test.yaml - "StatefulSet" API version apps/v1beta1 is deprectated and not allowed. Please use apps/v1 apiVersion
FAIL - all-in-one-test.yaml - "ReplicaSet" API version apps/v1beta1 is deprectated and not allowed. Please use apps/v1 apiVersion
FAIL - all-in-one-test.yaml - "NetworkPolicy" API version extensions/v1beta1 is deprectated and not allowed. Please use networking.k8s.io/v1 apiVersion
FAIL - all-in-one-test.yaml - "PodSecurityPolicy" API version extensions/v1beta1 is deprectated and not allowed. Please use policy/v1beta1 apiVersion
--------------------------------------------------------------------------------
PASS: 0/6
WARN: 0/6
FAIL: 6/6
```



### TODO
Add sample CI Pipeline for conftest