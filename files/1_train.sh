#!/bin/bash
# train, evaluate and save trained keras model
train() {
  python -u train.py \
    --input_height ${INPUT_HEIGHT} \
    --input_width  ${INPUT_WIDTH} \
    --input_chan   ${INPUT_CHAN} \
    --epochs       ${EPOCHS} \
    --learnrate    ${LEARNRATE} \
    --batchsize    ${BATCHSIZE} \
    --tboard       ${TB_LOG} \
    --keras_hdf5   ${KERAS}/${K_MODEL} \
    --gpu          ${CUDA_VISIBLE_DEVICES}
}
echo "-----------------------------------------"
echo "TRAINING STARTED"
echo "-----------------------------------------"
rm -rf ${KERAS}
mkdir -p ${KERAS}
train 2>&1 | tee ${LOG}/${TRAIN_LOG}
echo "-----------------------------------------"
echo "TRAINING FINISHED"
echo "-----------------------------------------"