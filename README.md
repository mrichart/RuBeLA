RuBeLA - Rule Based Link Adaptation
======

This project consist of two different things:
- A mechanism for link adaptation in wireless networks based on rules using the tau-fst library.
- The NS3 Simulator with ns-3-dce module and some modifications to simulate the adaptation mechanism.

Steps to configure and build the project after you clone it:

- Download all the submodules:
  - git submodule init
  - git submodule update

- Download bake: 
  hg clone http://code.nsnam.org/bake (you need Mercurial installed)

- Set variable for bake:
  export BAKE_HOME=`pwd`/bake
  export PATH=$PATH:$BAKE_HOME
  export PYTHONPATH=$PYTHONPATH:$BAKE_HOME

- Configure bake:
  cp bakeconf_rubela.xml bake/
  bake.py configure -c bakeconf_rubela.xml -p ns3-git -i ns3 --sourcedir=.
  
- Download dependencies:
  bake.py download
  (If libc-debug is not found you need to install it. libc6-dbg in Ubuntu)

- Build and install
  bake.py build
  
- Build lua static:
  cd lua-static/luasocket-2.0.2/src
  make static
  cd ../../lua-static/lua-5.1.5/src
  make ns3
  cp lua ../../../utils
  cd ../../..

Running an example:

- Copy some files into ns3:
  sh config-dce-rate-loss.sh

  
