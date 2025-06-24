# 📘 Kube-News

*ᴘᴛ-ʙʀ* Uma aplicação de notícias desenvolvida em NodeJS para demonstrar o uso de containers e Kubernetes.  
*ᴇɴ* A news application built with NodeJS to demonstrate containerization and Kubernetes deployment.

---

## 📋 Sobre o Projeto | About the Project

*ᴘᴛ-ʙʀ* O Kube-News é uma aplicação web simples desenvolvida em Node.js, projetada como exemplo para demonstrar o uso de contêineres.  
*ᴇɴ* Kube-News is a simple Node.js web app designed to demonstrate the use of containers and orchestration with Kubernetes.

### 🚀 Funcionalidades Principais | Main Features

- *ᴘᴛ-ʙʀ* Listagem, visualização e criação de notícias  
- *ᴇɴ* List, view and create news articles  
- *ᴘᴛ-ʙʀ* API REST para inserção em massa de notícias  
- *ᴇɴ* REST API for bulk insertion of news  
- *ᴘᴛ-ʙʀ* Endpoints de health check para monitoramento  
- *ᴇɴ* Health check endpoints for monitoring  
- *ᴘᴛ-ʙʀ* Coleta de métricas Prometheus  
- *ᴇɴ* Prometheus metrics collection  
- *ᴘᴛ-ʙʀ* Simulação de falhas para testes de resiliência  
- *ᴇɴ* Failure simulation for resilience testing

---

## 🛠️ Tecnologias Utilizadas | Technologies Used

- **Backend**: Node.js + Express  
- **Frontend**: EJS Templates  
- **Banco de Dados | Database**: PostgreSQL + Sequelize  
- **Monitoramento | Monitoring**: Prometheus via `express-prom-bundle`

---

## 📦 Estrutura do Projeto | Project Structure

```

/
├── src/
│   ├── models/               # *ᴘᴛ-ʙʀ* Modelos de dados | *ᴇɴ* Data models
│   ├── views/                # *ᴘᴛ-ʙʀ* Templates EJS
│   ├── static/               # *ᴘᴛ-ʙʀ* Arquivos estáticos | *ᴇɴ* Static files
│   ├── middleware.js
│   ├── server.js             # *ᴘᴛ-ʙʀ* Entrada da aplicação | *ᴇɴ* App entry point
│   ├── system-life.js        # *ᴘᴛ-ʙʀ* Endpoints de health check
│   └── package.json
├── k8s/                      # *ᴘᴛ-ʙʀ* Arquivos Kubernetes | *ᴇɴ* Kubernetes manifests
├── popula-dados.http         # *ᴘᴛ-ʙʀ* API para dados de teste | *ᴇɴ* Sample data API calls
└── README.md

````

---

## 🔧 Configuração | Configuration

### Variáveis de Ambiente | Environment Variables

| Variável         | Descrição *ᴘᴛ-ʙʀ* / Description *ᴇɴ*         | Padrão / Default |
|------------------|----------------------------------------|------------------|
| DB_DATABASE      | Nome do banco / Database name          | kubedevnews      |
| DB_USERNAME      | Usuário do banco / DB user             | kubedevnews      |
| DB_PASSWORD      | Senha / Password                       | Pg#123           |
| DB_HOST          | Host do banco / DB host                | localhost        |
| DB_PORT          | Porta / Port                           | 5432             |
| DB_SSL_REQUIRE   | SSL habilitado? / SSL enabled?         | false            |
| APP_PORT         | Porta da aplicação / App port          | 8080             |

---

## 🚀 Execução Local | Local Execution

1. *ᴘᴛ-ʙʀ* Clone o repositório / *ᴇɴ* Clone the repository  
2. Instale dependências:  
   ```bash
   cd src
   npm install

3. Configure as variáveis de ambiente / Set environment variables
4. Inicie a aplicação / Start the app:

   ```bash
   npm start
   ```
5. Acesse / Access: [http://localhost:8080](http://localhost:8080)

---

## 📊 Monitoramento e Health Checks | Monitoring and Health Checks

| Endpoint           | *ᴘᴛ-ʙʀ* Descrição               | *ᴇɴ* Description             |
| ------------------ | ---------------------------- | ---------------------------- |
| `/health`          | Estado geral                 | Overall health               |
| `/ready`           | Pronto?                      | Ready check                  |
| `/metrics`         | Métricas                     | Prometheus metrics           |
| `/unhealth`        | Simula falha                 | Simulate failure             |
| `/unreadyfor/:seg` | Indisponível temporariamente | Temporary unready simulation |

---

## 🔒 Modelo de Dados | Data Model

| Campo       | Tipo   | *ᴘᴛ-ʙʀ* Descrição     | *ᴇɴ* Description |
| ----------- | ------ | ------------------ | ---------------- |
| title       | String | Título da notícia  | News title       |
| summary     | String | Resumo da notícia  | News summary     |
| content     | String | Conteúdo completo  | Full content     |
| publishDate | Date   | Data de publicação | Publish date     |

---

---

## ☸️ Execução com Kubernetes | Running on Kubernetes

Este projeto pode ser executado em clusters locais como **Kind** ou **K3d**.
This project can run in local clusters using **Kind** or **K3d**.

### 📁 Arquivos úteis | Useful files

* `k8s/kind.manifest.yml`: *ᴘᴛ-ʙʀ* Configuração do cluster Kind / *ᴇɴ* Kind cluster config
* `k8s/deployment.yml`: *ᴘᴛ-ʙʀ* Manifesto da aplicação e banco / *ᴇɴ* App and DB deployment manifest

### 🧪 Como aplicar | How to apply

```bash
kubectl apply -f k8s/
```

---

## 🔐 Secret obrigatório | Required Secret

Antes de aplicar o deployment, crie um arquivo chamado `secret.yaml`:
Before deploying, create a file named `secret.yaml`:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: kube-news-secrets
type: Opaque
stringData:
  POSTGRES_DB: dbname
  POSTGRES_USER: dbuser
  POSTGRES_PASSWORD: dbpassword
  DB_DATABASE: dbname
  DB_USERNAME: dbuser
  DB_PASSWORD: dbpassword
  DB_HOST: kube-news-db-service
```

> ⚠️ O valor de `DB_HOST` **deve ser exatamente igual** ao `metadata.name` do `Service` do banco definido no `deployment.yml`.
> ⚠️ The value of `DB_HOST` **must exactly match** the `Service` name of the database defined in `deployment.yml`.

Estas variáveis são **obrigatórias** para que a aplicação e o banco funcionem corretamente.
These variables are **required** by both the application and the database.

> 🔐 Em produção, recomenda-se o uso de ferramentas como Sealed Secrets ou External Secrets Operator.
> 🔐 In production, it is recommended to use tools such as Sealed Secrets or External Secrets Operator.