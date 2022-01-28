#!/bin/bash
if [ $1 = zcu102 ]; then
      ARCH=/opt/vitis_ai/compiler/arch/DPUCZDX8G/ZCU102/arch.json
      DIR=zcu102
      echo "-----------------------------------------"
      echo "COMPILING MODEL FOR ZCU102.."
      echo "-----------------------------------------"
elif [ $1 = u50 ]; then
      ARCH=/opt/vitis_ai/compiler/arch/DPUCAHX8H/U50/arch.json
      DIR=u50
      echo "-----------------------------------------"
      echo "COMPILING MODEL FOR ALVEO U50.."
      echo "-----------------------------------------"
elif [ $1 = vck190 ]; then
      ARCH=/opt/vitis_ai/compiler/arch/DPUCVDX8G/VCK190/arch.json
      DIR=vck190
      echo "-----------------------------------------"
      echo "COMPILING MODEL FOR VERSAL VCK190.."
      echo "-----------------------------------------"
elif [ $1 = ultra96v2 ]; then
      ARCH=/opt/vitis_ai/compiler/arch/DPUCVDX8G/VCK190/arch.json
      DIR=ultra96v2
      echo "-----------------------------------------"
      echo "COMPILING MODEL FOR ultra96v2.."
      echo "-----------------------------------------"
else
      echo  "Target not found. Valid choices are: zcu102, u50, vck190, ultra96v2 ..exiting"
      exit 1
fi
compile() {
  vai_c_tensorflow \
    --frozen_pb  ${QUANT}/quantize_eval_model.pb \
    --arch       $ARCH \
    --output_dir ${BUILD}/compile_${DIR} \
    --net_name   ${NET_NAME}
}
rm -rf ${BUILD}/compile_${DIR} 
mkdir -p ${BUILD}/compile_${DIR} 
compile 2>&1 | tee ${LOG}/compile_${DIR}.log