helm install mongo --values mongo_config.yaml bitnami/mongodb || true
sleep 10
helm install ingress-nginx ingress-nginx/ingress-nginx || true
sleep 10
helm install test Helm-app/ || true
