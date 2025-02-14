#!/bin/bash

# Check the number of command-line arguments
if [ \( "$#" -lt 1 \) ] ; then
	echo "usage: ${0} <input-ba> [<params>]"
	exit 1
fi

A=$1
B=$2
shift
shift
params="$*"

#TMP=$(mktemp)
#./util/ba2hoa.py ${INPUT} > ${TMP} || exit $?

TMP_OUT=$(mktemp)

set -o pipefail
# ./bin/autfilt --complement --ba ${params} ${TMP} > ${TMP_OUT} 
# ./bin/kofola_no_preproc_cnt --inclusion ${A} ${B} ${params} > ${TMP_OUT}

# ./bin/kofola_cnt --inclusion ${A} ${B} --params=${params}  > ${TMP_OUT}
../verifit_kofola/kofola/build/src/kofola_cnt --inclusion ${A} ${B} --params=${params} > ${TMP_OUT}
ret=$?

cat ${TMP_OUT} | head -n 1

rm ${TMP_OUT}

exit ${ret}