# you need to copy convert_binary_data.cpp to caffe tools path and compile caffe

run_convert()
{
    DATA_DIR=~/workspace/OlympicSports/exemplar_cnn
    CATEGORY_NAME=$1
    TRAIN_DATA_PATH="${DATA_DIR}/training_data_8000_${CATEGORY_NAME}.mat"

    if [ ! -f $TRAIN_DATA_PATH ]; then
      echo "ERROR: no data found!(${TRAIN_DATA_PATH})"
      exit 1
    fi

    #LEVELDB_DIR="${DATA_DIR}/${CATEGORY_NAME}_leveldb"
    LEVELDB_DIR=~/caffe_otput/${CATEGORY_NAME}_leveldb # use local, as we cannot write from boris to hci
    mkdir -p "${LEVELDB_DIR}/8000"

    sh -x convert_data.sh $TRAIN_DATA_PATH "${LEVELDB_DIR}/8000" leveldb randomize
}

#CATEGORY_NAME='basketball_layup'
#run_convert $CATEGORY_NAME

CROPS_DIR=~/workspace/OlympicSports/crops_96x96
for category_path in $CROPS_DIR/*; do
    if [[ -d $category_path ]]; then
        CATEGORY_NAME=$(basename $category_path)
        run_convert $CATEGORY_NAME
    fi
done







 
