#!/bin/bash -e

listofpackages=(
    mate-common
    mate-doc-utils
    mate-corba
    mate-conf
    libmatecomponent
    mate-mime-data
    mate-vfs
    libmate
    libmatecanvas
    libmatecomponentui
    libmatekeyring
    mate-keyring
    libmateui
    libmatenotify
    libmatekbd
    libmateweather
    mate-icon-theme
    mate-dialogs
    mate-desktop
    mate-file-manager
    mate-notification-daemon
    mate-backgrounds
    mate-menus
    mate-window-manager
    mate-polkit
    mate-settings-daemon
    mate-control-center
    mate-panel
    mate-session-manager
    mate-themes
    mate-text-editor
    mate-file-archiver
    mate-document-viewer
    mate-file-manager-sendto
    mate-bluetooth
    mate-power-manager
    python-corba
    python-mate
    python-mate-desktop
    python-caja
    mate-file-manager-open-terminal
    mate-applets
    )
    
##TODO: ADD VERSION CONTROL CHECK!


for package in ${listofpackages[@]}
	do
	echo " "
	echo "----->  Starting $package build"
	cd $package

	if [ -f *.pkg.tar.xz ];
		#then echo "----- $package package already exists ^^ I'm checking if it's already installed..."

		then installed_pkg_stuff=$(pacman -Q | grep $package);
		#those operations could be done/written in a shorter [but a little more complex] way. I choose to let it this way to have a "readable" code
		newver=$(cat PKGBUILD | grep pkgver=) && newver=${newver##pkgver=};
		installedver=$(pacman -Q | grep $package) && installedver=${installedver##$package} && installedver=${installedver%%-*};

		if [ $newver == $installedver ]
				then  echo "!****! The same versione of package $package is already  installed,skipping...."
				else (echo "---------- START Making ->  $package -------------------" && makepkg --asroot -f ) && pacman -U --noconfirm $package-*.pkg.tar.xz
		fi
	fi

	
echo "-----> Done building & installing $package"
echo " "

cd ..
done
    
    
