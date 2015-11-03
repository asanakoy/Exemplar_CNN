DATA_DIR="$HOME/caffe_otput" 
CROPS_DIR=~/workspace/OlympicSports/crops_96x96

categories=( $(find $CROPS_DIR -maxdepth 1 -type d -printf '%P\n') )
n=${#categories[@]}
echo "Categories number: $n"
start=0
batch_size=1
echo "Starting from category ${start}; Taking ${batch_size} categories"

for ((i=start; i< $(( start + batch_size > n ? n : start + batch_size));  i++)); do
    CATEGORY_NAME=${categories[i]}
    LEVELDB_DIR="${DATA_DIR}/${CATEGORY_NAME}_leveldb"

    if [ ! -d ${LEVELDB_DIR} ]; then
        echo "ERROR: couldn't find leveldb folder! (${LEVELDB_DIR})"
        exit 1
    fi
    echo "Training CNN for ${CATEGORY_NAME}..."
    sh -x ./train_nn_pretrain_distr.sh 64c5-128c5-256c5-512f $CATEGORY_NAME 8000 1 8000 1200000 0.01 0.004 0.9 128 1

done
