docker build -t bipulh/fibonacci-client:latest -t bipulh/fibonacci-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t bipulh/fibonacci-server:latest -t bipulh/fibonacci-server:$GIT_SHA  -f ./server/Dockerfile ./server
docker build -t bipulh/fibonacci-worker:latest -t bipulh/fibonacci-worker:$GIT_SHA  -f ./worker/Dockerfile ./worker

docker push bipulh/fibonacci-client:latest
docker push bipulh/fibonacci-server:latest
docker push bipulh/fibonacci-worker:latest

docker push bipulh/fibonacci-client:$GIT_SHA
docker push bipulh/fibonacci-server:$GIT_SHA
docker push bipulh/fibonacci-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bipulh/fibonacci-server:$GIT_SHA
kubectl set image deployments/client-deployment client=bipulh/fibonacci-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=bipulh/fibonacci-worker:$GIT_SHA