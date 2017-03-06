#!/bin/bash
if [[ $# == 0 ]];
then
	echo "No conditions, using default, no mean, standard powerline"
	#DEFAULT=true
fi
# -e=*|--extension=*)
#EXTENSION="${i#*=}"
#DEFAULT=false
MEAN=false
QUICK=false
for i in "$@"
do
	#echo "doing ${i}"
case $i in
    -h|--help)
    shift # past argument=value
	echo -e "Possible arguments:\n -m,--mean : Installs MEAN, default is no MEAN\n -q, --quick : Quick Powerline install, default is standard\n -h, --help : these instructions\n\n"
	exit 1
    ;;
    -m|--mean)
    MEAN=true
    shift # past argument=value
    ;;
    -q|--quick)
    QUICK=true
    shift # past argument=value
    ;;
    #-d|--default)
    #DEFAULT=true
    #MEAN=false
    #QUICK=false
    #shift # past argument with no value
    #;;
    *)
     # unknown option
     echo -e "Unknown option, try -h, --help\n\n"
     exit 1
    ;;
esac
done

#echo "MEAN = ${MEAN}"
#echo "QUICK = ${QUICK}"

if ${MEAN};
then
	echo "MEAN"
else
	echo "NOMEAN"
fi
