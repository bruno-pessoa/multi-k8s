docker build -t brunovpessoa/multi-client:latest -t brunovpessoa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t brunovpessoa/multi-server:latest -t brunovpessoa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t brunovpessoa/multi-worker:latest -t brunovpessoa/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push brunovpessoa/multi-client:latest
docker push brunovpessoa/multi-server:latest
docker push brunovpessoa/multi-worker:latest
docker push brunovpessoa/multi-client:$SHA
docker push brunovpessoa/multi-server:$SHA
docker push brunovpessoa/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=brunovpessoa/multi-server:$SHA
kubectl set image deployments/client-deployment client=brunovpessoa/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=brunovpessoa/multi-worker:$SHA
