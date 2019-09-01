docker build -t deenar/multi-client:latest -t deenar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t deenar/multi-server:latest -t deenar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t deenar/multi-worker:latest -t deenar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push deenar/multi-client:latest
docker push deenar/multi-server:latest
docker push deenar/multi-worker:latest

docker push deenar/multi-client:$SHA
docker push deenar/multi-server:$SHA
docker push deenar/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=deenar/multi-server:$SHA
kubectl set image deployments/client-deployment client=deenar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=deenar/multi-worker:$SHA