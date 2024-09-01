%{ for ip in Master_Node ~}
Master:
  hosts:
    Master_Node:
      ansible_host: ${ip}
      ansible_user: ec2-user
%{ endfor ~}

%{ for ip in Worker_Node ~}

Worker:
  hosts:
    Worker_Node_1:
      ansible_host: ${ip}
      ansible_user: ec2-user
%{ endfor ~}
