#!/bin/bash
# evaluate graph with test dataset
eval_graph() {
  dir_name=$1
  graph=$2
  python -u eval_graph.py \
    --graph        $dir_name/$graph \
    --input_node   ${INPUT_NODE} \
    --output_node  ${OUTPUT_NODE} \
    --batchsize    ${BATCHSIZE} \
    --gpu          ${CUDA_VISIBLE_DEVICES}
}
echo "-----------------------------------------"
echo "EVALUATING THE FROZEN GRAPH.."
echo "-----------------------------------------"
eval_graph ${FREEZE} ${FROZEN_GRAPH} 2>&1 | tee ${LOG}/${EVAL_FR_LOG}
echo "-----------------------------------------"
echo "EVALUATION COMPLETED"
echo "-----------------------------------------"