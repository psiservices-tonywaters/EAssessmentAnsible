#!/usr/bin/env bash

echo "Running OC binary"
oc version

oc login https://ocp.88-160-14-7bdf86.frn00006.cna.ukcloud.com:8443 --token=lK91HtlajPCNqXBxHp0bULjGTgi8nbJptFxt7I86XQA

oc project st-1
oc get pods -o jsonpath='services:{range .items[*]}{"\n- "}name: {.metadata.name}{"\n  "}value: {.status.podIP}{end}' > data

cat data

ansible-playbook playbook.yml




