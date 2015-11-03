DATA_DIR="$HOME/caffe_otput" 
LEVELDB_DIR="${DATA_DIR}/${CATEGORY_NAME}_leveldb"
CROPS_DIR=~/workspace/OlympicSports/crops_96x96

for category_path in $CROPS_DIR/*; do
    if [[ -d $category_path ]]; then
        CATEGORY_NAME=$(basename $category_path)
        if [ ! -d ${LEVELDB_DIR} ]; then
            echo "ERROR: couldn't find leveldb folder! (${LEVELDB_DIR})"
            exit 1
        fi
        sh ./train_nn_pretrain_distr.sh 64c5-128c5-256c5-512f $CATEGORY_NAME 8000 1 8000 1200000 0.01 0.004 0.9 128 1
    fi
done
