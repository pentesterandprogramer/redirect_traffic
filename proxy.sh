#!/usr/bin/env bash
name=$(curl -s ifconfig.co)
trap 'echo "$name"' EXIT
#Give me name script
name1=$(basename $0)
	case "$1" in
		"start")
	
		sudo apt-get install tor privoxy &>/dev/null;
		echo "start tor and redirect trafic....";
                sudo service tor start && service privoxy start;
		export http_proxy="http://127.0.0.1:8118/"; 
		export https_proxy="http://127.0.0.1:8118/";;
		
		
	"stop" )
	
		echo "stop redirect trafic......";
		unset http_proxy;
		unset https_proxy;
		sudo service tor stop;
		sudo service privoxy stop;;
	"show_ip")
	

		name=$(curl -s ifconfig.co);
		printf "My ip is \033[31m%s\033[0m \n" ${name};;
		
	*)
		echo -e "\033[1;31m sorry no command line Enter:\033[0m" >&2;
		echo -e "\033[1m execute like me\033[0m \033[32m'source $name1 [start|stop|show_ip]'\033[0m" >&2;

		exit 1;;

	esac
	

		

if  ! grep -q  "forward-socks4 / 127.0.0.1:9050 ." /etc/privoxy/config
then
	echo "forward-socks4 / 127.0.0.1:9050 ." | sudo tee -a  /etc/privoxy/config
	echo "forward-socks5 / 127.0.0.1:9050 ." | sudo tee -a  /etc/privoxy/config
	echo "forward-socks4a / 127.0.0.1:9050 ."| sudo tee -a  /etc/privoxy/config
fi




