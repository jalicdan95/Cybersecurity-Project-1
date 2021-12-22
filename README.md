# Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

Diagrams/ELK Stack Topology.png

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook yaml file may be used to install only certain pieces of it, such as Filebeat.

Ansible/install-elk.yml

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly efficient, in addition to restricting access to the network.
Load balancers provide efficiency to users by distributing networks across servers. They provide security for networks by balancing incoming traffic that could prevent possible DDos attacks from the open web.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the log files and system performance.
Filebeat watches for changes in any files and logs.
Metricbeat monitors and records the statistics from the system and services running on the servers.

The configuration details of each machine may be found below.

| Name     | Function  | IP Address               | Operating System |
|----------|---------- |--------------------------|------------------|
| Jump Box | Gateway   | 20.106.254.41, 10.0.0.4  | Linux Ubuntu     |
| Web-1    | Web App   | 10.0.0.5                 | Linux Ubuntu     |
| Web-2    | Web App   | 10.0.0.6                 | Linux Ubuntu     |      
| ELK      | ELK Server| 20.114.220.166, 10.1.0.4 | Linux Ubuntu     |    

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
JumpBox Public IP - 20.106.254.41

Machines within the network can only be accessed by Jump Box.
Both Web-1 and Web-2 virtual machines are allowed access to the ELK server. Both contain private IP addresses.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses                   |
|----------|---------------------|----------------------------------------|
| Jump Box |  Yes                | Personal Public IP, 10.0.0.5, 10.0.0.6 |
| Web-1    |  No                 |  10.0.0.5                              |
| Web-2    |  No                 |  10.0.0.6                              |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it saves time and creates efficiency when needing to set up, complete and overall run the machine.

The playbook implements the following tasks:
- Install docker
- Instal python3-pip
- Increase virtual memory
- Download and launch docker elk container

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

Diagrams/ELK docker ps success.png

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1: 10.0.0.5
- Web-2: 10.0.0.6

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat collects log data and can detect changes to any file.
- Metricbeat monitors and collects the metrics and statistics coming from both machines. This information can be monitored from our ELK GUI.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the filebeat and metricbeat playbooks and configuration yaml files to /etc/ansible.
- Update the filebeat and metricbeat configuration yaml files to include the ELK server private IP address.
- Run the playbook, and navigate to the Kibana webserver [ELK Server Public IP:5601/app/kibana] to check that the installation worked as expected. The Kibana logo should appear and run successfully.

- Filebeat and Metricbeat playbooks: filebeat-playbook.yml and metricbeat-playbook.yml. You will copy these playbooks to the /etc/ansible directory.
- Out of the three hosts and configuration files for Ansible, Filebeat and Metricbeat - you will update the host config file and include the private IP addresses of Web-1 and Web-2 under the "webservers" group, and include the private ELK IP address under the "elk" group. Updating this host config file allows Ansible to run playbooks on specific machines per the specified asigned group. When updating specific configuration files such as Filebeat and Metricbeat it's important to update which specified group and users are allowed access when it comes to specific installations.
- In order to see if the ELK server is running you navigate to - http://[your.VM.IP]:5601/app/kibana. If successful, the Kibana logo/website should appear like the following image - Diagrams/Kibana Success.png

### Downloading Playbooks and Updating Files

In your terminal, SSH into the Jump Box Provisioner machine:
- ssh sysadmin@[JumpBox Public IP Address]

View lists of docker containers:
- sudo docker container list -a

Start the (example) docker:
- sudo docker start (happy_fermi)

Attach docker:
- sudo docker attach happy_fermi

Update hosts file to include Web VMs:
- cd /etc/ansible
- vim hosts
- Include private IPs of Web 1 ad Web-2 under "webservers group". Repeat this step for the elk server, below "webservers" include "elk" and add the private IP address of the elk server.

Run elk playbook:
- ansible-playbook install-elk.yml

Download copy on filebeat configuration file
- curl https://gist.githubusercontent.com/slape/5cc350109583af6cbe577bbcc0710c93/raw/eca603b72586fbe148c11f9c87bf96a63cb25760/Filebeat >> /etc/ansible/filebeat-config.yml

Update filebeat configuration file:
- vim filebeat-config.yml 
- update this file with the elk server private address

Create filebeat playbook:
- vim filebeat-playbook.yml
- include all tasks needed to run filebeat, per the filebeat installation steps on Kibana website.

Run playbook:
- ansible-playbook filebeat-config.yml
- successful results will specify "ping-pong"
