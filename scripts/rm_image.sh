#!/bin/bash
image=$1

vagrant ssh -- /bin/bash << EOF

	if [ "$image" == "all" ]; then
		containers=(\$(docker ps -a -q));
		if [ "\${#containers[@]}" == "0" ]; then
			echo 'No containers are running';
			exit 1;
		fi
	else 
		containers=(\$(docker ps -a -q | grep ^$image));
		if [ "\${#containers[@]}" == "0" ]; then
			echo 'Container not found';
			exit 1;
		fi
	fi


	for i in \${containers[@]}; do
		echo "Stopping Container:" \$(docker stop \$i);
		echo "Removing Container:" \$(docker rm \$i);
	done		
EOF
