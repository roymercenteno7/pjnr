# Usa la imagen base de Nginx
FROM nginx:stable-alpine

# Elimina la configuración por defecto de Nginx para evitar conflictos
# RUN rm /etc/nginx/conf.d/default.conf # Esta línea a veces es necesaria si la imagen base tiene un default.conf que queremos reemplazar completamente.
                                     # Si tu default.conf es suficiente, podrías saltarla.
                                     # Para este caso, como lo vamos a montar, no la necesitamos por ahora.

# Copia tu archivo de configuración de Nginx personalizado
# El primer path es relativo al contexto de construcción (donde está el Dockerfile)
# El segundo path es donde Nginx espera ver las configuraciones adicionales.
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

# Copia tus archivos HTML, CSS y assets al directorio de Nginx.
# Esto es crucial: los archivos se copian *dentro* de la imagen.
# El primer punto '.' significa la carpeta actual donde está el Dockerfile.
# El segundo path es el directorio raíz de Nginx dentro del contenedor.
COPY . /usr/share/nginx/html

# Expone el puerto 80 (Nginx escucha por defecto en este puerto)
EXPOSE 80

# Comando para iniciar Nginx (ya es el CMD predeterminado en la imagen Nginx)
CMD ["nginx", "-g", "daemon off;"]