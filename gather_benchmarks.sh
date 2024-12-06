#!/bin/bash

python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt && pip install -r ../pycobench/requirements.txt
export PATH=$PATH":/home/xalexa09/pycobench/bin"

cat bench/hyperltl | pycobench -c ba-incl.yaml -j 2 -t 900 -o results/hyperltl_no_opt > pycobench_log_hy.log && \
cat bench/rabit_hoa | pycobench -c ba-incl.yaml -j 2 -t 900 -o results/rabit_no_opt > pycobench_log_rab.log && \
cat bench/termination | pycobench -c ba-incl.yaml -j 2 -t 900 -o results/termination_no_opt > pycobench_log_term.log && \
cd results && \
cat hyperltl_no_opt | pyco_proc --csv > hyperltl_no_opt.csv && \
cat rabit_no_opt | pyco_proc --csv > rabit_no_opt.csv && \
cat termination_no_opt | pyco_proc --csv > termination_no_opt.csv && \
echo "SUCCESS!"