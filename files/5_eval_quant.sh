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
echo "EVALUATING THE QUANTIZED GRAPH.."
echo "-----------------------------------------"
eval_graph ${QUANT} quantize_eval_model.pb 2>&1 | tee ${LOG}/${EVAL_Q_LOG}
echo "-----------------------------------------"
echo "EVALUATION COMPLETED"
echo "-----------------------------------------"