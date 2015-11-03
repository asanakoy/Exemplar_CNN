# # convert data
# ============= utility function def =============
exit_if_failed()
{
    ret_code=$1
    if [ $ret_code -ne 0 ]; then
        echo "Command failed with ERROR code ${ret_code}!"
        exit $ret_code
    fi
}
# ================================================

# define variables
IN_FILE=$1
OUT_PATH=$2
DB_BACKEND=$3

RANDOMIZE=0
if [ "$4" = "randomize" ]; then
    echo "Randomly permuting the image set"
    RANDOMIZE=1
fi


echo "----CAFFE_ROOT=${CAFFE_ROOT}"
mkdir -p $OUT_PATH

BINARY_DATAFILE=$OUT_PATH/binary_dataset.bin
DB_FOLDER=$OUT_PATH/data-$DB_BACKEND
CAFFE_TOOLS_PATH="${CAFFE_ROOT}/build/tools"

echo "Input file: $IN_FILE"
echo "DB folder:  $DB_FOLDER"
echo "DB backend: $DB_BACKEND"
echo "BINARY_DATAFILE: $BINARY_DATAFILE"

if [ ! -f $BINARY_DATAFILE ]; then
    # .mat to binaries
    echo " === Converting .mat files to binaries ==="
    matlab -nodesktop -nosplash -r "\
    load('"$IN_FILE"');\
    matlab_to_binary(images, labels, '"$BINARY_DATAFILE"', "$RANDOMIZE");\
    exit;"
fi
exit_if_failed $? 

# convert data
echo " === Converting binaries to the Caffe format === "
mkdir -p $DB_FOLDER
rm -rf $DB_FOLDER
GLOG_logtostderr=1 ${CAFFE_TOOLS_PATH}/convert_binary_data.bin \
$BINARY_DATAFILE \
$DB_FOLDER \
$DB_BACKEND

exit_if_failed $? 

# compute mean value
echo " === Computing mean image === "
${CAFFE_TOOLS_PATH}/compute_image_mean.bin \
-backend $DB_BACKEND \
$DB_FOLDER \
$OUT_PATH/mean.binaryproto

exit_if_failed $? 

#rm $BINARY_DATAFILE


 
