Azure Functions App
------------------

Azure Functions is a serverless solution that allows you to write less code, maintain less infrastructure, and save on costs. Instead of worrying about deploying and maintaining servers, the cloud infrastructure provides all the up-to-date resources needed to keep your applications running.

You focus on the code that matters most to you, in the most productive language for you, and Azure Functions handles the rest.


Pre-requisite for this :-

* You need to create the Zip file of your Java based Functions App
* Paste that Zip file in the Directory
* Update the name of the zip file in Blob Storage under "Source Section"

This repository will create the following resources in Azure:-

- Resource Group
- Storage Account
- Storage Container
- Blob Storage
- Storage Sas Account
- Function App Plan
- Application Insights
- Function App

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