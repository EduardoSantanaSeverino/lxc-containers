echo "Install the LXC on ubunt"
sudo apt install lxc
sudo apt install lxd
sudo lxd init
sudo lxc profile create k8s
cat ks8.profile.text | sudo lxc profile edit k8s

echo "Create LXC containers"
sudo lxc launch images:centos/7 kmaster --profile k8s
sudo lxc launch images:centos/7 kworker1 --profile k8s
sudo lxc launch images:centos/7 kworker2 --profile k8s

echo "Run the scripts on containers"
cat bootstrap-kube.sh  | sudo lxc exec kmaster bash
cat bootstrap-kube.sh  | sudo lxc exec kworker1 bash
cat bootstrap-kube.sh  | sudo lxc exec kworker2 bash

