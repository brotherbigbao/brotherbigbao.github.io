#!/usr/bin/env bash
cd ~
wget https://openpublic.oss-cn-shanghai.aliyuncs.com/gamestream/frp_0.56.0_linux_amd64.tar.gz
tar -zxvf frp_0.56.0_linux_amd64.tar.gz

cd ~/frp_0.56.0_linux_amd64

mv frps.toml frps.toml.backup
wget https://openpublic.oss-cn-shanghai.aliyuncs.com/gamestream/frps.toml

echo "alias frpStart='cd ~/frp_0.56.0_linux_amd64 && nohup ./frps -c frps.toml &'" >> ~/.profile
echo "alias frpStatus='ps -ef | grep frp | grep -v grep'" >> ~/.profile
echo "alias frpLog='cd ~/frp_0.56.0_linux_amd64 && tail -f nohup.out'" >> ~/.profile
echo "alias frpKill=\"kill \$(ps -ef | grep frp | grep -v grep | awk '{print \$2}')\"" >> ~/.profile