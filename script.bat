@echo off

echo =================================
echo Criando as imagens Docker
echo =================================

docker build -t shockley09/php-backend:1.0 backend/.
docker build -t shockley09/db_mensagens:1.0 database/.

echo =================================
echo Enviando imagens para o Docker Hub
echo =================================

docker push shockley09/php-backend:1.0
docker push shockley09/db_mensagens:1.0

echo =================================
echo Aplicando manifests no Kubernetes
echo =================================

REM DATABASE - STORAGE
kubectl apply -f k8s-database/pv.yml
kubectl apply -f k8s-database/pvc.yml

REM DATABASE - APP
kubectl apply -f k8s-database/db-deployment.yml
kubectl apply -f k8s-database/db-service.yml

REM BACKEND
kubectl apply -f k8s-backend/backend-deployment.yml
kubectl apply -f k8s-backend/backend-service-lb.yml

echo =================================
echo Deploy finalizado com sucesso!
echo =================================

pause
