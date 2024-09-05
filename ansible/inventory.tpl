%{ for ip in Master_Node ~}
Control_Plane:
  hosts:
    Master_Node:
      ansible_host: ${ip}
      ansible_user: ec2-user
%{ endfor ~}

%{ for ip in Worker_Node ~}

Workers:
  hosts:
    Worker_Node_1:
      ansible_host: ${ip}
      ansible_user: ec2-user
%{ endfor ~}
