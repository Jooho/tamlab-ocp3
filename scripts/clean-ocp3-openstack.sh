#openstack 
# Usage
## View all objects that belongs to $USERNAME
### ./clean-ocp3-openstack.sh $USERNAME 
## Delete all objects that belongs to $USERNAME
### ./clean-ocp3-openstack.sh $USERNAME confirm
# Notice
## USERNAME is requried!

#openstack 
if [[ z$1 == 'z' ]]
then
   echo "USER NAME required"
   exit 1
fi
USERNAME=$1


if [[ z$2 == 'z' ]]
then
  echo "Server List"
  openstack server list --all-projects |grep "${USERNAME}-"
  echo ""

  echo "Volume List"
  openstack volume list --all-projects |grep "${USERNAME}-"
  echo ""

  echo "Floating IP"
  openstack floating ip list|grep $(openstack project list |grep ocp311_tamlab_${USERNAME}|awk '{print $2}')
  echo ""

  echo "Port List"
  openstack port list|grep $(openstack subnet list|grep "ocp_subnet_${USERNAME}"|awk '{print $2}')
  echo ""

  echo "Router List"
  openstack router list|grep "ocp3_router_${USERNAME}"
  echo ""

  echo "Subnet List"
  openstack subnet list|grep "ocp_subnet_${USERNAME}"
  echo ""

  echo "Network List"
  openstack network list|grep "ocp3_network_${USERNAME}"
  echo ""

  echo "Security Group"
  openstack security group list|grep "${USERNAME}_ocp3_security_grp"
  echo ""
 
  echo "Project List"
  openstack project list |grep ocp311_tamlab_${USERNAME}
  echo ""

  echo "User List"
  openstack user list|grep ${USERNAME}
  echo ""

  echo "DNS List"
  ssh root@10.37.192.157 -- egrep "${USERNAME}_ocp.conf$" /var/named/tamlab.brq.db
  echo ""
fi


if [[ $2 == 'confirm' ]]
then
  echo "Delete Server List"
  for server in $(openstack server list --all-projects |grep "${USERNAME}-"|awk '{print $2}'); do echo "Delete server(${server})";openstack server delete $server; done
  echo ""

  echo "Delete Volume List"
  for volume in $(openstack volume list --all-projects |grep "${USERNAME}-docker"|awk '{print $2}'); do echo "Delete volume(${volume})";openstack volume delete $volume; done
  echo ""

  echo "Delete Floating IP"
  for floatIp in $(openstack floating ip list|grep $(openstack project list |grep ocp311_tamlab_${USERNAME}|awk '{print $2}')|awk '{print $2}'); do echo "Delete floatIP(${floatIp})";openstack floating ip delete $floatIp; done 
  echo ""

  echo "Delete Port List"
  for port in $(openstack port list|grep $(openstack subnet list|grep "ocp_subnet_${USERNAME}" |awk '{print $2}')|awk '{print $2}'); do echo "Delete port(${port})"; openstack port set $port --device-owner none ;openstack port delete $port; done
  echo ""

  echo "Delete Router List"
  for router in $(openstack router list|grep "ocp3_router_${USERNAME}"|awk '{print $2}'); do echo "Delete router(${router})"; openstack router delete $router; done
  echo ""

  echo "Delete Subnet List"
  for subnet in $(openstack subnet list|grep "ocp_subnet_${USERNAME}"|awk '{print $2}'); do echo "Delete subnet(${subnet})"; openstack subnet delete $subnet; done
  echo ""

  echo "Delete Network List"
  for network in $(openstack network list|grep "ocp3_network_${USERNAME}"|awk '{print $2}'); do echo "Delete network(${network})"; openstack network delete $network; done
  echo ""

  echo "Delete Security Group"
  for securityGrp in $(openstack security group list|grep "${USERNAME}_ocp3_security_grp"|awk '{print $2}'); do echo "Delete securityGroup(${securityGrp})"; openstack security group delete $securityGrp; done
  echo ""

  echo "Delete Project List"
  for project in $(openstack project list |grep ocp311_tamlab_${USERNAME}|awk '{print $2}'); do echo "Delete project(${project})"; openstack project delete $project; done
  echo ""


  echo "Delete DNS List"
  echo "Backup tamlab.brq.db"
  ssh root@10.37.192.157 -- cp /var/named/tamlab.brq.db /var/named/tamlab.brq.db.bak
  echo "Found number of the line from tamlab.brq.db for User"
  export num=$(ssh root@10.37.192.157 -- egrep '${USERNAME}_ocp.conf$' /var/named/tamlab.brq.db -n|cut -d: -f1)
  echo "Delete the line"
  ssh root@10.37.192.157 -- sed "${num}d" -i /var/named/tamlab.brq.db

#  echo "Delete User List"
#  for user in $(openstack user list|grep ${USERNAME}|awk '{print $2}'); do echo "Delete user(${user})"; openstack user delete $user; done

  
fi

