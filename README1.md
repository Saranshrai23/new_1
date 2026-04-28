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

1. [Introduction](#introduction)
2. [Objective](#objective)
3. [Prerequisites](#prerequisites)
4. [Implementation Steps](#implementation-steps)

   * [Step 1: Verify DNS](#step-1---verify-dns)
   * [Step 2: Verify Website Access](#step-2---verify-website-access)
   * [Step 3: Install Certbot](#step-3---install-certbot)
   * [Step 4: Generate SSL Certificate](#step-4---generate-ssl-certificate)
   * [Step 5: Verify HTTPS](#step-5---verify-https)
   * [Step 6: Auto Renewal](#step-6---auto-renewal)
5. [Benefits](#benefits)
6. [FAQs](#faqs)
7. [Contact Information](#contact-information)
8. [References](#references)

---

## **Introduction**

SSL (Secure Sockets Layer) enables **encrypted communication** between users and the web server. It converts HTTP traffic into HTTPS and improves security, trust, and SEO ranking.

This document is a **Proof of Concept (POC)** for SSL implementation using:

* NGINX
* Certbot
* Let’s Encrypt

---

## **Objective**

| Objective           | Description                         |
| ------------------- | ----------------------------------- |
| SSL Setup           | Configure HTTPS for a domain        |
| Security Validation | Ensure encrypted communication      |
| Evidence            | Validate using commands/screenshots |
| Outcome             | Secure website with HTTPS           |

---

## **Prerequisites**

| Requirement       | Status / Description |
| ----------------- | -------------------- |
| Domain Name       | minvya.com           |
| DNS Configuration | Pointed to EC2       |
| Web Server        | NGINX Installed      |
| Port 80           | Open (HTTP)          |
| Port 443          | Open (HTTPS)         |


<img width="976" height="447" alt="image" src="https://github.com/user-attachments/assets/cde943b2-1f61-48dc-b675-2a1790feb908" />

---

## **Architecture / Flow**

<img width="1774" height="887" alt="image" src="https://github.com/user-attachments/assets/99cfe57b-ca83-4a7d-9ed0-8586b011d660" />


User Request → DNS Resolution → EC2 Server (NGINX) → Certbot Validation (Let’s Encrypt) → SSL Certificate Issued → HTTPS Enabled

---

## **Scope**

**In Scope:**

* SSL setup using Let’s Encrypt
* HTTPS validation using NGINX

**Out of Scope:**

* Load balancing
* Advanced security (WAF, DDoS protection)
* Paid SSL providers

---

## **Implementation Steps**

### **Step 1 - Verify DNS**

📸 *Screenshot: Ping/NSLookup Output Showing Domain Resolution*

```bash
ping minvya.com
```

<img width="968" height="290" alt="image" src="https://github.com/user-attachments/assets/482a8b34-0bad-434b-8b41-69eaebb4d707" />


---

### **Step 2 - Verify Website Access**

```bash
curl -I http://minvya.com
```
<img width="977" height="372" alt="image" src="https://github.com/user-attachments/assets/add61785-fd75-4812-b218-1f8aee846a3b" />

Expected:

```
HTTP/1.1 200 OK
```

---

### **Step 3 - Install Certbot**

```bash
sudo apt update
sudo apt install certbot python3-certbot-nginx -y
```

<img width="962" height="562" alt="image" src="https://github.com/user-attachments/assets/1d120551-5b6e-4bad-b5e2-ba8d295d1103" />


---

### **Step 4 - Generate SSL Certificate**

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

### **Step 5 - Verify HTTPS**

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

### **Step 6 - Auto Renewal**

```bash
sudo systemctl status certbot.timer
```
<img width="968" height="283" alt="image" src="https://github.com/user-attachments/assets/3beee1c9-a3a0-41b1-94d7-e69fb65271ee" />


Optional:

```bash
sudo certbot renew --dry-run
```

---

## **Test Cases / Validation**

| Test Case    | Command / Action                              | Expected Result   | Status |
| ------------ | --------------------------------------------- | ----------------- | ------ |
| HTTP access  | curl [http://minvya.com](http://minvya.com)   | 301 Redirect      | ✅      |
| HTTPS access | curl [https://minvya.com](https://minvya.com) | 200 OK            | ✅      |
| SSL check    | openssl s_client -connect minvya.com:443      | Valid certificate | ✅      |

---

## **SSL Verification**

```bash
openssl s_client -connect minvya.com:443
```

You can also verify using SSL Labs test.

---

## **Benefits**

| Benefit    | Description              |
| ---------- | ------------------------ |
| Security   | Encrypts traffic         |
| Trust      | Browser lock icon        |
| SEO        | Better search ranking    |
| Compliance | Meets security standards |
| Automation | Auto renewal supported   |

---

## **Limitations**

* Requires domain to be publicly accessible
* DNS propagation delays may affect setup
* Ports 80 and 443 must be open
* Certbot auto-renewal depends on system service

---

## **Rollback Plan**

If SSL configuration fails:

```bash
sudo nginx -t
sudo systemctl restart nginx
```

Revert NGINX configuration if required.

---

## **FAQs**

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

## **Future Enhancements**

* Implement wildcard SSL certificates
* Automate SSL setup using Terraform/Ansible
* Support multiple domains
* Integrate with CI/CD pipelines

---

## **Conclusion**

This POC successfully demonstrates SSL/TLS configuration using NGINX and Let’s Encrypt. HTTPS is enabled, traffic is encrypted, and the solution is ready for production with minor enhancements.

---

## **Contact Information**

| Name         | Email                                                                             |
| ------------ | --------------------------------------------------------------------------------- |
| Saransh Rai  | [saransh.rai.snaatak@mygurukulam.co](mailto:saransh.rai.snaatak@mygurukulam.co)   |

---

## **References**

| Resource      | Link                                                                 |
| ------------- | -------------------------------------------------------------------- |
| Certbot       | [https://certbot.eff.org/](https://certbot.eff.org/)                 |
| Let’s Encrypt | [https://letsencrypt.org/](https://letsencrypt.org/)                 |
| NGINX         | [https://nginx.org/](https://nginx.org/)                             |
| SSL Test      | [https://www.ssllabs.com/ssltest/](https://www.ssllabs.com/ssltest/) |

