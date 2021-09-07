echo "############判断是否安装了docker##############"
# author:iimitcool
if ! type docker >/dev/null 2>&1; then

	cat >/etc/yum.repos.d/docker.repo<<EOF
[docker-ce-edge]
name=Docker CE Edge - \$basearch
baseurl=https://mirrors.aliyun.com/docker-ce/linux/centos/7/\$basearch/edge
enabled=1
gpgcheck=1
gpgkey=https://mirrors.aliyun.com/docker-ce/linux/centos/gpg
EOF

    echo 'docker 未安装';
	echo '开始安装Docker....';	
	yum -y install docker-ce
	
	echo '配置Docker开启启动';
	systemctl enable docker
	systemctl start docker	

cat >> /etc/docker/daemon.json << EOF
{
  "registry-mirrors": ["https://b9pmyelo.mirror.aliyuncs.com"]
}
EOF

	systemctl restart docker
	
else
    echo 'docker 已安装';
fi

echo "############开始安装青龙##############"
mkdir qinglong
cd qinglong
wget https://raw.fastgit.org/limitcool/OneStepQingLong/main/docker-compose.yml
docker-compose up -d
echo "############青龙安装完成##############"