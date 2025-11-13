# ============================================
# Etapa 1: Build do frontend (React + Vite)
# ============================================
FROM node:22-alpine AS build-frontend
WORKDIR /app/front
COPY front/package*.json ./
RUN npm install
COPY front ./
RUN npm run build

# ============================================
# Etapa 2: Build do backend (Express + TypeScript)
# ============================================
FROM node:22-alpine AS build-backend
WORKDIR /app/server
COPY server/package*.json ./
RUN npm install
COPY server ./
RUN npm run build

# ============================================
# Etapa 3: Container final (Frontend + Backend)
# ============================================
FROM node:22-alpine

WORKDIR /app

# Copia o backend compilado
COPY --from=build-backend /app/server/dist ./server/dist
COPY server/package*.json ./server/
RUN cd server && npm install --omit=dev

# Copia o frontend buildado para servir arquivos estáticos
COPY --from=build-frontend /app/front/dist ./front/dist

# Instala o 'serve' para entregar os arquivos estáticos
RUN npm install -g serve

# Variáveis de ambiente padrão
ENV PORT=3000
EXPOSE 3000

# Inicia o backend e o servidor estático juntos
CMD node ./server/dist/server.js & serve -s ./front/dist -l 3000
