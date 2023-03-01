# Docker Jupyter Container

## Proxy Container
```yml
  proxy:
    image: registry.gitlab.com/mireu-lab/docker-jupyter-container:containernetwork
    restart: always
    container_name: Proxy-Container
    environment:
      - VIRTUAL_HOST=test2.container.mireu.xyz
      - ProxyURL=0.0.0.0
      - WebProxyPort=8080
    depends_on:
      - ubuntu_jupyter
      - fedora_jupyter
```

## Ubuntu Container
```yml
  ubuntu_jupyter:
    image: registry.gitlab.com/mireu-lab/docker-jupyter-container:containerjupyterubuntu
    restart: always
    container_name: Jupyter-Ubuntu-Container
    volumes:
      - Container_Jupyter_Ubuntu:workspace:ro
    ports:
      - "8081:8888"
    depends_on:
      - datebase_mongo
      - datebase_mariadb
      - datebase_mysql
      - schema_redis
```

## Fedora Container
```yml
  fedora_jupyter:
    image: registry.gitlab.com/mireu-lab/docker-jupyter-container:containerjupyterfedora
    restart: always
    container_name: Jupyter-Fedora-Container
    volumes:
      - Container_Jupyter_Fedora:workspace:ro
    ports:
      - "8082:8888"
    depends_on:
      - datebase_mongo
      - datebase_mariadb
      - datebase_mysql
      - schema_redis
```

## MongoDB Container
```yml
  datebase_mongo:
    image: mongo
    restart: always
    container_name: Jupyter-MongoDB
    volumes:
      - Container_Datebase_MongoDB:/data/db:ro
    environment:
      MONGO_INITDB_ROOT_USERNAME: root
      MONGO_INITDB_ROOT_PASSWORD: Jupyter
```

## MariaDB Container
```yml
  datebase_mariadb:
    image: mariadb
    restart: always
    container_name: Jupyter-MariaDB
    volumes:
      - Container_Datebase_MariaDB:/var/lib/maria:ro
    environment:
      MARIADB_ROOT_PASSWORD: Jupyter
```

## MySQL Container
```yml

  datebase_mysql:
    image: mysql
    restart: always
    container_name: Jupyter-MySQL
    command: --default-authentication-plugin=mysql_native_password
    volumes:
      - Container_Datebase_MySQL:/var/lib/mysql:ro
    environment:
      MYSQL_ROOT_PASSWORD: Jupyter
```

## Redis Container
```yml

  schema_redis:
    image: redis:alpine
    restart: always
    container_name: Jupyter-Redis
    command: redis-server --port 6379
    volumes:
      - Container_Schema_Redis:/data:ro
    labels:
      - "name=redis"
      - "mode=standalone"
```

## Container Volume
```yml
volumes:
  Container_Jupyter_Ubuntu:
  Container_Jupyter_Fedora:
  Container_Datebase_MySQL:
  Container_Datebase_MariaDB:
  Container_Datebase_MongoDB:
  Container_Schema_Redis:
```