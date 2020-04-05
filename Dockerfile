FROM nginx
WORKDIR /code
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./public /code
EXPOSE 8000
CMD ["nginx", "-g", "daemon off;"]
