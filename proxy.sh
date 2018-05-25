#!/usr/bin/env bash
printf "Execute script like me '\033[32msource proxy.sh'\033[0m sleep 2"
sleep 2
clear
name=$(curl -s ifconfig.me)

printf "My ip is \033[31m%s\033[0m \n" ${name}

read -p "Do you install tor and privoxy:(Y|N)" yes

case $yes in
	[yY]) sudo apt-get install tor privoxy;;
esac
read -p "Do you redirect trafic in the tor: y|n: " answer




case "$answer" in
	[yY]) echo "start....";sudo service tor start && service privoxy start;
		export http_proxy="http://127.0.0.1:8118/"; 
		export https_proxy="http://127.0.0.1:8118/";
		;;
		
	[nN]) 
		unset http_proxy;
		unset https_proxy;
		;;

	*)
	 echo "for redirect execute like me . test.sh" ;;
esac
if  ! grep -q  "forward-socks4 / 127.0.0.1:9050 ." /etc/privoxy/config
then
	echo "forward-socks4 / 127.0.0.1:9050 ." | sudo tee -a  /etc/privoxy/config
	echo "forward-socks5 / 127.0.0.1:9050 ." | sudo tee -a  /etc/privoxy/config
	echo "forward-socks4a / 127.0.0.1:9050 ."| sudo tee -a  /etc/privoxy/config
fi




name=$(curl -s ifconfig.me)
printf "My ip is \033[31m%s\033[0m \n" ${name}
