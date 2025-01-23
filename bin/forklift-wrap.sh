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
java -jar ./bin/forklift.jar ${A} ${B} > ${TMP_OUT}
ret=$?

rm ${TMP_OUT}

exit ${ret}
