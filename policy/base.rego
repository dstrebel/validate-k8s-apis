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