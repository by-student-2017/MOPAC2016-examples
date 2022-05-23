Installation
(ubuntu 18.04 LTS or ubuntu 20.04 LTS)

XLaunch (WSL)
1. sudo apt update
2. sudo apt -y install xfce4-terminal
3. sudo apt -y install xfce4
  gdm3 -> ok
  (or zsudo apt -y install xfce4 --fix-missing)
4. echo "export DISPLAY=:0.0" >> .bashrc
5. bash

MOPAC (mopac-22.0.1-linux.run)
(http://openmopac.net/Download_MOPAC_Executable_Step2.html)
1. sudo apt -y install libomp5-7
  ("sudo apt -y install libomp5-7" set "libomp.so.5" on "/lib/x86_64-linux-gnu")
2. wget https://github.com/openmopac/mopac/releases/download/v22.0.1/mopac-22.0.1-linux.run
3. chomod +x mopac-22.0.1-linux.run
4. sudo ./mopac-22.0.1-linux.run
5. echo 'PATH=$PATH:/opt/mopac/bin' >> .bashrc
6. bash

NAMD (NAMD 2.14 for Linux-x86_64-multicore)
(https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=NAMD)
1. tar zxvf NAMD_2.14_Linux-x86_64-multicore.tar.gz
2. cd NAMD_2.14_Linux-x86_64-multicore

QMMMM
1. wget https://www.ks.uiuc.edu/~rcbernardi/QMMM/Examples/Example1.tar.gz
2. tar zxvf Example1.tar.gz
3. Example1
4. cd Example1
5. mkdir NAMD_Example1
6. vi config.namd
----------(Please, change "username" for your PC)
qmBaseDir  "/home/username/Example1/NAMD_Example1"
qmExecPath      "/opt/mopac/bin/mopac"
----------
7. vmd -dispdev text -e prepare.qm.region.tcl
8. $HOME/NAMD_2.14_Linux-x86_64-multicore/namd2 config.namd | tee out.log
9. vmd -e display_charges.tcl