# 🚀 Deploy no Render – ABP 2025-2

Este guia explica como fazer o deploy **de um único container** que roda **frontend (React)** e **backend (Express + PostgreSQL)** no [Render](https://render.com).

---

## 🧩 Estrutura do Container

O `Dockerfile` faz tudo automaticamente:
- Compila o **frontend (Vite)**.
- Compila o **backend (TypeScript)**.
- Roda o **Express + servidor estático** juntos na **porta 3000**.

---

## ⚙️ Passo a passo do Deploy

### 1️⃣ Suba seu código no GitHub

Certifique-se de que o repositório contém:
- `Dockerfile`
- `.dockerignore`
- `server/`
- `front/`

---

### 2️⃣ Crie um novo serviço no Render

1. Acesse [https://render.com](https://render.com)  
2. Clique em **New → Web Service**  
3. Conecte seu repositório `abp-2025-2`  
4. Configure:

| Campo | Valor |
|-------|-------|
| **Environment** | Docker |
| **Region** | (sua preferência) |
| **Branch** | `main` |
| **Port** | `3000` |
| **Auto-Deploy** | Yes |

---

### 3️⃣ Configure as variáveis de ambiente

No Render, vá em **Settings → Environment → Add Environment Variable**  
e adicione todas as que estão no seu `.env` local:

| Nome | Valor (exemplo) |
|------|------------------|
| `PORT` | 3000 |
| `DB_FURNAS_HOST` | (host do seu banco) |
| `DB_FURNAS_PORT` | 5432 |
| `DB_FURNAS_USER` | postgres |
| `DB_FURNAS_PASSWORD` | (senha) |
| `DB_FURNAS_NAME` | bdfurnas-campanha |
| `DB_SIMA_HOST` | (host do banco sima) |
| `DB_SIMA_PORT` | 5432 |
| `DB_SIMA_USER` | postgres |
| `DB_SIMA_PASSWORD` | (senha) |
| `DB_SIMA_NAME` | bdsima |
| `DB_BALCAR_HOST` | (host do banco balcar) |
| `DB_BALCAR_PORT` | 5432 |
| `DB_BALCAR_USER` | postgres |
| `DB_BALCAR_PASSWORD` | (senha) |
| `DB_BALCAR_NAME` | bdbalcar-campanha |
| `PAGE_SIZE` | 20 |
| `LOG_LEVEL` | debug |

---

### 4️⃣ Deploy

O Render vai:
- Fazer build do container (frontend + backend);
- Expor o app na URL pública (`https://seu-app.onrender.com`).

Tudo estará acessível em uma única URL!

---

### 5️⃣ Teste

- Acesse `https://seu-app.onrender.com`
- O React deve carregar normalmente
- O backend (Express) responderá nas rotas `https://seu-app.onrender.com/api/...`

---

## ✅ Dica

Se quiser testar localmente:
```bash
docker build -t abp2025 .
docker run -p 3000:3000 abp2025
