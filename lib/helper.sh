#!/bin/bash

#************************************************#
#                  helper.sh                     #
#           Written by Charles Bock              #
#                Oct 13, 2010                    #
#                                                #
#    Reuseable Code For Minecraft Admin Tool     #
#************************************************#

configFile="../config"

if [ -f "$configFile" ] ; then
    adminMail="$(grep 'adminMail:' $configFile | awk '{ print $2 }')"
    repoName="$(grep 'repoName:' $configFile | awk '{ print $2 }')"
    repoPath="$(grep 'repoPath:' $configFile | awk '{ print $2 }')"
    mapper="$(grep 'mapperName:' $configFile | awk '{ print $2 }')"
    mapperPath="$(grep 'mapperName:' $configFile | awk '{ print $2 }')"
    gitPath="$(grep 'gitPath:' $configFile | awk '{ print $2 }')"
	mcPath="$(grep 'mcPath:' $configFile | awk '{ print $2 }')"

else
    
	adminMail="root@localhost"
	repoName="NONE"
	repoPath="NONE"
	mapper="c10t"
	mapperPath="${HOME}/bin/${mapper}"
	gitPath="/usr/bin/git"
	mcPath="NONE"
fi

worldPath="${mcPath}/world"
nowTime=$(date +%s)


arch=$(uname -m) # (e.g i386, x86_64, sun4u)
if [ "$ARCH" = "i686" -o "$ARCH" = "i586" -o "$ARCH" = "i486" ] ; then
    arch="i386"
fi

version="ERROR"
if [ -f /etc/redhat-release ] ; then #Redhat/Fedora/CentOS
        version="$(cat /etc/redhat-release)"
        sName="rpm"
else
    if [ -f /etc/lsb-release ] ; then #Ubuntu
            version="$(cat /etc/lsb-release)"
            sName="deb"
    else
        if [ -f /etc/*release ] ; then #Most Others
                version="$(cat /etc/*release)"
                colorMsg "Your distribution is not supported at this time!" $red $bold
                exit
        fi
    fi
fi

#Color Vars#
black="30"
red="31"
green="32"
yellow="33"
blue="34"
white="37"
reset="\033[m"

#Style Vars#
none="0"
bold="1"
underline="4"

colorMsg ()
{
    message=$1
    color=${2:-$white}      # Defaults to black, if not specified.
    style=${3:-$none}       # Defaults to none, if not specified.
    echo -e "\033[$style;$color;40m"$message$reset
    return
}
color ()
{
    color=${1:-$white}      # Defaults to black, if not specified.
    style=${2:-$none}       # Defaults to none, if not specified.
    echo -e "\033[$style;$color;40m"
    return
}
resetColor ()
{
    echo -e "$reset"
}

