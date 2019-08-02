function context() {
  if [[ "$1" == "cmp-dev" ]]; then
    kubectl config set-context gke_repositive-190911_us-east1-c_dev --namespace=cmp
    kubectl config use-context gke_repositive-190911_us-east1-c_dev
  elif [[ "$1" == "cmp-demo" ]]; then
    kubectl config set-context gke_repositive-190911_us-east1-c_dev --namespace=demo
    kubectl config use-context gke_repositive-190911_us-east1-c_dev
  elif [[ "$1" == "cmp-production" ]]; then
    kubectl config set-context gke_repositive-190911_us-east1-c_production --namespace=cmp
    kubectl config use-context gke_repositive-190911_us-east1-c_production
  elif [[ "$1" == "discover-dev" ]]; then
    kubectl config set-context gke_repositive-190911_us-east1-c_discover-dev --namespace=discover
    kubectl config use-context gke_repositive-190911_us-east1-c_discover-dev
  elif [[ "$1" == "discover-production" ]]; then
    kubectl config set-context gke_repositive-190911_us-east1-c_discover --namespace=discover
    kubectl config use-context gke_repositive-190911_us-east1-c_discover
  elif [[ "$1" == "mini" ]]; then
    kubectl config set-context minikube --namespace=demo
    kubectl config use-context minikube
  elif [[ "$1" == "list" ]]; then
    echo "cmp-dev, cmp-demo, cmp-production, discover-dev, discover-production, mini"
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

function startEnv() {
  if [[ "$1" == "discover" ]]; then
    PATH_PREFIX = "/Users/dennis/Code/discover/docker"
  elif [[ "$1" == "cmp" ]]; then
    PATH_PREFIX = "/Users/dennis/Code/cmp/docker"
  else
    echo "Please specify a project! Accepted values: 'cmp', 'discover'."
    exit 1;
  fi
  bash "${PATH_PREFIX}/start.sh"
  echo "done."
  exit 0;
}

function stopEnv() {
  if [[ "$1" == "discover" ]]; then
    PATH_PREFIX = "/Users/dennis/Code/discover/docker"
  elif [[ "$1" == "cmp" ]]; then
    PATH_PREFIX = "/Users/dennis/Code/cmp/docker"
  else
    echo "Please specify a project! Accepted values: 'cmp', 'discover'."
    exit 1;
  fi
  bash "${PATH_PREFIX}/stop.sh"
  echo "done."
  exit 0;
}

