os_() {
	if command -v curl >/dev/null 2>&1; then
		echo "curl已安装"
	else
		echo "curl未安装"
		$1 install curl -y
		echo "curl安装完成"
	fi
	echo "############判断是否安装了docker##############"
	# author:iimitcool
	if ! type docker >/dev/null 2>&1; then

		echo 'docker 未安装'
		echo '开始安装Docker....'
		curl -sSL https://get.daocloud.io/docker | sh
		echo '配置Docker开启启动'
		systemctl enable docker
		systemctl start docker
	fi

	echo "############开始安装青龙##############"
	mkdir qinglong
	cd qinglong
	wget https://raw.fastgit.org/limitcool/OneStepQingLong/main/docker-compose.yml
	docker-compose up -d
	echo "############青龙安装完成##############"
}
if command -v apt >/dev/null 2>&1; then
	os_ apt
else
	yum install -y yum-utils
	os_ yum
fi
