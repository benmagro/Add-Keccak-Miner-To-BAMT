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
echo 'Keccak Miner Installed'
echo 'Please review you /etc/bamt/bamt.conf to enable'ehco 'Notice! Change in your config, kernle to keccak, and keccak true.'