docker build -t syodocker001/multi-client:latest -t syodocker001/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t syodocker001/multi-server:latest -t syodocker001/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t syodocker001/multi-worker:latest -t syodocker001/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push syodocker001/multi-client:latest
docker push syodocker001/multi-server:latest
docker push syodocker001/multi-worker:latest

docker push syodocker001/multi-client:$SHA
docker push syodocker001/multi-server:$SHA
docker push syodocker001/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=syodocker001/multi-server:$SHA
kubectl set image deployments/client-deployment client=syodocker001/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=syodocker001/multi-worker:$SHA