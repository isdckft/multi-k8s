docker build -t isdckft/multi-client-k8s:latest -t isdckft/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t isdckft/multi-server-k8s:latest -t isdckft/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t isdckft/multi-worker-k8s:latest -t isdckft/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push isdckft/multi-client-k8s:latest
docker push isdckft/multi-server-k8s:latest
docker push isdckft/multi-worker-k8s:latest

docker push isdckft/multi-client-k8s:$SHA
docker push isdckft/multi-server-k8s:$SHA
docker push isdckft/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=isdckft/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=isdckft/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=isdckft/multi-worker-k8s:$SHA