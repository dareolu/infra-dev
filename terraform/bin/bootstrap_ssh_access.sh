#!/bin/bash
ARRAY=(  139.162.255.234 139.162.232.149  )
for i in ${ARRAY[@]}; do
  #if [[ $i -eq hostname -i ]]; then
    if [[ -f ~/.ssh/id_rsa.pub ]] || [[ -f ~/.ssh/id_rsa ]] ; then
      echo "No need to create ssh key pairs, moving on to next task"
    else
      sudo ssh-keygen -t rsa -P ""
      sudo cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
      sudo ssh-copy-id -i ~/.ssh/id_rsa.pub root@$1
    fi

    ssh root@$i "ls -latr ~/.ssh/id_rsa" 2> /dev/null
    if  [[ $? -eq 0 ]]; then
      echo "private key file exists, will not copy over to $i"
    fi

    ssh root@$i "ls -latr ~/.ssh/authorized_keys" 2> /dev/null
    if  [[ $? -eq 0 ]]; then
        echo "authorized_keys file exists, will not copy over to $1"
    else
      scp ~/dare/bin/create_ssh_dir root@$i:~/
      ssh root@$i "chmod u+x ~/create_ssh_dir"
      ssh root@$i "sh ~/create_ssh_dir"
      scp  ~/.ssh/id_rsa root@$i:~/.ssh/id_rsa
      sudo ssh-copy-id -i ~/.ssh/id_rsa.pub root@$i
    fi
  #fi
done
