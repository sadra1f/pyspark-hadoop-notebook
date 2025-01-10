# PySpark Hadoop Notebook

[![Ubuntu Version](https://img.shields.io/badge/ubuntu-jammy-efefef)](#)
[![Hadoop Version](https://img.shields.io/badge/hadoop-3.3.6-efefef)](#)
[![PySpark Notebook Version](https://img.shields.io/badge/pyspark--notebook-python--3.11-efefef)](#)

> [!WARNING]  
> This project is not yet considered stable for production use. While it may be suitable for experimentation and development purposes, it is not recommended for production environments. Expect potential breaking changes, bugs, and incomplete features.

This project helps you set up a local development environment with Apache Hadoop running on an Ubuntu Jammy image integrated with Jupyter Notebook using Docker. The Dockerfile and Hadoop configurations are based on [bigdatafoundation/docker-hadoop](https://github.com/bigdatafoundation/docker-hadoop) project.

## Prerequisites

- Docker
- Docker Compose

Installation instructions can be found at https://docs.docker.com/get-started/

## Getting Started

1. Clone the Repository:

   ```sh
   git clone https://github.com/sadra1f/pyspark-hadoop-notebook.git
   ```

2. Pull and Build the Images:

   ```sh
   docker compose pull
   docker compose build
   ```

3. Run the Services:

   ```sh
   docker compose up -d
   ```

## Using Jupyter Notebook

> [!WARNING]  
> This setup disables Jupyter's default token-based authentication for easier local development. This means the notebook server is accessible to anyone who can reach it. For production or shared environments, it is strongly recommended to re-enable token authentication by commenting out (or deleting) the `command` section in the `jupyter` service definition within `docker-compose.yml` file.

Once the containers are running, Jupyter Notebook will be available in your web browser at http://localhost:8888. You can customize the port by changing the port mapping in the `docker-compose.yml` file under the `ports` section of the `jupyter` service.

To easily manage your notebooks and project files, use the `work` directory. This directory is mounted as a volume, ensuring that any changes you make within the Jupyter container are also reflected on your host machine, and vice-versa.

## Default Ports

The ports of each service can be changed in `docker-compose.yml` file.

| Service           | Description                  | Host   | Container |
| ----------------- | ---------------------------- | ------ | --------- |
| jupyter           | Jupyter (PySpark) Notebook   | 8888   | 8888      |
| namenode          | Yarn Resource Manager Web UI | 8088   | 8088      |
| namenode          | Namenode Web UI              | 9870   | 9870      |
| namenode          | Primary Namenode             | 9000   | 9000      |
| secondarynamenode | Secondary Namenode           | 9868   | 9868      |
| datanode-1        | First Datanode               | Random | 9864      |
| datanode-2        | Second Datanode              | Random | 9864      |

## Default Volumes

Volumes of each service can be changed in `docker-compose.yml` file.

| Service           | Description             | Host                                       | Container         |
| ----------------- | ----------------------- | ------------------------------------------ | ----------------- |
| jupyter           | Work Directory          | ./work                                     | /home/jovyan/work |
| namenode          | Primary Namenode Data   | namenode_data (Managed by Docker)          | /data             |
| secondarynamenode | Secondary Namenode Data | secondarynamenode_data (Managed by Docker) | /data             |
| datanode-1        | First Datanode Data     | datanode_1_data (Managed by Docker)        | /data             |
| datanode-2        | Second Datanode Data    | datanode_2_data (Managed by Docker)        | /data             |
