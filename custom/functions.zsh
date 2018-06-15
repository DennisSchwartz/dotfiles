function context() {
  if [[ "$1" == "cmp-dev" ]]; then
    kubectl config set-context gke_repositive-190911_us-east1-c_dev --namespace=cmp
    kubectl config use-context gke_repositive-190911_us-east1-c_dev
  elif [[ "$1" == "cmp-demo" ]]; then
    kubectl config set-context gke_repositive-190911_us-east1-c_dev --namespace=demo
    kubectl config use-context gke_repositive-190911_us-east1-c_dev
  elif [[ "$1" == "discover-staging" ]]; then
    kubectl config set-context k8s-staging.repositive.io --namespace=nih
    kubectl config use-context k8s-staging.repositive.io
  elif [[ "$1" == "mini" ]]; then
    kubectl config set-context minikube --namespace=demo
    kubectl config use-context minikube
  else
    echo "Not a valid context/namespace!"
  fi
}

function migrate() {
  if [[ "$1" != "" ]]; then
    docker-compose -f e2e-test.yml exec migration curl localhost:10101/act -d '{ "role":"migrate", "active":["'"$1"'"] }'
  else
    docker-compose -f e2e-test.yml exec migration curl localhost:10101/act -d '{ "role":"migrate" }'
  fi
}

function map() {
  if [[ "$1" != "" ]]; then
    docker-compose -f e2e-test.yml exec mapper curl localhost:10101/act -d '{ "role":"map", "repos":["'"$1"'"] }'
  else
    docker-compose -f e2e-test.yml exec mapper curl localhost:10101/act -d '{ "role":"map" }'
  fi
}

function index() {
  if [[ "$1" != "" ]]; then
    docker-compose -f e2e-test.yml exec indexer curl localhost:10101/act -d '{ "role":"enqueue", "scrapers":["'"$1"'"] }'
  else
    docker-compose -f e2e-test.yml exec indexer curl localhost:10101/act -d '{ "role":"enqueue" }'
  fi
}

