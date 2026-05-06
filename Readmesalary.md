# Salary API

---

## Author Information

| Author      | Created on | Version | Last updated by | Last edited on | L0 Reviewer | L1 Reviewer     | L2 Reviewer     |
| ----------- | ---------- | ------- | --------------- | -------------- | ----------- | --------------- | --------------- |
| Saransh Rai | 01-05-2026 |  1.0    | Saransh Rai     | 01-05-2026     | Anuj Jain   | Prashant Sharma | Piyush Upadhyay |

---

# Table of Contents

1. [Introduction](#1-introduction)
2. [Purpose](#2-purpose)
3. [Pre-Requisites](#3-pre-requisites)

   * 3.1 [System Requirements](#31-system-requirements)
   * 3.2 [Dependencies](#32-dependencies)

     * 3.2.1 [Build Time Dependencies](#321-build-time-dependencies)
     * 3.2.2 [Run Time Dependencies](#322-run-time-dependencies)
     * 3.2.3 [Other Dependencies](#323-other-dependencies)
   * 3.3 [Important Ports](#33-important-ports)

     * 3.3.1 [Inbound Traffic](#331-inbound-traffic)
     * 3.3.2 [Outbound Traffic](#332-outbound-traffic)
4. [Architecture](#4-architecture)
5. [Dataflow Diagram](#5-dataflow-diagram)
6. [Health Check](#6-health-check)
7. [Troubleshooting](#7-troubleshooting)
8. [FAQs](#8-faqs)
9. [How to Bring Up the Salary API](#9-how-to-bring-up-the-salary-api)
10. [Contact Information](#10-contact-information)
11. [References](#11-references)

---

# 1. Introduction

The Salary API is a Java-based microservice developed for managing salary-related operations independently within the OT-Microservices architecture. It uses Spring Boot, ScyllaDB, and Redis to provide scalable and efficient salary management services.

---

# 2. Purpose

The purpose of the Salary API is to manage employee salary records in a scalable, secure, and maintainable way. It enables independent deployment, faster data access using caching, and reliable distributed data storage.

### Key Objectives

* Independent salary service deployment
* Better scalability and maintainability
* Faster salary data retrieval using Redis caching
* Reliable distributed data storage using ScyllaDB
* Improved monitoring and operational visibility

---

# 3. Pre-Requisites

Before deploying the Salary API, ensure that the following hardware, software, and security requirements are met.

---

## 3.1 System Requirements

## Hardware Specifications

| Hardware  | Minimum Recommendation |
| --------- | ---------------------- |
| Processor | Dual-core              |
| RAM       | 4 GB                   |
| Disk      | 20 GB                  |
| OS        | Ubuntu 22.04           |

---

## 3.2 Dependencies

### 3.2.1 Build Time Dependencies

| Name       | Version     | Description                         |
| ---------- | ----------- | ----------------------------------- |
| Java (JDK) | 11 or above | Required to compile the application |
| Maven      | 3.x         | Build and dependency management     |

---

### 3.2.2 Run Time Dependencies

| Name               | Version              | Description                      |
| ------------------ | -------------------- | -------------------------------- |
| Java Runtime (JRE) | 11 or above          | Required to run the application  |
| ScyllaDB           | Cassandra compatible | Primary database for salary data |
| Redis              | Latest stable        | Cache management                 |
| Migrate            | Latest               | Database schema migration        |

---

### 3.2.3 Other Dependencies

| Name       | Version  | Description                   |
| ---------- | -------- | ----------------------------- |
| Prometheus | Optional | Metrics scraping              |
| Swagger UI | Bundled  | API documentation and testing |

---

## 3.3 Important Ports

### 3.3.1 Inbound Traffic

| Port | Description      |
| ---- | ---------------- |
| 9042 | Used by ScyllaDB |

### 3.3.2 Outbound Traffic

| Port | Description                    |
| ---- | ------------------------------ |
| 8080 | Used by embedded Tomcat server |

---

# 4. Architecture

The Salary API follows a microservices-based architecture where the service runs independently and communicates using HTTP protocols.

### Core Components

* Client Application / Frontend
* Salary API (Spring Boot Application)
* Redis Cache Layer
* ScyllaDB Database
* Monitoring & Metrics Systems

This architecture improves scalability, fault isolation, deployment flexibility, and maintainability.

---

# 5. Dataflow Diagram

<img width="868" height="378" alt="image" src="https://github.com/user-attachments/assets/bf046fb4-d9be-4f69-9e8b-0bf6980c47c5" />

## Data Flow Explanation

1. Client sends an HTTP request to the Salary API
2. Salary API checks Redis cache for existing data
3. If cache hit occurs, response is returned immediately
4. If cache miss occurs, data is fetched from ScyllaDB
5. Retrieved data is stored in Redis cache
6. API returns the response to the client
7. Metrics are exposed for monitoring and observability

---

# 6. Health Check

Run the following command to verify whether the Salary API application is running properly:

```bash
curl http://localhost:8082/actuator/health
```

## Expected Output

```json
{"status":"UP","components":{"cassandra":{"status":"UP"}}}
```

This confirms that:

* Salary API is running successfully
* Spring Boot application is healthy
* ScyllaDB connectivity is working properly

---

# 7. Troubleshooting

| Issue                        | Resolution                                        | Command                                                    |            |
| ---------------------------- | ------------------------------------------------- | ---------------------------------------------------------- | ---------- |
| Application not starting     | Verify Java version and application configuration | `java -version` , `cat src/main/resources/application.yml` |            |
| Migration failure            | Validate credentials and migration settings       | `cat migration.json`                                       |            |
| Redis connection error       | Ensure Redis service is running and reachable     | `sudo systemctl status redis`                              |            |
| Health endpoint DOWN         | Verify database connectivity and service status   | `curl http://localhost:8082/actuator/health`               |            |
| Port already in use          | Verify which process is using the port            | `sudo ss -ltnp                                             | grep 8082` |
| Application logs not visible | Verify application logs for runtime errors        | `tail -f ~/salary.log`                                     |            |

---

# 8. FAQs

### Is this application free?

Yes, this is an open-source application.

### Can it be deployed on all cloud platforms?

Yes, the application is cloud-agnostic and can be deployed on any cloud provider.

### Is an enterprise version available?

No, only the open-source version is available.

---

# 9. How to Bring Up the Salary API

To set up and run this application, refer to the official repository documentation:

👉 [Salary POC README Documentation](https://github.com/Snaatak-Error-404/Sprint-1/blob/SCRUM-76-ajitesh/OT_MS/Salary/POC/readme.md)

---

# 10. Contact Information

| Name        | Email                                                                           |
| ----------- | ------------------------------------------------------------------------------- |
| Saransh Rai | [saransh.rai.snaatak@mygurukulam.co](mailto:saransh.rai.snaatak@mygurukulam.co) |

---

# 11. References

| Topic                                                                                                                      | Description                                    |
| -------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
| [Jenkins Installation Documentation](https://www.jenkins.io/doc/book/installing/linux/#debianubuntu)                       | Jenkins installation and Linux setup reference |
| [FAQ Structure Reference](https://amplifi.com/user-guide/FAQs.html)                                                        | FAQ documentation structure reference          |
| [Introduction vs Overview Reference](https://thecontentauthority.com/blog/introduction-vs-overview)                        | Guidance for writing introduction sections     |
| [Salary POC GitHub README](https://github.com/Snaatak-Error-404/Sprint-1/blob/SCRUM-76-ajitesh/OT_MS/Salary/POC/readme.md) | Salary API implementation and setup reference  |
