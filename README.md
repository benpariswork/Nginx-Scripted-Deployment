# Deploy Nginx a Bash script

Follow along as I deploy <a href="https://nginx.org/en/docs/">Nginx</a> on an Ubuntu instance via AWS Lightsail and a bash script I wrote using <a href="https://openai.com/blog/chatgpt">ChatGPT</a>.

## Description

While the web has progressed a lot, sometimes all you need is a static HTTP server, <a href="https://nginx.org/en/docs/">Nginx</a> provides just that. In this project I create a web server that allows anyone to access an HTTP endpoint by entering the server's IP address into their browser. I begin this process by initializing an instance of Ubuntu 20.04 in <a href="https://aws.amazon.com/free/compute/lightsail/">AWS Lightsail</a>.(There is no reason I picked this release of Ubuntu, this process should be compatible with 22.04, 20.04, or 18.04) Once connected I install <a href="https://nginx.org/en/docs/">Nginx</a>, I start the service and check it is running by entering the server IP into my browser. 

## Getting Started

### Prerequisites

* Create an AWS Free-Tier account <a href="https://aws.amazon.com/free/">here</a>

### Dependencies

* Ubuntu 22.04 or 20.04 or 18.04
* Nginx 

### Creating Ubuntu Instance

* Log into the AWS management console and use the search bar to open Lightsail.

![Find Lightsail Screenshot](/img/find-lightsail.png)

* Click the orange button that says ```Create instance```.

![Create Instance Screenshot](/img/create-instance.png)

* Select the options ```Linux/Unix```, ```OS Only```, and ```Ubuntu 20.04 LTS```.

![Select Instance Image Screenshot](/img/instance-image.png)

* This project does not require very much computational power so select the cheapest price plan available.

![Select Instance Plan Screenshot](/img/plan.png)

* Give your instance a name, for this project I used ```Linux-HTTP-Server```.

![Select Instance Name Screenshot](/img/name.png)

* Click the ```Create instance``` button to finish initializing your instance.

![Create Screenshot](/img/create.png)

### Connect to Ubuntu Instance

* After creating your Ubuntu instance you will see a list of your instances, wait for your instance to say ```Running```.

![Pending Screenshot](/img/pending.png) 

* Click the three dots in the top right of this instance and select ```Manage```.

![Select Manage Screenshot](/img/select-manage.png) 

* Once on the instance management page select the button seen in the ```Connect``` tab, ```Connect using SSH```.

![Manage Screenshot](/img/manage.png) 

* A window should pop open with an interactive web shell that connects you to your server via SSH.

![SSH Screenshot](/img/ssh.png)

### Installing and Running Nginx

Now that you have a shell into your server, follow these steps to install and initialize <a href="https://nginx.org/en/docs/">Nginx</a>:

* ```nano``
    * This command updates the apt package manager.

* ```sudo apt install nginx```
    * This command enable the firewall to filter incoming traffic.
    * You will be given this promt ```After this operation, 7919 kB of additional disk space will be used.Do you want to continue? [Y/n] ?```
    * Enter ```y``` to install Nginx.

* ```sudo ufw allow 'Nginx HTTP'```
    * This command update the firewall to allow for Nginx HTTP traffic.
    * As this project is meant for simple implementations where security is not at risk, we will only use HTTP, not HTTPS.

* ```sudo ufw allow 'OpenSSH'```
    * This command update the firewall to allow for SSH traffic.
    * This is important in order to avoid terminating the current SSH connection.

* ```sudo ufw enable```
    * This command enables the firewall to filter incoming traffic.
    * You will be given this promt ```Command may disrupt existing ssh connections. Proceed with operation (y|n)?```
    * Enter ```y``` to enable firewall.

* ```sudo ufw status numbered```
    * This command will return a numbered list of the active firewall rules.
    * Use this information to check that your firewall is running properly, compare to below.
![Rules Screenshot](/img/rules.png)

* ```nginx status```
    * This command will return a report on the status of the Nginx service.
    * Use this information to check that your server is running properly, compare to below.
![Status Screenshot](/img/status.png)

* ```curl -4 https://icanhazip.com/```
    * This command will return our IPV4 address in order to test that our server is serving content.
    * If we have completed these steps correctly, entering the IPV4 address into our browser will return the landing page below.
![Landing Screenshot](/img/landing.png)

### Replace Nginx Default with custom content

* ```sudo rm /usr/share/nginx/html/index.html```
    * This command will delete the default Nginx HTML landing page file.

* ```git clone https://github.com/benpariswork/static_portfolio```
    * This command will download the content for my static website.

* ```sudo mv /home/ubuntu/static_portfolio/* /var/www/html/```
    * This command will move the content for my static website to the html directory configured in the Nginx configuration file.

* When we return to our browser pointed to the server IP address, reloading the page should reveal the portfolio.

### We have now succesfully set up a simple HTTP web server.



