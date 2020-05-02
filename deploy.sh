#build all our images, tag each one, push each to docker hub
docker build -t sathyajith91/multi-client:latest -t sathyajith91/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sathyajith91/multi-server:latest -t sathyajith91/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sathyajith91/multi-worker:latest -t sathyajith91/multi-worker:$SHA -f ./worker/Dockerfile ./worker

#push each to docker hub
docker push sathyajith91/multi-client:latest
docker push sathyajith91/multi-server:latest
docker push sathyajith91/multi-worker:latest

docker push sathyajith91/multi-client:$SHA
docker push sathyajith91/multi-server:$SHA
docker push sathyajith91/multi-worker:$SHA

#apply all configs in the k8s flder
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sathyajith91/multi-server:$SHA
kubectl set image deployments/client-deployment client=sathyajith91/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sathyajith91/multi-worker:$SHA
