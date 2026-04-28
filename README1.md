<p align="center">
  <img width="310" height="163" alt="image" src="https://github.com/user-attachments/assets/1a18a5b4-beb2-45b9-ab99-8b65fab67762" />

  <br/>
</p>

<h1 align="center">Domain/Security | DNS/SSL | SSL POC</h1>

---

## Author Information

| Author      | Created on | Version | Last updated by | Last edited on | L0 Reviewer | L1 Reviewer     | L2 Reviewer     |
| ----------- | ---------- | ------- | --------------- | -------------- | ----------- | --------------- | --------------- |
| Saransh Rai | 25-04-2026 | v1.0    | Saransh Rai     | 25-04-2026     | Anuj Jain   | Prashant Sharma | Piyush Upadhyay |

---

## Table of Contents

1. [Introduction](#introduction)
2. [POC Objective](#poc-objective)
3. [Prerequisites](#prerequisites)
4. [SSL Setup Details](#ssl-setup-details)
5. SSL Setup Steps

   * 5.1 [Step 1: Verify DNS Resolution](#step-1-verify-dns-resolution)
   * 5.2 [Step 2: Install Web Server (Nginx)](#step-2-install-web-server-nginx)
   * 5.3 [Step 3: Verify Web Server](#step-3-verify-web-server)
   * 5.4 [Step 4: Install Certbot](#step-4-install-certbot)
   * 5.5 [Step 5: Generate SSL Certificate](#step-5-generate-ssl-certificate)
   * 5.6 [Step 6: Verify HTTPS Access](#step-6-verify-https-access)
   * 5.7 [Step 7: Verify SSL Certificate Details](#step-7-verify-ssl-certificate-details)
6. [Conclusion](#conclusion)
7. [Contact Information](#contact-information)
8. [Reference Table](#reference-table)

---

## Introduction

This document provides a **Proof of Concept (POC)** for configuring **SSL/TLS** on a domain. The objective is to validate secure HTTPS communication using a trusted SSL certificate and capture execution proof through screenshots.

---

## POC Objective

| Objective               | Description                          |
| ----------------------- | ------------------------------------ |
| **SSL Setup**           | Configure SSL for a domain           |
| **Security Validation** | Ensure HTTPS is enabled              |
| **Evidence**            | Capture screenshots for verification |
| **Outcome**             | Secure encrypted communication       |

---

## Prerequisites

| Requirement     | Description                   |
| --------------- | ----------------------------- |
| **Domain Name** | Registered domain             |
| **DNS Access**  | Ability to update DNS records |
| **Server**      | Linux VM / Cloud instance     |
| **Web Server**  | Nginx or Apache               |
| **Open Ports**  | 80 and 443                    |

---

## SSL Setup Details

| Item                | Value         |
| ------------------- | ------------- |
| **SSL Provider**    | Let’s Encrypt |
| **SSL Tool**        | Certbot       |
| **Validation Type** | HTTP-01       |
| **Web Server**      | Nginx         |

---

## Step 1: Verify DNS Resolution

Check whether the domain resolves to the server IP.

```bash
nslookup innovitisolutions.in
```

---

## Step 2: Install Web Server (Nginx)

Update the package repository and install the Nginx web server.

```bash
sudo apt update
sudo apt install nginx -y
```

---

## Step 3: Verify Web Server

Verify that the Nginx web server is running successfully.

```bash
systemctl status nginx
```

---

## Step 4: Install Certbot

Install Certbot and the Nginx plugin to enable SSL certificate generation.

```bash
sudo apt install certbot python3-certbot-nginx -y
```

---

## Step 5: Generate SSL Certificate

Generate an SSL/TLS certificate for the domain using Certbot with the Nginx plugin.

```bash
sudo certbot --nginx -d innovitisolutions.in -d www.innovitisolutions.in
```

---

## Step 6: Verify HTTPS Access

Verify that HTTPS is enabled and the SSL certificate is working correctly.

Open the domain in a web browser:

```
https://innovitisolutions.in
```

---

## Step 7: Verify SSL Certificate Details

Verify the SSL/TLS certificate details and secure connection using OpenSSL.

```bash
openssl s_client -connect innovitisolutions.in:443
```

---

## Conclusion

This Proof of Concept (POC) confirms that SSL/TLS has been successfully configured for the domain. Secure HTTPS communication is enabled, the SSL certificate has been issued and validated, and encrypted traffic is verified using both browser-based and command-line checks.

---

## Contact Information

| Name        | Email                                                                           |
| ----------- | ------------------------------------------------------------------------------- |
| Saransh Rai | [saransh.rai.snaatak@mygurukulam.co](mailto:saransh.rai.snaatak@mygurukulam.co) |

---

## Reference Table

| Reference Type    | Description                                                       | Link                                                                                                                                                                                                                                       |
| ----------------- | ----------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| SSL Documentation | Conceptual DNS & SSL documentation used as reference for this POC | [https://github.com/Snaatak-Error-404/Sprint-1/blob/SCRUM-120-neha/Domain_Security%20/SSL/Documentation%20/README.md](https://github.com/Snaatak-Error-404/Sprint-1/blob/SCRUM-120-neha/Domain_Security%20/SSL/Documentation%20/README.md) |
