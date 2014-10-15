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
  - export BAKE_HOME=\`pwd\`/bake
  - export PATH=$PATH:$BAKE_HOME
  - export PYTHONPATH=$PYTHONPATH:$BAKE_HOME

- Configure bake:
  - cp bakeconf_rubela.xml bake/
  - bake.py configure -c bakeconf_rubela.xml -p ns3-git -i ns3 --sourcedir=.
  
- Download dependencies:
  - bake.py download
  (If libc-debug is not found you need to install it. libc6-dbg in Ubuntu)

- Build and install:
  - bake.py build
  
- Build lua static:
  - Follow the indications in the corresponding README
  - Copy the lua executable obtained in utils

Running an example:

- Copy some files into ns3:
  - cd utils
  - sh config-dce-rate-loss.sh
  - cd ..

- Run a simulation:
  - cd ns-3-dce-git
  - ./waf --run dce-lamim-1
  

  
