#!/bin/bash
# Search mtx status for Barcode 
#
# By Andrew Torres
#

set -e

while getopts ":b" opt; do
  case $opt in
    b) barcode="$OPTARG"
    # first, strip underscores
    barcode=${barcode//_/}
    # next, replace spaces with underscores
    barcode=${barcode// /_}
    # now, clean out anything that's not alphanumeric or an underscore
    barcode=${barcode//[^a-zA-Z0-9_]/} 
    # finally, lowercase with TR
    barcode=`echo -n $barcode | tr A-Z a-z`
    #grep mtx status output
    mtx status | cut -d= -f2 | grep -i $barcode
    ;;
    \?) echo "Invalid option -$OPTARG" >&2; exit $?
    ;;
  esac
done
