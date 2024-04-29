# Etapa de compilación
FROM node:18.13.0-alpine as build-step

WORKDIR /app

# Copiar archivos de configuración de Node
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar el resto de los archivos de la aplicación Angular
COPY . ./

# Construir la aplicación Angular
RUN npm run build

# Etapa de ejecución
FROM nginx:1.23.1-alpine


# Copiar la aplicación Angular construida en la carpeta de distribución del servidor nginx
# Asegúrate de que la ruta refleje la estructura de directorio de tu construcción Angular
COPY --from=build-step /app/dist/client/browser /usr/share/nginx/html

# Exponer el puerto 80
EXPOSE 80

# Cuando el contenedor inicie, este comando correrá por defecto
CMD ["nginx", "-g", "daemon off;"]
