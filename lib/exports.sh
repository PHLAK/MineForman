#!/bin/bash

#************************************************#
#                  exports.sh                    #
#           Written by Charles Bock              #
#                Oct 13, 2010                    #
#                                                #
#    Reuseable Code For Minecraft Admin Tool     #
#************************************************#

getGit ()
{
    colorMsg "Installing Git..." $green $bold
    if [ sName=="rpm" ]; then
        yum -y install git-all > /dev/null 2>&1
    fi
    if [ sName=="deb" ]; then
        apt-get install git-core > /dev/null 2>&1
    fi
    colorMsg "Complete!" $green $bold
}

setupGit ()
{
    #make sure git exists
    if [ ! -e /usr/bin/git ]; then
        colorMsg "Git Missing!" $red $bold
        read -p "Install Now? (y/n):"
        if [ "$REPLY" == "y" ] ;then
             getGit
        else
            echo "Exiting!"
            exit
        fi
    fi
 

}

getMapper ()
{
    if [ ! -d ~/bin ]; then
        colorMsg "Creating bin folder and path for user $USER" $green $bold
        mkdir -p ~/bin
    fi
        colorMsg "Installing $mapper mapper..." $green $bold
        myDir=`pwd`
        cd /tmp
    if [ arch=="x86_64" ]; then
        wget http://github.com/downloads/udoprog/c10t/c10t-1.1-linux-x86_64.tar.gz > /dev/null 2>&1
        tar -xvzf c10t-1.1-linux-x86_64.tar.gz > /dev/null 2>&1
        mv ./c10t-1.1/c10t ~/bin
        cd $myDir
    else
         wget http://github.com/downloads/udoprog/c10t/c10t-1.1-linux-x86.tar.gz > /dev/null 2>&1
        tar -xvzf c10t-1.1-linux-x86.tar.gz > /dev/null 2>&1
        mv ./c10t-1.1/c10t ~/bin
        cd $myDir
    fi
        colorMsg "Complete!" $green $bold
}

setupMap ()
{
    #Check for mapper program
    if [ ! -e $mapperPath ]; then
        colorMsg "Mapper Missing!" $red $bold
        read -p "Install Now? (y/n):"
        if [ "$REPLY" == "y" ] ;then
             getMapper
        else
            echo "Exiting!"
            exit
        fi
    fi

}

