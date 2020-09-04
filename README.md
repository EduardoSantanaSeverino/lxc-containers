# lxc-containers

lxc config set core.trust_password aXfxB6959DkXss4A

lxc exec lxdMosaic bash

lxc exec ubuntu-server-01 bash
lxc list

TO INSTALL THE CLUSTER ON CENTOS 7

0. create the virtual containers

lxc launch images:centos/7 kmaster --profile k8s
lxc launch images:centos/7 kworker1 --profile k8s
lxc launch images:centos/7 kworker2 --profile k8s

1. run pre-script.sh to install missing libs

cat pre-script.sh | lxc exec kmaster bash
cat pre-script.sh | lxc exec kworker1 bash
cat pre-script.sh | lxc exec kworker2 bash

2. run the boostrap scrip to install in each

cat bootstrap-kube.sh | lxc exec kmaster bash
cat bootstrap-kube.sh | lxc exec kworker1 bash
cat bootstrap-kube.sh | lxc exec kworker2 bash

should be installed

extras links: 
https://www.cyberciti.biz/faq/failed-to-set-locale-defaulting-to-c-warning-message-on-centoslinux/
https://www.cyberciti.biz/faq/delta-rpms-disabled-because-applydeltarpm-not-installed/

vi ~/.bashrc

## US English ##
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_COLLATE=C
export LC_CTYPE=en_US.UTF-8


echo -e "## US English ## \nexport LANG=en_US.UTF-8 \nexport LANGUAGE=en_US.UTF-8 \nexport LC_COLLATE=C \nexport LC_CTYPE=en_US.UTF-8" >> ~/.bashrc

yum update -y

yum install deltarpm -y


TO COPY THE KUBE CONFIG TO THE NODE:
1. create a directory: 
mkdir ~/.kube
2. copy the file from remote to local 
scp root@172.16.16.100:/etc/kubernetes/admin.conf ~/.kube/config
3. check the cluster
kubectl cluster-info
kubectl config get-contexts
kubectl vertion -o json
kubectl get nodes

TO CREATE A DEPLOYMENT FOR TESTING THE CLUSTER
1. create a simple nginx deployment
kubectl create deploy nginx --image nginx
2. check the resources
kubectl get all
3. expose the deployment
kubectl expose deploy nginx --port 80 --type NodePort
notes: now we should see the the welcome page on any of the nodes on the cluster and the port. 

TO INSTALL CLIENT
apt update && apt install -y kubectl=1.18.5-00


curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.17.1/bin/linux/amd64/kubectl"

curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.19.0/bin/linux/amd64/kubectl

Make the kubectl binary executable.

chmod +x ./kubectl
Move the binary in to your PATH.

sudo mv ./kubectl /usr/local/bin/kubectl
Test to ensure the version you installed is up-to-date:

kubectl version --client -o json
