<p align="center">
  <img width="310" height="163" alt="image" src="https://github.com/user-attachments/assets/1a18a5b4-beb2-45b9-ab99-8b65fab67762" />

  <br/>
</p>

<h1 align="center">🌐 Domain/Security | DNS/SSL | SSL POC</h1>

---

## **Author Information**

| Author      | Created on | Version | Last updated by | Last edited on | L0 Reviewer | L1 Reviewer     | L2 Reviewer     |
| ----------- | ---------- | ------- | --------------- | -------------- | ----------- | --------------- | --------------- |
| Saransh Rai | 25-04-2026 | v1.0    | Saransh Rai     | 25-04-2026     | Anuj Jain   | Prashant Sharma | Piyush Upadhyay |


---

## **Table of Contents**

1. [Introduction](#1-introduction)
2. [Objective](#2-objective)
3. [Prerequisites](#3-prerequisites)
4. [Architecture / Flow](#4-architecture--flow)
5. [Scope](#5-scope)
6. [Implementation Steps](#6-implementation-steps)

   * [6.1 - Step 1: Verify DNS](#61-step-1---verify-dns)
   * [6.2 - Step 2: Verify Website Access](#62-step-2---verify-website-access)
   * [6.3 - Step 3: Install Certbot](#63-step-3---install-certbot)
   * [6.4 - Step 4: Generate SSL Certificate](#64-step-4---generate-ssl-certificate)
   * [6.5 - Step 5: Verify HTTPS](#65-step-5---verify-https)
   * [6.6 - Step 6: Auto Renewal](#66-step-6---auto-renewal)
7. [Test Cases / Validation](#7-test-cases--validation)
8. [SSL Verification](#8-ssl-verification)
9. [Benefits](#9-benefits)
10. [Limitations](#10-limitations)
11. [Rollback Plan](#11-rollback-plan)
12. [FAQs](#12-faqs)
13. [Future Enhancements](#13-future-enhancements)
14. [Conclusion](#14-conclusion)
15. [Contact Information](#15-contact-information)
16. [References](#16-references)

---

## **1. Introduction**

SSL (Secure Sockets Layer) enables **encrypted communication** between users and the web server. It converts HTTP traffic into HTTPS and improves security, trust, and SEO ranking.

This document is a **Proof of Concept (POC)** for SSL implementation using:

* NGINX
* Certbot
* Let’s Encrypt

---

## **2. Objective**

| Objective           | Description                         |
| ------------------- | ----------------------------------- |
| SSL Setup           | Configure HTTPS for a domain        |
| Security Validation | Ensure encrypted communication      |
| Evidence            | Validate using commands/screenshots |
| Outcome             | Secure website with HTTPS           |

---

## **3. Prerequisites**

| Requirement       | Status / Description |
| ----------------- | -------------------- |
| Domain Name       | minvya.com           |
| DNS Configuration | Pointed to EC2       |
| Web Server        | NGINX Installed      |
| Port 80           | Open (HTTP)          |
| Port 443          | Open (HTTPS)         |


<img width="976" height="447" alt="image" src="https://github.com/user-attachments/assets/cde943b2-1f61-48dc-b675-2a1790feb908" />

---

## **4. Architecture / Flow**

<img width="1774" height="887" alt="image" src="https://github.com/user-attachments/assets/99cfe57b-ca83-4a7d-9ed0-8586b011d660" />


User Request → DNS Resolution → EC2 Server (NGINX) → Certbot Validation (Let’s Encrypt) → SSL Certificate Issued → HTTPS Enabled

---

## **5. Scope**

**In Scope:**

* SSL setup using Let’s Encrypt
* HTTPS validation using NGINX

**Out of Scope:**

* Load balancing
* Advanced security (WAF, DDoS protection)
* Paid SSL providers

---

## **6. Implementation Steps**

### **6.1 Step 1 - Verify DNS**

📸 *Screenshot: Ping/NSLookup Output Showing Domain Resolution*

```bash
ping minvya.com
```

<img width="968" height="290" alt="image" src="https://github.com/user-attachments/assets/482a8b34-0bad-434b-8b41-69eaebb4d707" />


---

### **6.2 Step 2 - Verify Website Access**

```bash
curl -I http://minvya.com
```
<img width="977" height="372" alt="image" src="https://github.com/user-attachments/assets/add61785-fd75-4812-b218-1f8aee846a3b" />

Expected:

```
HTTP/1.1 200 OK
```

---

### **6.3 Step 3 - Install Certbot**

```bash
sudo apt update
sudo apt install certbot python3-certbot-nginx -y
```

<img width="962" height="562" alt="image" src="https://github.com/user-attachments/assets/1d120551-5b6e-4bad-b5e2-ba8d295d1103" />


---

### **6.4 Step 4 - Generate SSL Certificate**

📸 *Screenshot: Certbot Successful SSL Generation*

```bash
sudo certbot --nginx -d minvya.com -d www.minvya.com
```

Choose:

```
2: Redirect HTTP to HTTPS
```

<img width="962" height="508" alt="image" src="https://github.com/user-attachments/assets/8f741a6e-b9f7-4e03-8c4c-f5805c87b0ee" />


---

### **6.5 Step 5 - Verify HTTPS**

Browser:

```
https://minvya.com
```

<img width="947" height="517" alt="image" src="https://github.com/user-attachments/assets/f9a66b1a-2aa5-4c7b-96cf-2636d10fafde" />


CLI:

```bash
curl -I https://minvya.com
```

Expected:

```
HTTP/2 200
```

<img width="786" height="333" alt="image" src="https://github.com/user-attachments/assets/30083119-0969-4363-9980-7a0b3a7e574e" />


---

### **6.6 Step 6 - Auto Renewal**

```bash
sudo systemctl status certbot.timer
```
<img width="968" height="283" alt="image" src="https://github.com/user-attachments/assets/3beee1c9-a3a0-41b1-94d7-e69fb65271ee" />


Optional:

```bash
sudo certbot renew --dry-run
```

---

## **7. Test Cases / Validation**

| Test Case    | Command / Action                              | Expected Result   | Status |
| ------------ | --------------------------------------------- | ----------------- | ------ |
| HTTP access  | curl [http://minvya.com](http://minvya.com)   | 301 Redirect      | ✅      |
| HTTPS access | curl [https://minvya.com](https://minvya.com) | 200 OK            | ✅      |
| SSL check    | openssl s_client -connect minvya.com:443      | Valid certificate | ✅      |

---
## **8. SSL Verification**

```bash
openssl s_client -connect minvya.com:443
```

You can also verify using SSL Labs test.

---

## **9. Benefits**

| Benefit    | Description              |
| ---------- | ------------------------ |
| Security   | Encrypts traffic         |
| Trust      | Browser lock icon        |
| SEO        | Better search ranking    |
| Compliance | Meets security standards |
| Automation | Auto renewal supported   |

---

## **10. Limitations**

* Requires domain to be publicly accessible
* DNS propagation delays may affect setup
* Ports 80 and 443 must be open
* Certbot auto-renewal depends on system service

---

## **11. Rollback Plan**

If SSL configuration fails:

```bash
sudo nginx -t
sudo systemctl restart nginx
```

Revert NGINX configuration if required.

---

## **12. FAQs**

**1. Is SSL free using Let’s Encrypt?**
Yes, completely free.

**2. How long is certificate valid?**
90 days with auto renewal.

**3. Will HTTP still work?**
Yes, it redirects to HTTPS.

**4. Does SSL affect performance?**
Minimal overhead.

**5. Is domain ownership required?**
Yes.

---

## **13. Future Enhancements**

* Implement wildcard SSL certificates
* Automate SSL setup using Terraform/Ansible
* Support multiple domains
* Integrate with CI/CD pipelines

---

## **14. Conclusion**

This POC successfully demonstrates SSL/TLS configuration using NGINX and Let’s Encrypt. HTTPS is enabled, traffic is encrypted, and the solution is ready for production with minor enhancements.

---
## **15. Contact Information**

| Name         | Email                                                                             |
| ------------ | --------------------------------------------------------------------------------- |
| Saransh Rai  | [saransh.rai.snaatak@mygurukulam.co](mailto:saransh.rai.snaatak@mygurukulam.co)   |

---

## **16. References**

| Resource      | Link                                                                 |
| ------------- | -------------------------------------------------------------------- |
| Certbot       | [https://certbot.eff.org/](https://certbot.eff.org/)                 |
| Let’s Encrypt | [https://letsencrypt.org/](https://letsencrypt.org/)                 |
| NGINX         | [https://nginx.org/](https://nginx.org/)                             |
| SSL Test      | [https://www.ssllabs.com/ssltest/](https://www.ssllabs.com/ssltest/) |


