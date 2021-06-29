docker build -t tolunardahanli/multi-client:latest -t tolunardahanli/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tolunardahanli/multi-server:latest -t tolunardahanli/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tolunardahanli/multi-worker:latest -t tolunardahanli/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push tolunardahanli/multi-client:latest
docker push tolunardahanli/multi-server:latest
docker push tolunardahanli/multi-worker:latest
docker push tolunardahanli/multi-client:$SHA
docker push tolunardahanli/multi-server:$SHA
docker push tolunardahanli/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tolunardahanli/multi-server:$SHA
kubectl set image deployments/client-deployment client=tolunardahanli/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tolunardahanli/multi-worker:$SHA
