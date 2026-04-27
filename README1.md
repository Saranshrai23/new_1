# Tools Evaluation – GitLab (Documentation)

| Author        | Created on | Version | Last updated by | Last edited on | L0 Reviewer   | L1 Reviewer  | L2 Reviewer  |
| ------------- | ---------- | ------- | --------------- | -------------- | ------------- | ------------ | ------------ |
| Saransh Rai   | 27-04-2026 | v1.1    | Saransh Rai     | 27-04-2026     | Komal Jaiswal | Akshit Kapil | Mahesh Kumar |

---

## Table of Contents

## Table of Contents

* [1. Purpose](#1-purpose)
* [2. Scope](#2-scope)
* [3. Evaluation Criteria](#3-evaluation-criteria)
* [4. Pre-requisites](#4-pre-requisites)
* [5. GitLab Overview](#5-gitlab-overview)
* [6. Key Features](#6-key-features)
* [7. Architecture Overview](#7-architecture-overview)
  * [7.1 High-Level GitLab Request Flow](#71-high-level-gitlab-request-flow)
  * [7.2 Core Components of GitLab Architecture](#72-core-components-of-gitlab-architecture)
  * [7.3 Git Operation Flow](#73-git-operation-flow)
  * [7.4 CI/CD Architecture Flow](#74-cicd-architecture-flow)
  * [7.5 Storage and Data Persistence](#75-storage-and-data-persistence)
  * [7.6 Scalability and High Availability](#76-scalability-and-high-availability)
* [8. Integration and Ecosystem](#8-integration-and-ecosystem)
* [9. Installation and Setup](#9-installation-and-setup)
* [10. Operational Considerations](#10-operational-considerations)
* [11. Security Considerations](#11-security-considerations)
* [12. Tool Comparison](#12-tool-comparison)
* [13. Advantages](#13-advantages)
* [14. Disadvantages](#14-disadvantages)
* [15. Recommendation](#15-recommendation)
* [16. Post-Setup Validation](#16-post-setup-validation)
* [17. Conclusion](#17-conclusion)
* [18. Contact Information](#18-contact-information)
* [19. References](#19-references)

---

# 1. Purpose

This document evaluates GitLab as a unified DevOps platform. It highlights its features, architecture, CI/CD capabilities, and security aspects to understand how it supports modern software development workflows.

---

# 2. Scope

This evaluation includes:

* Source Code Management (SCM)
* CI/CD pipeline automation
* Security and DevSecOps capabilities
* Integration ecosystem
* Installation and operational aspects

Applicable for:

* Development Teams  
* QA Teams  
* DevOps Teams  
* Platform Engineering Teams  

Supported environments:

* Development  
* QA  
* Staging  
* Production  

---

# 3. Evaluation Criteria

| Criteria         | Description                             |
| ---------------- | --------------------------------------- |
| SCM Capabilities | Code version control and collaboration  |
| CI/CD            | Pipeline automation and deployment      |
| Security         | Built-in DevSecOps features             |
| Integration      | Support for external tools and services |
| Scalability      | Ability to support enterprise workloads |
| Ease of Use      | Learning curve and usability            |
| Maintenance      | Operational effort required             |
| Cost             | Licensing and infrastructure cost       |

---

# 4. Pre-requisites

### System Requirements (Self-Hosted GitLab)

| Requirement | Minimum Recommendation             |
| ----------- | ---------------------------------- |
| Processor   | Dual-Core                          |
| RAM         | 4–8 GB                             |
| Disk        | 20–50 GB                           |
| OS          | Linux (Ubuntu 22.04 or compatible) |

---

# 5. GitLab Overview

GitLab is a unified platform that supports the entire DevOps lifecycle.

<img width="1902" height="958" alt="image" src="https://github.com/user-attachments/assets/19d782aa-ff11-40d9-8221-85ca08774082" />


Key capabilities include:

* Source Code Management (Git repositories)
* Built-in CI/CD pipelines
* Integrated DevSecOps tools
* Project management and issue tracking
* Container and package registries

---

# 6. Key Features

| Feature                | Description                           |
| ---------------------- | ------------------------------------- |
| Source Code Management | Git-based repository management       |
| Merge Requests         | Code review and collaboration         |
| CI/CD Pipelines        | Automated build, test, and deployment |
| GitLab Runners         | Execute pipeline jobs                 |
| Issue Tracking         | Project management capabilities       |
| Container Registry     | Store Docker images                   |
| Package Registry       | Store dependencies and artifacts      |
| Wiki                   | Documentation support                 |

---

# 7. Architecture Overview

GitLab follows a modular architecture where different components handle web requests, Git operations, background jobs, database storage, caching, and repository storage.

GitLab is not only a Git repository hosting tool. It is a complete DevOps platform that includes source code management, CI/CD, issue tracking, merge requests, container registry, package registry, security scanning, and project management in one platform. :contentReference[oaicite:1]{index=1}

## 7.1 High-Level GitLab Request Flow

When a user accesses GitLab from a browser or Git client, the request flows through multiple backend components:

1. User sends an HTTP/HTTPS request to GitLab.
2. Nginx receives the request and works as a reverse proxy.
3. GitLab Workhorse handles large or slow requests and forwards application requests to Puma.
4. Puma runs the GitLab Rails application and processes web/API requests.
5. Rails uses PostgreSQL for permanent metadata and Redis for cache/session/job queue data.
6. Sidekiq processes background jobs such as notifications, pipeline updates, and asynchronous tasks.
7. Gitaly handles Git repository storage and Git operations.
8. GitLab Shell handles Git SSH operations such as clone, push, and pull.

## 7.2 Core Components of GitLab Architecture

| Component | Purpose |
| --------- | ------- |
| Nginx | Acts as a reverse proxy and handles incoming HTTP/HTTPS traffic |
| GitLab Workhorse | Handles large HTTP requests such as uploads/downloads and forwards normal requests to Puma |
| Puma | Web server that runs GitLab Rails application requests |
| GitLab Rails | Main application layer that handles users, projects, merge requests, issues, permissions, and CI/CD metadata |
| Sidekiq | Background job processor for long-running tasks |
| Redis | Used for caching, sessions, temporary data, and Sidekiq job queues |
| PostgreSQL | Stores long-lived metadata like users, projects, permissions, issues, merge requests, and pipeline information |
| Gitaly | Handles Git repository storage and Git operations through gRPC |
| GitLab Shell | Handles Git operations over SSH |
| Object Storage | Stores artifacts, uploads, packages, container registry data, and large binary objects |

## 7.3 Git Operation Flow

When a developer performs Git operations such as clone, push, or pull:

1. The developer connects to GitLab using SSH or HTTPS.
2. For SSH-based Git operations, GitLab Shell authenticates the user.
3. GitLab Shell communicates with Gitaly.
4. Gitaly reads or writes repository data from the Git bare repository.
5. GitLab Rails updates metadata in PostgreSQL when required.

In GitLab, every project is stored as a bare repository on the server side. A bare repository stores Git data such as commits, branches, tags, and history, but it does not contain a normal working directory. :contentReference[oaicite:2]{index=2}

## 7.4 CI/CD Architecture Flow

GitLab CI/CD works with GitLab Runner.

1. Developer pushes code to GitLab.
2. GitLab checks the `.gitlab-ci.yml` file.
3. A pipeline is created.
4. GitLab Runner picks the job.
5. Runner executes build, test, scan, or deployment jobs.
6. Job logs and status are sent back to GitLab.
7. Artifacts can be stored in GitLab storage or external object storage.

GitLab Runner is not the main GitLab server. It is a separate agent that executes CI/CD jobs.

## 7.5 Storage and Data Persistence

| Data Type | Stored In |
| --------- | --------- |
| Repository data | Gitaly / Git bare repositories |
| Users, groups, projects, issues, merge requests | PostgreSQL |
| Cache, sessions, Sidekiq queues | Redis |
| CI/CD artifacts, uploads, packages, registry data | Object Storage such as AWS S3, Azure Blob, MinIO, or local storage |

## 7.6 Scalability and High Availability

For small teams, GitLab can run on a single server using the Omnibus package.

For enterprise-level usage, GitLab components can be separated and scaled independently:

| Component | Scaling Approach |
| --------- | ---------------- |
| PostgreSQL | Use external PostgreSQL cluster or HA setup |
| Redis | Use Redis cluster or HA Redis |
| Gitaly | Use multiple Gitaly nodes |
| Sidekiq | Add more Sidekiq workers |
| Puma | Scale web application nodes |
| Object Storage | Use external storage like S3 |
| Load Balancer | Distribute traffic across GitLab nodes |

For high availability, stateful components such as PostgreSQL, Redis, and Gitaly should be backed up and deployed carefully because they store critical GitLab data. :contentReference[oaicite:3]{index=3}

## 7.7 Architecture Diagram Placeholder

<img width="1000" height="554" alt="image" src="https://github.com/user-attachments/assets/dc6e7339-d11d-4673-98ca-f0577769dfd4" />

<img width="1531" height="719" alt="image" src="https://github.com/user-attachments/assets/99e15f01-26e0-4f42-819a-15d5f01dc42d" />


---

# 8. Integration and Ecosystem

GitLab integrates with:

* Kubernetes  
* AWS, GCP, Azure  
* Monitoring tools  
* Security tools  
* Identity providers  

---

# 9. Installation and Setup

High-level setup steps:

1. Install GitLab  
2. Create repositories  
3. Configure runners  
4. Define CI/CD pipeline  
5. Set permissions  

📌 *[Optional Screenshot: GitLab Project Setup / Runner Configuration]*

---

# 10. Operational Considerations

| Area        | Description                                        |
| ----------- | -------------------------------------------------- |
| Maintenance | Requires updates and backups                       |
| Scaling     | Supports horizontal scaling                        |
| Monitoring  | Integrates with monitoring tools                   |
| Upgrades    | Regular updates recommended                        |

---

# 11. Security Considerations

Includes:

* RBAC  
* SAST  
* DAST  
* Dependency scanning  
* Audit logs  

---

# 12. Tool Comparison
| Feature        | GitLab              | GitHub             | Jenkins        |
|----------------|--------------------|--------------------|----------------|
| SCM            | Yes                | Yes                | No             |
| CI/CD          | Built-in           | GitHub Actions     | Plugin-based   |
| DevSecOps      | Integrated         | Partial            | External tools |
| Hosting        | SaaS & Self-hosted | SaaS & Enterprise  | Self-hosted    |
| Ease of Setup  | Medium             | Easy               | Complex        |
| Scalability    | High               | High               | Medium         |

---

# 13. Advantages

| Advantage | Description |
|----------|-------------|
| Unified Platform | Covers entire DevOps lifecycle in one tool |
| Built-in CI/CD | No need for external pipeline tools |
| Integrated DevSecOps | Security scanning embedded in pipelines |
| Reduced Toolchain | Eliminates need for multiple tools |
| Scalability | Supports both small teams and enterprise workloads |
| Cloud-Native Support | Works well with Kubernetes and modern infra |

---

# 14. Disadvantages

| Limitation | Description |
|-----------|-------------|
| Paid Features | Advanced capabilities require Ultimate/Premium plans |
| Learning Curve | Complex for beginners compared to simpler tools |
| Resource Intensive | Requires strong infrastructure for self-hosting |
| Scaling Complexity | Enterprise scaling requires careful architecture planning |
| Maintenance Overhead | Needs regular updates, backups, and monitoring | 

---

# 15. Recommendation

GitLab is recommended due to its integrated DevOps capabilities, reducing tool fragmentation and improving efficiency across development workflows.

---

# 16. Post-Setup Validation

| Validation Check  | Expected Outcome               |
| ----------------- | ------------------------------ |
| Repository Access | Verified                       |
| CI/CD Pipeline    | Running successfully           |
| Merge Requests    | Working                        |
| Security Scans    | Triggered                      |
| Audit Logs        | Available                      |

📌 *[Optional Screenshot: Successful Pipeline Execution]*  
📌 *[Optional Screenshot: Merge Request Workflow]*  

---

# 17. Conclusion

GitLab provides a complete DevOps solution by integrating development, CI/CD, and security into one platform, improving collaboration and workflow efficiency.

---

# 18. Contact Information

| Name        | Email Address            |
| ----------- | ------------------------ |
| Saransh Rai | your-email@example.com   |

---

# 19. References

| Reference Source           | Link |
| -------------------------- | ---- |
| GitLab Documentation       | https://docs.gitlab.com |
| GitLab CI/CD Documentation | https://docs.gitlab.com/ee/ci |
| GitLab Architecture Docs   | https://docs.gitlab.com/ee/development/architecture |

---
