function context() {
  if [[ "$1" == "pdx" ]]; then
    kubectl config set-context k8s-staging.repositive.io --namespace=pdx
  elif [[ "$1" == "staging" ]]; then
    kubectl config set-context k8s-staging.repositive.io --namespace=default
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

