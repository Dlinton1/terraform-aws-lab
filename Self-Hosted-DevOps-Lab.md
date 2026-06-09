# Self-Hosted DevOps Lab

## Project Goal

Build and manage self-hosted services on AWS using Docker.

---

## Infrastructure

### Cloud Platform
- AWS EC2
- Ubuntu 22.04

### Container Platform
- Docker

### Services
- Portainer
- Uptime Kuma

---

## Ports Used

| Port | Purpose |
|--------|--------|
| 22 | SSH |
| 80 | Web Traffic |
| 9000 | Portainer |
| 3001 | Uptime Kuma |

---

## What I Learned

### EC2
- Created Linux server in AWS
- Connected using SSH

### Docker
- Installed Docker Engine
- Pulled images from Docker Hub
- Created and managed containers

### Portainer
- Managed containers through web UI
- Viewed container status

### Uptime Kuma
- Created uptime monitors
- Monitored service health
- Simulated service failures

---

## Troubleshooting

### Docker Commands

View containers:

```bash
docker ps