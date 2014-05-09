#!/bin/sh
mine stop
sleep 5
cd /opt/miners/
git clone https://github.com/Max-Coin/cgminer cgminer-keccak
cd /opt/miners/cgminer-keccak
make clean
sleep 5
chmod +x autogen.sh
./autogen.sh
sleep 2
apt-get install libudev-dev
sleep 2
cp /opt/ADL/include/* /opt/miners/cgminer-keccak/ADL_SDK/
sleep 2
CFLAGS="-O2 -Wall -march=native -I /opt/AMDAPP/include/" LDFLAGS="-L/opt/AMDAPP/lib/x86" ./configure --enable-keccak --enable-opencl
sleep 5
make install
sleep 5
clear
cp example.conf /etc/bamt/cgminer-keccak.conf
cd /etc/bamt/
patch /etc/bamt/bamt.conf <<.
115a116
>   cgminer_opts: --api-listen --config /etc/bamt/cgminer-keccak.conf
124a126
>   # Cgminer 3.7.2 "keccak"
130a133
>   miner-cgminer-keccak: 1
.
patch /opt/bamt/common.pl <<.
1477a1478,1480
>       } elsif (\${\$conf}{'settings'}{'miner-cgminer-keccak'}) {
>         \$cmd = "cd /opt/miners/cgminer-keccak;/usr/bin/screen -d -m -S cgminer-keccak /opt/miners/cgminer-keccak/cgminer --keccak \$args";
>         \$miner = "cgminer-keccak";
.
cd /etc/bamt/
patch /etc/bamt/cgminer-keccak.conf <<.
19a20,23
> "api-listen": true,
> "api-port": "4028",
> "api-allow": "W:127.0.0.1",
> 
.
echo 'Keccak Miner Installed.'
echo 'Please review your /etc/bamt/bamt.conf to enable.'
echo 'Configure /etc/bamt/cgminer-keccak.conf with pool'
