CATEGORY_NAME='bowling'
#DATA_DIR="$HOME/workspace/OlympicSports/exemplar_cnn"
DATA_DIR="$HOME/caffe_otput" 
LEVELDB_DIR="${DATA_DIR}/${CATEGORY_NAME}_leveldb"

if [ ! -d ${LEVELDB_DIR} ]; then
  echo "ERROR: couldn't find leveldb folder! (${LEVELDB_DIR})"
  exit 1
  #wget http://lmb.informatik.uni-freiburg.de/resources/datasets/exemplarCNN/unlabeled_training_data_STL_leveldb.zip -P ../../data/
  #unzip ../../data/unlabeled_training_data_STL_leveldb.zip ../../data/
fi

sh -x ./train_nn_pretrain_distr.sh 64c5-128c5-256c5-512f $CATEGORY_NAME 8000 1 8000 1200000 0.01 0.004 0.9 128 1