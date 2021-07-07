#!/bin/sh

if test -e ~/bin/repo
then
	echo "~/bin" exist, confirm delete old aosp? y or n?
	read confirm
	if [ $confirm = "y" ]
	then
		echo "Old aosp deleting"
		rm -rf ~/bin
		rm -rf ~/aosp
		echo "Old aosp deleted, start download new aosp"
	else
		echo "Keep the old aosp"
		exit
	fi
fi

mkdir ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
PATH=$PATH:~/bin
if [[ $OSTYPE == "darwin"* ]]; then
	echo ostype osx
	sed -i '.bak' 's+https://gerrit.googlesource.com/git-repo+https://gerrit-googlesource.lug.ustc.edu.cn/git-repo+g' ~/bin/repo
else
	echo ostype linux
	sed -i 's+https://gerrit.googlesource.com/git-repo+https://gerrit-googlesource.lug.ustc.edu.cn/git-repo+g' ~/bin/repo
fi
mkdir ~/aosp
cd ~/aosp
echo start download branch master
repo init -u git://mirrors.ustc.edu.cn/aosp/platform/manifest
repo sync
