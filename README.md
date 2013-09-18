RuBeLA - Rule Based Link Adaptation
======

This project consist of two different things:
- A mechanism for link adaptation in wireless networks based on rules using the tau-fst library.
- The NS3 Simulator with ns-3-dce module and some modifications to simulate the adaptation mechanism.

Steps to configure the project after you clone it:

- Download all the submodules:
  - git submodule init
  - git submodule update

- Download bake: 
  hg clone http://code.nsnam.org/bake

- Set variable for bake:
  export BAKE_HOME=`pwd`/bake
  export PATH=$PATH:$BAKE_HOME
  export PYTHONPATH=$PYTHONPATH:$BAKE_HOME

- Configure bake:
  cp bakeconf_rubela.xml bake/
  bake.py configure -c bakeconf_rubela.xml -p ns3-git -i ns3 --sourcedir=.
  
- Download dependencies:
  bake.py download

- Build and install
  bake.py build

Running an example:

  
