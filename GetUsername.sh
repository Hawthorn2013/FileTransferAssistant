#!/bin/sh
uid_min=1000
log_name=GetUsername.log
info_dir=`pwd`
echo "info_dir=${info_dir}" > "${info_dir}"/"${log_name}"
if [ $# != 1 ]; then
    echo "Input work_dir as param1."
    exit 1
fi
work_dir=$1
if [ ! -d "${work_dir}" ]; then
    echo "work_dir is not exist."
    exit 1
fi
cd ${work_dir}
work_dir=`pwd`
echo "work_dir=${work_dir}" >> "${info_dir}"/"${log_name}"
rm "${info_dir}"/*.username
while read line; do
    owner_name=`echo "${line}" | cut -d ':' -f 1`
    owner_uid=`echo "${line}" | cut -d ':' -f 3`
    if [ "${owner_uid}" -ge "${uid_min}" ]; then
        echo "${owner_name}"
        find . -user "${owner_name}" >> "${info_dir}"/"${owner_name}".username
    fi
done < /etc/passwd

