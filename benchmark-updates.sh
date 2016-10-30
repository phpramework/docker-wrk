#!/bin/sh

echo ""
echo "---------------------------------------------------------"
echo " Benchmarking ${FRAMEWORK}: DB Updates : Primer"
echo " wrk --latency -d 5 -c 8 -t ${BENCHMARK_CORES} http://app-server${URI_UPDATES}"
echo "---------------------------------------------------------"
echo ""

wrk --latency -d 5 -c 8 -t ${BENCHMARK_CORES} http://app-server${URI_UPDATES}
sleep 5

echo ""
echo "---------------------------------------------------------"
echo " Benchmarking ${FRAMEWORK}: DB Updates : Warming Up"
echo " wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server${URI_UPDATES}"
echo "---------------------------------------------------------"
echo ""

wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server${URI_UPDATES}
sleep 5

for c in 8 16 32 64 128 256
do
    echo ""
    echo "---------------------------------------------------------"
    echo " Benchmarking ${FRAMEWORK}: DB Updates : Concurency $c"
    echo " wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server${URI_UPDATES}$c"
    echo "---------------------------------------------------------"
    echo ""

    wrk --latency -d 15 -c 256 -t ${BENCHMARK_CORES} http://app-server${URI_UPDATES}$c 2>&1 | tee /result/updates_$c.output
    sleep 5
done
