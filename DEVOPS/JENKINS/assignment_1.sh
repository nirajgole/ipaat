docker pull jenkins/jenkins:lts
docker run --name my_jenkins -p 8080:8080 -p 50000:50000 -v /var/jenkins_home jenkins/jenkins:lts
switch to browser on port 8080 -> get admin password -> installed suggested plugins
skip and continue as admin
# 9ee5822915d140f68035ee5650b63ea2