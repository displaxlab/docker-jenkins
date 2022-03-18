# docker-jenkins
Dockerfile for Continuos Integration build qt projects

# Howto

Build images if they don't exist, or download from Displax registry.

## Windows

Run:
-  docker run -d --dns 192.168.1.1 --cpus 2 --memory 2GB --restart unless-stopped registry.base.displax.com/windows-x86-qt-jenkins-slave:5.14.2 -jnlpUrl http://jenkins.dev.displax.com/computer/windows-x86-container-agent-1/jenkins-agent.jnlp -secret f38d13d98d983985fc20400678f6a27b9a356b3fd54620efc99ff866a200e896 -workDir "c:\\Users\\jenkins"
-  docker run -d --dns 192.168.1.1 --cpus 7 --memory 4GB --restart unless-stopped registry.base.displax.com/windows-x64-qt-jenkins-slave:5.14.2 -jnlpUrl http://jenkins.dev.displax.com/computer/windows-x64-container-agent-1/jenkins-agent.jnlp -secret f38d13d98d983985fc20400678f6a27b9a356b3fd54620efc99ff866a200e896 -workDir "c:\\Users\\jenkins"

Don't forget to check if jnlpUrl and secret are updated.

## Linux

Run:
- docker run -d --cpus 3 --memory 3.5g --restart unless-stopped registry.base.displax.com/ubuntu-x64-toolchaingcc:gcc5.2.1 
- docker run -d --cpus 3 --memory 3.5g --restart unless-stopped registry.base.displax.com/ubuntu-x64-toolchaingcc:gcc9.2.1 
- docker run -d --cpus 4 --memory 3.5g --restart unless-stopped registry.base.displax.com/ubuntu-x64-qt:5.14.2-updated 
- docker run -d --cpus 4 --memory 3.5g --restart unless-stopped registry.base.displax.com/ubuntu-x86-qt:5.14.2-updated

Then, for each container, enter through ssh, and follow respective instructions of Jenkins agent (ex: http://jenkins.dev.displax.com/computer/Ubuntu-x64-QT/).
