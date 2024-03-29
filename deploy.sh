docker build -t bkuhlen73/multi-client:latest -t bkuhlen73/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bkuhlen73/multi-server:latest -t bkuhlen73/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bkuhlen73/multi-worker:latest -t bkuhlen73/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bkuhlen73/multi-client:latest
docker push bkuhlen73/multi-server:latest
docker push bkuhlen73/multi-worker:latest

docker push bkuhlen73/multi-client:$SHA
docker push bkuhlen73/multi-server:$SHA
docker push bkuhlen73/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bkuhlen73/multi-server:$SHA
kubectl set image deployments/client-deployment client=bkuhlen73/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bkuhlen73/multi-worker:$SHA
