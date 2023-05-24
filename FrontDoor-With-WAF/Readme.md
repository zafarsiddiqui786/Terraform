Azure FrontDoor with WAF 
---------------------------

Azure Front Door is Microsoft’s modern cloud Content Delivery Network (CDN) that provides fast, reliable, and secure access between your users and your applications’ static and dynamic web content across the globe. Azure Front Door delivers your content using Microsoft’s global edge network with hundreds of global and local points of presence (PoPs) distributed around the world close to both your enterprise and consumer end users.

Why use Azure Front Door?
----------------------------

Azure Front Door enables internet-facing application to:

* Build and operate modern internet-first architectures that have dynamic, high-quality digital experiences with highly automated, secure, and reliable platforms.

* Accelerate and deliver your app and content globally at scale to your users wherever they're creating opportunities for you to compete, weather change, and quickly adapt to new demand and markets.

* Intelligently secure your digital estate against known and new threats with intelligent security that embrace a Zero Trust framework.

Azure Web Application Firewall (WAF)
---------------------------------------

Azure Web Application Firewall is a cloud-native service that protects web apps from common web-hacking techniques such as SQL injection and security vulnerabilities such as cross-site scripting. Deploy the service in minutes to get complete visibility into your environment and block malicious attacks.

Azure App Service 
------------------
Azure App Service is a fully managed platform as a service (PaaS) that enables developers to quickly build, deploy, and scale apps. It's a fully managed platform for hosting web apps, mobile backends, and APIs

This repository will create the following resources in Azure:-

- Resource Group
- CDN Front Door (with Premium Tier )
- CDN Front Door Profile
- CDN Front Door Endpoint
- CDN Front Door origin Group
- CDN Front Door Origin
- CDN Front Door Route
- Web Application Firewall (Premium Tier)
- CDN FrontDoor Secuirty Policy
- App Service Plan
- Windows Web App

Infratructure Overview
----------------------------
- We are creating CDN Front Door with Premium Tier & associating it WAF & secuirty policy. 
- We are hosting a Azure Web App & deploying it on Front Door.
- We are whitelisting some demo IP Address to check the functionality of WAF.
- WAF will make sure that no other IP address can be reachable to the web app.

Steps  you need to follow :-

- az login (if doing locally)

- terraform init

- terraform plan

- terraform apply

Installation Step
------------------

* Azure Cli
* Terraform Cli
* Any Code Editor (like VS Code or Intellij)

