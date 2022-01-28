#!/bin/bash
# quantize
quantize() {  
  echo "Making calibration images.." 
  python -u tf_gen_images.py  \
      --dataset=train \
      --image_dir=${QUANT}/images \
      --calib_list=calib_list.txt \
      --max_images=${CALIB_IMAGES}
  # log the quantizer version being used
  vai_q_tensorflow --version
  # quantize
  vai_q_tensorflow quantize \
    --input_frozen_graph ${FREEZE}/${FROZEN_GRAPH} \
		--input_fn           image_input_fn.calib_input \
		--output_dir         ${QUANT} \
	    --input_nodes        ${INPUT_NODE} \
		--output_nodes       ${OUTPUT_NODE} \
		--input_shapes       ${INPUT_SHAPE} \
		--calib_iter         10 \
    --gpu                ${CUDA_VISIBLE_DEVICES}
}
echo "-----------------------------------------"
echo "QUANTIZE STARTED.."
echo "-----------------------------------------"
rm -rf ${QUANT} 
mkdir -p ${QUANT}/images
quantize 2>&1 | tee ${LOG}/${QUANT_LOG}
rm -rf ${QUANT}/images
echo "-----------------------------------------"
echo "QUANTIZE COMPLETED"
echo "-----------------------------------------"