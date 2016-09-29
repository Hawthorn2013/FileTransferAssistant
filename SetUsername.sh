#!/bin/sh
Info_Dir="`pwd`"
Work_dir="$1"
if [ $# != 1 ]; then
echo "Input Work_dir as param1."
exit 1
fi
if [ ! -d $Work_dir ]; then
echo "Work_dir is not exist."
exit 1
fi
cd "$Work_dir"
for file in ${Info_Dir}/*.username
do
echo "${file}"
owner=${file##*/}
owner=${owner%.*}
    while read line
    do
    chown ${owner} "${line}"
    done < ${file}
done


