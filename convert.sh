#!/bin/bash

function extract_hosts {
#work_dir="/var/lib/awx/projects/inv"	
cat idmag.src | while read l
  do
    	  
    printf "pos$(echo "${l}" | awk -F '|' '{ print $2}' | sed s'/ //'g) \
	    ansible_host=$(echo "${l}" | awk -F '|' '{ print $4}' | sed s'/ //'g)  \
	    ansible_group=$(echo "${l}" | awk -F '|' '{ print $1}' | sed s'/ //'g)  \
	    #$(echo "${l}" | awk -F '|' '{ print $3}' | sed s'/ //'g)\n"
done
}
echo
echo "GENERATION FICHIER INI"
extract_hosts > idmag.ini && \
echo "DONE"
echo "REAJUSTEMENT DES GROUPES"

sed -i -e s'/ansible_group=1/ansible_group=MARJANE/'g idmag.ini;
sed -i -e s'/ansible_group=2/ansible_group=MARKET/'g  idmag.ini;
sed -i -e s'/ansible_group=3/ansible_group=DIGIBAY/'g idmag.ini;
sed -i -e s'/ansible_group=4/ansible_group=OTOP/'g  idmag.ini;
sed -i -e s'/ansible_group=5/ansible_group=CITY/'g  idmag.ini;
sed -i -e s'/ansible_group=6/ansible_group=OVS/'g  idmag.ini;
sed -i -e s'/ansible_group=9/ansible_group=TEST/'g idmag.ini;
echo "DONE";
ansible-inventory -i idmag.ini --list -y > inventory.yaml;


#END


