# Mini Game Server

This is a sample solution for the Mini Game Server DevOps test. It consists of a Python script that represents a fake game server, a Dockerfile that containerizes the game server, and a Terraform script that deploys the game server to a local Minikube cluster.

## Requirements
To use this solution, you will need the following:

- Python 3.9 or later
- Docker 20.10 or later
- Minikube 1.23 or later
- Terraform 1.0 or later

## Installation
To install the solution, follow these steps:

1. Clone the repository:
```bash
git clone https://github.com/ArmanFeyzi/udp-game-server.git
cd udp-game-server
```

2. Build the Docker image:
```bash
docker build -t game-server .
```

## Usage
To use the solution, follow these steps:

1. Run the game server container:
```bash
docker run -p 7778:7778/udp game-server
```

2. Send UDP packets to the game server:
```bash
nc -u localhost 7778
```
You should see the packet printed to the standard output of the container.

3. Deploy the game server to Minikube:
```bash
cd terraform
terraform init
terraform apply
```

4. Get the game server service URL:
```css
minikube service game-server --url
```
You should see a URL like http://192.168.49.2:30840.

5. Send UDP packets to the game server service:
```bash
nc -u 192.168.49.2 30840
```

## Design and Implementation
The solution consists of three main components:

1. The game server script (`game_server.py`) is a Python script that listens on UDP port 7778, prints everything it receives to standard output, and runs for exactly 10 minutes.

2. The Dockerfile (`Dockerfile`) creates a Docker image based on the `python` base image, installs the required libraries (`socket` and `time`), and copies the game server script to the image. And also set the default command to run the game server script.

3. The Terraform script (`terraform/main.tf`) uses the Kubernetes provider to create a deployment and a service for the game server. Also specified that the game server deployment should have a replica count of 1 and expose the UDP port 7778. Finally, we created a NodePort service to expose the game server outside the Minikube cluster.