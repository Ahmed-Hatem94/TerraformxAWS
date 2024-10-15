Control_Plane:
  hosts:
%{ for config_key, config_value in master ~}
    ${config_key}:
      ansible_host: ${config_value}
      ansible_user: ec2-user
%{ endfor ~}

Workers:
  hosts:
  %{ for config_key, config_value in worker ~}

    ${config_key}:
      ansible_host: ${config_value}
      ansible_user: ec2-user
%{ endfor ~}
