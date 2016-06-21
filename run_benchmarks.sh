# Runs the following PARSEC Benchmarks: Canneal, Facesim, Bodytrack, Fluidanimate using jemalloc and tcmalloc as memory allocators
# Written by Gal Fisher and Dor Ma'ayan, June, 2016

for i in {1..2}
do
	env LD_PRELOAD=/usr/local/lib/libtcmalloc.so ~/code/measure_vmpeak/measure_vmpeak ~/parsec-3.0/pkgs/kernels/canneal/inst/amd64-linux.gcc/bin/canneal 1 15000 2000 ~/parsec-3.0/pkgs/kernels/canneal/run/2500000.nets 600 > /dev/null
	echo -n "canneal tcmalloc "
	tail -1 vmpeak.stat | tr -s ' ' ' ' | cut -d' ' -f2
	rm vmpeak.stat
	env LD_PRELOAD=/usr/local/lib/libjemalloc.so ~/code/measure_vmpeak/measure_vmpeak ~/parsec-3.0/pkgs/kernels/canneal/inst/amd64-linux.gcc/bin/canneal 1 15000 2000 ~/parsec-3.0/pkgs/kernels/canneal/run/2500000.nets 600 > /dev/null
	echo -n "canneal jemalloc "
	tail -1 vmpeak.stat | tr -s ' ' ' ' | cut -d' ' -f2; rm vmpeak.stat
done

curr_dir=`pwd`
cd ~/parsec-3.0/pkgs/apps/facesim/run
for i in {1..1}
do
	env LD_PRELOAD=/usr/local/lib/libtcmalloc.so ~/code/measure_vmpeak/measure_vmpeak ~/parsec-3.0/pkgs/apps/facesim/inst/amd64-linux.gcc/bin/facesim -timing -threads 1 -lastframe 100 > /dev/null
	echo -n "facesim tcmalloc "
	tail -1 vmpeak.stat | tr -s ' ' ' ' | cut -d' ' -f2
	rm vmpeak.stat
	env LD_PRELOAD=/usr/local/lib/libjemalloc.so ~/code/measure_vmpeak/measure_vmpeak ~/parsec-3.0/pkgs/apps/facesim/inst/amd64-linux.gcc/bin/facesim -timing -threads 1 -lastframe 100 > /dev/null
	echo -n "facesim jemalloc "
	tail -1 vmpeak.stat | tr -s ' ' ' ' | cut -d' ' -f2
	rm vmpeak.stat
done
cd ${curr_dir}

for i in {1..3}
do
	env LD_PRELOAD=/usr/local/lib/libtcmalloc.so ~/code/measure_vmpeak/measure_vmpeak ~/parsec-3.0/pkgs/apps/bodytrack/inst/amd64-linux.gcc/bin/bodytrack ~/parsec-3.0/pkgs/apps/bodytrack/run/sequenceB_261/ 4 261 4000 5 0 1 > /dev/null
	echo -n "bodytrack tcmalloc "
	tail -1 vmpeak.stat | tr -s ' ' ' ' | cut -d' ' -f2
	rm vmpeak.stat
	env LD_PRELOAD=/usr/local/lib/libjemalloc.so ~/code/measure_vmpeak/measure_vmpeak ~/parsec-3.0/pkgs/apps/bodytrack/inst/amd64-linux.gcc/bin/bodytrack ~/parsec-3.0/pkgs/apps/bodytrack/run/sequenceB_261/ 4 261 4000 5 0 1 > /dev/null
	echo -n "bodytrack jemalloc "
	tail -1 vmpeak.stat | tr -s ' ' ' ' | cut -d' ' -f2
	rm vmpeak.stat
done

for i in {1..2}
do
	env LD_PRELOAD=/usr/local/lib/libtcmalloc.so ~/code/measure_vmpeak/measure_vmpeak ~/parsec-3.0/pkgs/apps/fluidanimate/inst/amd64-linux.gcc/bin/fluidanimate 1 500 ~/parsec-3.0/pkgs/apps/fluidanimate/run/in_500K.fluid > /dev/null
	echo -n "fluidanimate tcmalloc "
	tail -1 vmpeak.stat | tr -s ' ' ' ' | cut -d' ' -f2
	rm vmpeak.stat
	env LD_PRELOAD=/usr/local/lib/libjemalloc.so ~/code/measure_vmpeak/measure_vmpeak ~/parsec-3.0/pkgs/apps/fluidanimate/inst/amd64-linux.gcc/bin/fluidanimate 1 500 ~/parsec-3.0/pkgs/apps/fluidanimate/run/in_500K.fluid > /dev/null
	echo -n "fluidanimate jemalloc "
	tail -1 vmpeak.stat | tr -s ' ' ' ' | cut -d' ' -f2
	rm vmpeak.stat
done
