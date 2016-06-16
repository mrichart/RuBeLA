#!/bin/sh

cant_ap=2

aux_ap=$(($cant_ap-1))

for i in `seq 0 $aux_ap`; do

  mkdir ../ns-3-dce-git/"files-$i"

	mkdir ../ns-3-dce-git/"files-$i/lupa"
	
	mkdir ../ns-3-dce-git/"files-$i/rnr"
	
	mkdir ../ns-3-dce-git/"files-$i/fsm"
	
	cp ./lua ../ns-3-dce-git/files-$i/
	
	cp -r ../LuPA/* ../ns-3-dce-git/files-$i/lupa/
	
	cp -r ../Rnr/* ../ns-3-dce-git/files-$i/rnr/
	
	cp -r ./fsm/* ../ns-3-dce-git/files-$i/fsm/
	
	echo "my_name='ap$i'

my_name_pdp='AP$i/lupa/pdp'

my_name_pep='NS3-PEP'
my_name_rmoon='NS3-RMOON'

my_host='127.0.0.1'

my_localstate_port=9590

upstream = '127.0.0.1'

enable_rmoon = false
enable_pep = false

pdp_window_size = 10
trap_generation_interval = 1

local function randomize ()
	local res = 0;                                 
   local a, b, c, d = string.match(my_host, '(%d+)%.(%d+)%.(%d+)%.(%d+)');
   res = math.pow(255,3)*a + math.pow(255,2)*b + 255*c + d;
	math.randomseed(res);
end;

randomize()

environment = 'environment'

"  >> ../ns-3-dce-git/files-$i/lupa/"config_lamim_NS3.txt"

###############################################################################

echo "my_host='127.0.0.1'

upstream[1] = '127.0.0.1'

"  >> ../ns-3-dce-git/files-$i/rnr/"config_lamim_NS3.txt"

done
