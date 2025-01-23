# Evaluation of the modular inclusion checking
### Brief description of important folders
* `automata/` - contains BAs in `.hoa` format,
* `spot_ba/` - contains simple C++ program using Spot library which takes filename of the BA in `.hoa` format as command line argument and simply prints the BA in `.ba` format,
* `automata_ba/` - contains BAs in `.ba` format (obtained by the script `automata_to_ba.sh` which uses executable from folder `spot_ba\`),
* `bin\` - contains wrappers for `auftilt, kofola, rabit, bait, forklift` tools and `.jar` files of the java tools (last three). Before executing tests, one should modify files `kofola-wrap.sh`,`kofola_cnt-wrap.sh`,`autfilt-wrap.sh`, `autfilt_cnt-wrap.sh` by providing paths to respective binaries.

### Brief description of the scripts
* `automata_to_ba.sh` - expects compiled file `spot_ba/hoa2ba.cpp`, such that exectuable name is `spot_ba/print_ba`,
* `gen_bench_file_lists.sh` - generates files containing paths to automata (this one is for `.hoa` format),
* `gen_bench_file_lists_ba.sh` - generates files containing paths to automata (this one is for `.ba` format), 
* `statistic_evaluation\mod_incl_eval.ipynb` - shows scatter plots and simple statistics, checks correctness.

### Description of main testing script
* `gather_benchmarks.sh` - Firstly creates venv, then creates folder and `benchmarks_gathering_logs`. Then runs the tests for `autfilt,kofola` using `pycobench` - one execution of `pycobench` for each type of the benchmark (`hyperltl, rabin, termination`) - outputs of `pycobench` are stored in the `results\` folder and logs in the `benchmarks_gathering_logs\`. Subsequently, tests for java tools are exectued in the same manner, however `.ba` files are needed, so there needs to be some postprocessing of the output = removing `.ba` suffix from the paths and `automata_ba/` prefix = all this so the test cases match with the ones for `kofola` and `autfilt` (NOTE that some of the java tools require the input automata files to have `.ba` suffix - which caused the postprocessing). Then the results are merged together and `.csv` files are generated in `results/` using `pyco_proc`.

## How to use
IMPORTANT Before executing the script, please read the description of the `bin\` folder (first section of this readme) and provide appropriate information accordingly.
``` 
./gather_benchmarks.sh --cnt
```
* `--cnt`: execute `kofola` and `autfilt` so that the state counts are obtained.