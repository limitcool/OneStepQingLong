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
	if command -v docker >/dev/null 2>&1; then
		echo "docker已安装"
	else
		echo 'docker 未安装'
		echo '开始安装Docker....'
		curl -sSL https://get.daocloud.io/docker | sh
		echo '配置Docker开启启动'
		systemctl enable docker
		systemctl start docker
	fi
}
if command -v apt >/dev/null 2>&1; then
	os_ apt
else
	yum install -y yum-utils
	os_ yum
fi

if command -v docker-compose >/dev/null 2>&1; then
	echo "docker-compose已安装"
else
	echo 'docker-compose 未安装'
	echo '开始安装Docker-compose....'
	# pip install --upgrade pip
	# pip install docker-compose
	curl -L "https://github.com/docker/compose/releases/download/v2.0.0-rc.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
fi
echo "############开始安装青龙##############"
mkdir qinglong
cd qinglong
wget https://raw.fastgit.org/limitcool/OneStepQingLong/main/docker-compose.yml
docker-compose up -d
echo "############青龙安装完成##############"
