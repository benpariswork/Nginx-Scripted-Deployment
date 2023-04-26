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

* Run the command: ```curl -o install_nginx.sh https://raw.githubusercontent.com/benpariswork/Nginx-Scripted-Deployment/main/install_nginx.sh```
    * This command downloads the install script to ```./install_nginx.sh```.

* Run the command: ```chmod +x install_nginx.sh```
    * This command will make the script we just installed executable.

* Run the command: ```sudo ./install_nginx.sh```
    * This command will run the install script with superuser privelages.
    * Some of the commands in this script require superuser privelages, the script should return an error if sudo is not used.
    * Please read this script before running, this is a best practice to avoid running malicous code.

* While the script is running, you will be presented with two 'keys' (see example below).
    * This step is in place to avoid downloading corrupt files.
    * Evaluate the two keys, if they are different enter ```n```, if they are the same enter ```y```.
    * If ```n``` is entered the file just downloaded will be considered corrupt and be deleted.
    * If ```y``` is entered then the script will continue with the installation process.

![Fingerprints Screenshot](/img/fingerprints.png) 

* Once the script has finished running, you should see "NGINX is now RUNNING" like below.

![Nginx Running Screenshot](/img/nginx-running.png)


### Check to make sure HTTP endpoint is running

* Navigate to your AWS Lightsail console and locate your instance running <a href="https://nginx.org/en/docs/">Nginx</a>. 
    * This command will delete the default Nginx HTML landing page file.

* Copy the instance IP address and paste it into your browser (seen below), press the enter button.

![copy Screenshot](/img/copy.png)

![paste Running Screenshot](/img/paste.png)

* You should see the default nginx index.html file (see below).

![Nginx Screenshot](/img/nginx.png)

### Notes

###### This project is very basic but I plan to reference it in more complex projects.

