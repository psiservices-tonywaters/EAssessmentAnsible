
echo "Running OC binary"
oc version

oc login https://ocp.88-160-14-7bdf86.frn00006.cna.ukcloud.com:8443 --token=lK91HtlajPCNqXBxHp0bULjGTgi8nbJptFxt7I86XQA

oc get pods -o jsonpath='{range .items[*]}{.metadata.name}:{.status.podIP}{"\n"}{end}'



