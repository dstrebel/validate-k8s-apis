package main

deny[msg] {
  input.kind = "Deployment"
  validAPI = "apps/v1"
  not input.apiVersion = validAPI
  msg := sprintf("%q API version %s is deprectated and not allowed. Please use %v apiVersion", [input.kind, input.apiVersion, validAPI])
}

deny[msg] {
  input.kind = "DaemonSet"
  validAPI = "apps/v1"
  not input.apiVersion = validAPI
  msg := sprintf("%q API version %s is deprectated and not allowed. Please use %v apiVersion", [input.kind, input.apiVersion, validAPI])
}

deny[msg] {
  input.kind = "StatefulSet"
  validAPI = "apps/v1"
  not input.apiVersion = validAPI
  msg := sprintf("%q API version %s is deprectated and not allowed. Please use %v apiVersion", [input.kind, input.apiVersion, validAPI])
}

deny[msg] {
  input.kind = "ReplicaSet"
  validAPI = "apps/v1"
  not input.apiVersion = validAPI
  msg := sprintf("%q API version %s is deprectated and not allowed. Please use %v apiVersion", [input.kind, input.apiVersion, validAPI])
}

deny[msg] {
  input.kind = "NetworkPolicy"
  validAPI = "networking.k8s.io/v1"
  not input.apiVersion = validAPI
  msg := sprintf("%q API version %s is deprectated and not allowed. Please use %v apiVersion", [input.kind, input.apiVersion, validAPI])
}

deny[msg] {
  input.kind = "PodSecurityPolicy"
  validAPI = "policy/v1beta1"
  not input.apiVersion = validAPI
  msg := sprintf("%q API version %s is deprectated and not allowed. Please use %v apiVersion", [input.kind, input.apiVersion, validAPI])
}