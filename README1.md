# Attendance API - Proof of Concept (POC)

---

## Author Information

| Author      | Created on | Version | Last updated by | Last edited on | L0 Reviewer | L1 Reviewer     | L2 Reviewer     |
| ----------- | ---------- | ------- | --------------- | -------------- | ----------- | --------------- | --------------- |
| Saransh Rai | 25-04-2026 | v1.0    | Saransh Rai     | 25-04-2026     | Anuj Jain   | Prashant Sharma | Piyush Upadhyay |

---

## Table of Contents

1. [Introduction](#1-introduction)  
2. [POC Objective](#2-poc-objective)  
3. [Pre-requisites](#3-pre-requisites)  
4. [Architecture](#4-architecture)  
5. [Dataflow Diagram](#5-dataflow-diagram)  
6. [Step-by-step POC](#6-step-by-step-poc)  

   6.1 [Step 1: Launch EC2 Instance](#61-step-1-launch-ec2-instance)  
   6.2 [Step 2: Connect to EC2 via SSH](#62-step-2-connect-to-ec2-via-ssh)  
   6.3 [Step 3: Installation of Software Dependencies](#63-step-3-installation-of-software-dependencies)  
   6.4 [Step 4: Other Dependencies](#64-step-4-other-dependencies)  
   6.5 [Step 5: Clone Repository](#65-step-5-clone-repository)  
   6.6 [Step 6: Configure Database Connections](#66-step-6-configure-database-connections)  
   6.7 [Step 7: Database Setup PostgreSQL Liquibase](#67-step-7-database-setup-postgresql--liquibase)  
   6.8 [Step 8: Build / Artifact Generation](#68-step-8-build--artifact-generation)  
   6.9 [Step 9: Start Attendance API](#69-step-9-start-attendance-api)  
   6.10 [Step 10: Verify Attendance API](#610-step-10-verify-attendance-api)  

7. [Validation](#7-validation)  
8. [Troubleshooting](#8-troubleshooting)  
9. [FAQs](#9-faqs)  
10. [Contact](#10-contact)  
11. [References](#11-references)  

---

# 1. Introduction

This document is a Proof of Concept (POC) for deploying the Attendance API on an AWS EC2 instance. The Attendance API is a Python Flask-based microservice used to manage employee attendance records such as Present/Absent status by date.

---

# 2. POC Objective

| Objective               | Description                       |
| ----------------------- | --------------------------------- |
| Application Setup       | Verify installation on Ubuntu     |
| Dependency Installation | Validate Python, Poetry, Gunicorn |
| Database Migration      | Verify Liquibase migrations       |
| Application Startup     | Confirm API runs on port 8081     |
| API Health Check        | Validate health endpoints         |
| External Access         | Verify access via browser         |

---

# 3. Pre-requisites

## Infrastructure

| Requirement | Details      |
| ----------- | ------------ |
| Cloud       | AWS EC2      |
| OS          | Ubuntu 22.04 |
| Instance    | t3.medium    |
| Ports       | 22, 8081     |

## Software

| Software    | Purpose               |
| ----------- | --------------------- |
| Python 3.11 | Runtime               |
| Poetry      | Dependency management |
| Gunicorn    | Server                |
| PostgreSQL  | Database              |
| Redis       | Cache                 |
| Liquibase   | DB migration          |

---

# 4. Architecture

<img width="557" height="391" alt="image" src="https://github.com/user-attachments/assets/95de59c4-0e5b-4a21-a849-83e0d08db4df" />


# 5. Dataflow Diagram

<img width="738" height="567" alt="image" src="https://github.com/user-attachments/assets/a40894d4-47c5-496e-a086-981e2e26d69d" />

---

# 6. Step-by-step POC

## 6.1 Step 1: Launch EC2 Instance

<img width="1917" height="953" alt="image" src="https://github.com/user-attachments/assets/1b5dcdcc-8672-4db2-8e7c-2265f67f3eb6" />


## 6.2 Step 2: Connect to EC2 via SSH

```
ssh -i "new_key.pem" ubuntu@ec2-65-0-105-103.ap-south-1.compute.amazonaws.com
```

<img width="1292" height="722" alt="image" src="https://github.com/user-attachments/assets/4e604dc8-e912-485e-9d96-4885e0d276aa" />


## 6.3 Step 3: Installation of software Dependencies

```bash
# Update system + basic tools
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git nano net-tools build-essential
sudo apt install openjdk-17-jdk -y

# Python (required for application)
sudo apt install -y python3.11 python3.11-venv python3.11-dev
python3.11 --version

# Required to build psycopg2 (PostgreSQL adapter)
sudo apt install -y gcc libpq-dev

# Install Poetry (dependency manager)
curl -sSL https://install.python-poetry.org | python3 -
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Verify installations
python3.11 --version
poetry --version
```

<img width="1337" height="692" alt="image" src="https://github.com/user-attachments/assets/65669e5c-9c11-4220-beff-486053c6f714" />

<img width="1852" height="458" alt="image" src="https://github.com/user-attachments/assets/1e8d8ca1-603a-4fcb-857a-c7e87a88098b" />

<img width="1560" height="482" alt="image" src="https://github.com/user-attachments/assets/4844fbb6-7623-4dfa-bb85-911345f66d9b" />

<img width="1131" height="873" alt="image" src="https://github.com/user-attachments/assets/7a484c31-1048-48ef-8841-1fa62f28f9f2" />



## 6.4 Step 4: Other Dependencies

```bash
# Install Liquibase (for DB migrations)
sudo rm -f /etc/apt/sources.list.d/liquibase.list

sudo mkdir -p /usr/share/keyrings

curl -fsSL https://repo.liquibase.com/liquibase.asc | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/liquibase-keyring.gpg > /dev/null

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/liquibase-keyring.gpg] https://repo.liquibase.com stable main" | \
sudo tee /etc/apt/sources.list.d/liquibase.list

sudo apt update
sudo apt install -y liquibase

# Verify Liquibase
liquibase --version

# Download PostgreSQL JDBC driver (required by Liquibase)
mkdir -p ~/attendance-api/lib
wget -P ~/attendance-api/lib/ \
https://jdbc.postgresql.org/download/postgresql-42.7.2.jar

# Install Redis server
sudo apt install -y redis-server
sudo systemctl enable --now redis-server

```

<img width="1052" height="891" alt="image" src="https://github.com/user-attachments/assets/7bab72c5-588c-4146-a739-7d572028599e" />

<img width="1867" height="241" alt="image" src="https://github.com/user-attachments/assets/308e4bba-d65e-4b03-9e12-ed4b67d61609" />

<img width="1881" height="335" alt="image" src="https://github.com/user-attachments/assets/31b057be-02b1-43ab-b62f-5dbb04825e8c" />

<img width="1120" height="890" alt="image" src="https://github.com/user-attachments/assets/f83c13ff-aeed-4282-8e7a-1c21ecea2caa" />



## 6.5 Step 5: Clone Repository

```bash
git clone https://github.com/OT-MICROSERVICES/attendance-api.git
cd ~/attendance-api
ls
```


<img width="1091" height="152" alt="image" src="https://github.com/user-attachments/assets/efde0873-6759-438a-84af-0c285ade0af2" />

<img width="1112" height="82" alt="image" src="https://github.com/user-attachments/assets/ce5fcde3-cda5-4bea-9e3b-dbfa5ee4e48a" />


## 6.6 Step 6: Configure Database Connections

Edit `config.yaml` in the attendance-api root:
 
```bash
nano ~/attendance-api/config.yaml
```
 
Ensure the file contains:
 
```yaml
postgres:
  database: attendance_db
  host: PostgresIP
  port: 5432
  user: postgres
  password: password
 
redis:
  host: RedisIP
  port: 6379
  password: ""
```
 
---

<img width="720" height="261" alt="image" src="https://github.com/user-attachments/assets/ca2cd1f7-8743-42ff-9dbf-1a81b959394e" />



## 6.7 Step 7: Database Setup (PostgreSQL + Liquibase)

```bash
cd ~/attendance-api
 
cat > liquibase.properties << 'EOF'
url=jdbc:postgresql://localhost:5432/attendance_db
username=postgres
password=password
classpath=lib/postgresql-42.7.2.jar
changeLogFile=migration/db.changelog-master.xml
EOF
 

make run-migrations
```
 
**Verify tables were created**
 
```bash
psql -h 127.0.0.1 -U postgres -d attendance_db -c "\dt"
```
 
Expected output:
 
```
              List of relations
 Schema |         Name          | Type  |  Owner
--------+-----------------------+-------+----------
 public | databasechangelog     | table | postgres
 public | databasechangeloglock | table | postgres
 public | records               | table | postgres
```
 
The `records` table has columns: `id`, `name`, `status`, `date`.


---


<img width="1143" height="917" alt="image" src="https://github.com/user-attachments/assets/13cdf820-2ef5-4abb-a245-55f66b9077a6" />


## 6.8 Step 8: Build / Artifact Generation

```
cd ~/attendance-api


poetry env use python3.11
poetry add gunicorn
poetry install
```

<img width="1016" height="347" alt="image" src="https://github.com/user-attachments/assets/9d323749-f3a3-4ced-a72a-8bdeec5bb521" />


## 6.9 Step 9: Start Attendance API

```
nohup poetry run gunicorn --bind 0.0.0.0:8081 app:app &
```

<img width="1341" height="182" alt="image" src="https://github.com/user-attachments/assets/7fef1266-97d3-46d6-a881-a29b8ee5b4bd" />


## 6.10 Step 10: Verify Attendance API

```
curl http://localhost:8081/api/v1/attendance/health
```

<img width="1341" height="182" alt="image" src="https://github.com/user-attachments/assets/7cd39f8a-6a8e-40e3-a4ac-b81679fce4bd" />


---

## 7. Validation

| Test Case                     | Command / Action                                                | Expected Result                |
|------------------------------|-----------------------------------------------------------------|-------------------------------|
| Verify Python installation   | `python3.11 --version`                                          | Python 3.11.x is displayed    |
| Verify Poetry                | `poetry --version`                                              | Poetry version is displayed   |
| Verify Redis connectivity    | `redis-cli -h <Redis-IP> ping`                                  | `PONG` returned               |
| Verify PostgreSQL connection | `psql -h <PostgreSQL-IP> -U postgres -d attendance_db -c "\dt"` | `records` table present       |
| Verify migrations            | `make run-migrations`                                           | No errors; tables created     |
| Verify API process           | `ps aux \| grep gunicorn`                                       | Gunicorn master + workers running |
| Basic health check           | `curl http://localhost:8081/api/v1/attendance/health`           | 200 OK with success message   |
| Detailed health check        | `curl http://localhost:8081/api/v1/attendance/health/detail`    | `postgresql: up`, `redis: up` |
| External access              | Open `http://<EC2-PUBLIC-IP>:8081/.../health`                   | Page loads successfully       |

---

# 8. Troubleshooting

| Issue                               | Possible Cause                 | Resolution                                                                  |
| ----------------------------------- | ------------------------------ | --------------------------------------------------------------------------- |
| API not running on 8081             | Gunicorn not started / crashed | Start or restart: `nohup poetry run gunicorn --bind 0.0.0.0:8081 app:app &` |
| Port already in use                 | Another process bound to 8081  | `sudo lsof -i :8081` → kill conflicting PID                                 |
| PostgreSQL connection error         | Wrong host/creds or DB down    | Check `config.yaml`; `systemctl status postgresql`; test with `psql`        |
| Redis not responding                | Redis down / wrong host        | `redis-cli -h <Redis-IP> ping` (expect PONG); `systemctl status redis`      |
| Migration failures                  | Liquibase/JDBC misconfig       | Verify `liquibase.properties` and JDBC jar path                             |
| Dependency install error (psycopg2) | Missing build deps             | `sudo apt install -y gcc libpq-dev` then reinstall                          |
| Slow responses                      | Redis not used / DB load       | Ensure Redis is up; check logs; consider enabling caching                   |

---

# 9. FAQs

**Q: Which port does the Attendance API run on?**
A: `8081`

**Q: Which database is used?**
A: `PostgreSQL`

**Q: Is Redis mandatory?**
A: No, but recommended for caching and performance.

**Q: How do I check if the API is healthy?**
A: `curl http://localhost:8081/api/v1/attendance/health`

**Q: How do I restart the service?**
A: `pkill -f gunicorn && nohup poetry run gunicorn --bind 0.0.0.0:8081 app:app &`

---

# 10. Contact

| Name        | Email                                                                           |
| ----------- | ------------------------------------------------------------------------------- |
| Saransh Rai | [saransh.rai.snaatak@mygurukulam.co](mailto:saransh.rai.snaatak@mygurukulam.co) |

---

# 11. References

| Name                                                                            | Description                                       |
| ------------------------------------------------------------------------------- | ------------------------------------------------- |
| [Attendance API Repository](https://github.com/OT-MICROSERVICES/attendance-api) | Official source code for Attendance microservice  |
| [Flask Documentation](https://flask.palletsprojects.com/)                       | Documentation for Flask web framework used in API |
| [PostgreSQL Documentation](https://www.postgresql.org/docs/)                    | Official PostgreSQL database documentation        |
| [Redis Documentation](https://redis.io/docs/)                                   | Documentation for Redis caching system            |
| [Poetry Documentation](https://python-poetry.org/docs/)                         | Python dependency management tool documentation   |
| [Liquibase Documentation](https://www.liquibase.org/documentation/)             | Database migration tool documentation             |
| [Gunicorn Documentation](https://docs.gunicorn.org/)                            | WSGI HTTP server used to run Flask app            |
