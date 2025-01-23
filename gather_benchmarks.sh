#!/bin/bash

python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt && pip install -r pycobench/requirements.txt

config_file_kofola_spot="ba-incl_kofola_spot.yaml"
config_file_java="ba-incl_java.yaml"

# include also state space count
if [[ "$1" == "--cnt" ]]; then
    config_file_kofola_spot="ba-incl_kofola_spot_cnt.yaml"
fi

mkdir -p results
mkdir -p benchmarks_gathering_logs

bench_dir="bench"
bench_dir_ba="bench_ba"

output_file_hy="hyperltl"
output_file_term="termination"
output_file_rab="rabin"

# results for kofola and spot
cat "$bench_dir"/hyperltl | pycobench/bin/pycobench -c "$config_file_kofola_spot" -j 2 -t 900 -o results/hyperltl_kofola_spot > benchmarks_gathering_logs/pycobench_log_hy_kofola_spot.log && \
cat "$bench_dir"/rabit_hoa | pycobench/bin/pycobench -c "$config_file_kofola_spot" -j 2 -t 900 -o results/rabit_kofola_spot > benchmarks_gathering_logs/pycobench_log_rab_kofola_spot.log && \
cat "$bench_dir"/termination | pycobench/bin/pycobench -c "$config_file_kofola_spot" -j 2 -t 900 -o results/termination_kofola_spot > benchmarks_gathering_logs/pycobench_log_term_kofola_spot.log && \
cd results && \
cd .. && \
# results for forklift, bait, rabit
cat "$bench_dir_ba"/hyperltl | pycobench/bin/pycobench -c "$config_file_java" -j 2 -t 900 -o results/hyperltl_java_tools > benchmarks_gathering_logs/pycobench_log_hy_java_tools.log && \
cat "$bench_dir_ba"/rabit_hoa | pycobench/bin/pycobench -c "$config_file_java" -j 2 -t 900 -o results/rabit_java_tools > benchmarks_gathering_logs/pycobench_log_rab_java_tools.log && \
cat "$bench_dir_ba"/termination | pycobench/bin/pycobench -c "$config_file_java" -j 2 -t 900 -o results/termination_java_tools > benchmarks_gathering_logs/pycobench_log_term_java_tools.log && \
cd results && \
# process paths from java tools results, so the names of test cases match the kofola and spot results
sed 's|automata_ba/||g; s|\hoa.ba|hoa|g;' hyperltl_java_tools >  "$output_file_hy" && \
sed 's|automata_ba/||g; s|\hoa.ba|hoa|g;' termination_java_tools >  "$output_file_term" && \
sed 's|automata_ba/||g; s|\hoa.ba|hoa|g;' rabit_java_tools >  "$output_file_rab" && \
# append kofola and spot results into output file
cat hyperltl_kofola_spot >> "$output_file_hy" && \
cat termination_kofola_spot >> "$output_file_term" && \
cat rabit_kofola_spot >> "$output_file_rab" && \
# generate .csv files
cat "$output_file_hy" | ../pycobench/bin/pyco_proc --csv > hyperltl_exec.csv && \
cat "$output_file_term" | ../pycobench/bin/pyco_proc --csv > termination_exec.csv && \
cat "$output_file_rab" | ../pycobench/bin/pyco_proc --csv > rabit_exec.csv && \
echo "SUCCESS!"