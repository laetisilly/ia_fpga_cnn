#!/bin/bash
source 0_setenv.sh
# training
source 1_train.sh
# convert Keras model to Tensorflow frozen graph
source 2_keras2tf.sh
# Evaluate frozen graph
source 3_eval_frozen.sh
# Quantize
source 4_quant.sh
# Evaluate quantized model
source 5_eval_quant.sh
# compile for target
source 6_compile.sh zcu102
source 6_compile.sh vck190
source 6_compile.sh u50
# make target folders
source 7_make_target.sh zcu102
source 7_make_target.sh vck190
source 7_make_target.sh u50