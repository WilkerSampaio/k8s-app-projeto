#  Kubernetes Projeto App Base (DevOps)

Projeto técnico focado em **containerização, orquestração e automação de deploy** utilizando **Docker**, **Docker Hub** e **Kubernetes (Minikube)**.

Este repositório simula um **ambiente real de deploy DevOps**, com persistência de dados, separação de responsabilidades e automação via script.

---

##  Visão Geral da Arquitetura

**Stack utilizada:**

* Backend: PHP 7.4 + Apache
* Banco de Dados: MySQL 5.7
* Containerização: Docker
* Orquestração: Kubernetes
* Cluster Local: Minikube

**Componentes Kubernetes:**

* `Deployment` para backend
* `Service` para backend (`LoadBalancer`)
* `Deployment` para MySQL
* `Service` para MySQL (`ClusterIP`)
* `PersistentVolume` (PV)
* `PersistentVolumeClaim` (PVC)

---

##  Diagrama Lógico (Descrição)

```
[ Client ]
    |
    v
[ Service - LoadBalancer ]
    |
[ Pod PHP Backend ]
    |
[ Service - ClusterIP ]
    |
[ Pod MySQL ]
    |
[ PersistentVolume ]
```

---

##  Estrutura do Repositório

```text
k8s-projeto-app-base/
├─ backend/                    # Código da aplicação PHP
│  ├─ dockerfile
│  ├─ index.php
│  └─ conexao.php
│
├─ database/                   # Banco de dados MySQL
│  ├─ dockerfile
│  └─ script.sql
│
├─ k8s-backend/                # Manifests Kubernetes do backend
│  ├─ backend-deployment.yml
│  └─ backend-service-lb.yml
│
├─ k8s-database/               # Manifests Kubernetes do banco
│  ├─ pv.yml
│  ├─ pvc.yml
│  ├─ db-deployment.yml
│  └─ db-service.yml
│
└─ script.bat                  # Script de automação de deploy
```

---

##  Pré-requisitos Técnicos

* Docker Desktop
* kubectl
* Minikube
* Conta no Docker Hub

Validação do ambiente:

```bash
docker --version
kubectl version --client
minikube version
```

---

##  Pipeline de Deploy (Automatizado)

O arquivo `script.bat` executa o pipeline completo:

1. Build das imagens Docker
2. Push das imagens para o Docker Hub
3. Criação do PersistentVolume
4. Criação do PersistentVolumeClaim
5. Deploy do MySQL
6. Deploy do Backend

### Execução

```bat
.\script.bat
```

O script é **idempotente**: múltiplas execuções não recriam recursos já existentes.

---

##  Persistência de Dados

### PersistentVolume

* Tipo: `hostPath`
* Capacidade: 1Gi
* AccessMode: `ReadWriteOnce`
* ReclaimPolicy: `Retain`

 `hostPath` é utilizado **apenas para ambiente local (Minikube)**.

### PersistentVolumeClaim

* Solicitação: 1Gi
* Vinculação automática ao PV disponível

---

##  Exposição do Backend

O backend é exposto via `Service` do tipo `LoadBalancer`.

Acesso no Minikube:

```bash
minikube service php-service
```

---

##  Observabilidade Básica

Verificação de estado do cluster:

```bash
kubectl get pods
kubectl get svc
kubectl get pv
kubectl get pvc
```

Debug de falhas:

```bash
kubectl describe pod <pod-name>
kubectl logs <pod-name>
```

---

##  Cleanup do Ambiente

```bash
kubectl delete -f k8s-backend/
kubectl delete -f k8s-database/
```
