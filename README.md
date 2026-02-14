Welcome to my Personal Project 

Everything that is done in this project is explained so enjoy

AWS 3-Tier Highly Available Web App Architecture 

This project demonstrates a classic 3-tier architecture on AWS designed for high availability, security, and scalability across two Availability Zones (AZ1 & AZ2).

High-level goal

Serve internet traffic through a resilient web layer, route requests to a private application layer, and persist data in a highly available managed database—while keeping sensitive resources off the public internet.

Architecture Overview

One VPC + Multi-AZ foundation

Everything runs inside a dedicated Amazon VPC, split across two Availability Zones to improve fault tolerance. Each tier is placed in the appropriate subnet type:

Public subnets (Web Tier): internet-facing resources

Private subnets (App + Database Tiers): no direct internet exposure

Tier-by-Tier Breakdown

✅ Web Tier (Public Subnets)

Purpose: Handle incoming internet traffic and serve as the entry point to the system.

Internet Gateway provides internet access to the VPC.

Elastic Load Balancer (ELB) receives inbound traffic and distributes it across:

EC2 instances in public subnets, deployed in AZ1 and AZ2 for availability.

Why this matters ?.

Load balancing + Multi-AZ instances → high availability

Horizontal scaling potential → better performance under load

✅ App Tier (Private Subnets)

Purpose: Run core business logic without exposing application servers publicly.

Application EC2 instances live in private subnets (AZ1 & AZ2).

Traffic from the Web Tier is routed into the App Tier through an internal load balancer (private-facing).

App servers can communicate outbound only as needed (e.g., to the database), but are not reachable directly from the internet.

Why this matters ?

Private subnets reduce attack surface → stronger security posture

Separate tier improves maintainability → clean separation of concerns

✅ Database Tier (Private Subnets)

Purpose: Provide durable, managed relational storage with high availability and read scaling.

Uses Amazon Aurora in private subnets.

Primary DB handles writes.

Read Replica in the second AZ supports read-heavy workloads and improves resiliency.

Why this matters ?

Managed HA database setup → reliability

Read replica → better read scalability and improved performance

Request Flow (End-to-End)

User hits the application via the internet.

Traffic enters the VPC through the Internet Gateway.

Public ELB distributes requests to Web Tier EC2 instances across both AZs.

Web Tier forwards internal requests via the internal load balancer to App Tier EC2 instances in private subnets.

App Tier reads/writes data to Aurora Primary, and can route read-heavy queries to the Aurora Read Replica.

Key Design Highlights 

Multi-AZ deployment for resilience and uptime

Layered security using public/private subnet isolation

Load balancing at multiple layers (internet-facing + internal)

Scalable compute with EC2 in separate tiers

Managed database reliability with Aurora + read replica

Clean separation of concerns (web/app/db) for maintainability

<p align="center">
  <img src="docs/images/architecture.png" alt="AWS 3-Tier Architecture" width="900">
</p>

