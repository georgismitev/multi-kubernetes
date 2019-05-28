docker build -t "georgimitev/multi-client:latest" -t "georgimitev/multi-client:$SHA" -f ./client/Dockerfile ./client
docker build -t "georgimitev/multi-server:latest" -t "georgimitev/multi-server:$SHA" -f ./server/Dockerfile ./server
docker build -t "georgimitev/multi-worker:latest" -t "georgimitev/multi-worker:$SHA" -f ./worker/Dockerfile ./worker
docker push "georgimitev/multi-client:latest"
docker push "georgimitev/multi-client:$SHA"
docker push "georgimitev/multi-server:latest"
docker push "georgimitev/multi-server:$SHA"
docker push "georgimitev/multi-worker:latest"
docker push "georgimitev/multi-worker:$SHA"
kubectl apply -f k8s
kubectl set image deployments/client-deployment client="georgimitev/multi-client:$SHA"
kubectl set image deployments/server-deployment server="georgimitev/multi-server:$SHA"
kubectl set image deployments/worker-deployment worker="georgimitev/multi-worker:$SHA"
