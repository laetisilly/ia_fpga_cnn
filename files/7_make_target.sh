#!/bin/bash
if [ $1 = zcu102 ]; then
      DIR=zcu102
      echo "-----------------------------------------"
      echo "MAKING TARGET FOR ZCU102.."
      echo "-----------------------------------------"
elif [ $1 = u50 ]; then
      DIR=u50
      echo "-----------------------------------------"
      echo "MAKING TARGET FOR ALVEO U50.."
      echo "-----------------------------------------"
elif [ $1 = vck190 ]; then
      DIR=vck190
      echo "-----------------------------------------"
      echo "MAKING TARGET FOR VERSAL VCK190.."
      echo "-----------------------------------------"
elif [ $1 = ultra96v2 ]; then
      DIR=ultra96v2
      echo "-----------------------------------------"
      echo "MAKING TARGET FOR ultra96v2.."
      echo "-----------------------------------------"
else
      echo  "Target not found. Valid choices are: zcu102, u50, vck190 ..exiting"
      exit 1
fi
# remove previous results
rm -rf ${BUILD}/target_${DIR} 
mkdir -p ${BUILD}/target_${DIR}
mkdir -p ${BUILD}/target_${DIR}/model_dir

# copy application to target folder
cp ${APP}/*.py ${BUILD}/target_${DIR}/.
echo "  Copied python application to target folder"

# copy xmodel to target folder
cp ${BUILD}/compile_${DIR}/${NET_NAME}.xmodel ${BUILD}/target_${DIR}/model_dir/.
echo "  Copied xmodel file(s) to target folder"

mkdir -p ${BUILD}/target_${DIR}/images

python -u tf_gen_images.py  \
    --dataset=test \
    --image_dir=${BUILD}/target_${DIR}/images \
    --max_images=10000

echo "  Copied images to target folder"
echo "-----------------------------------------"
echo "MAKE TARGET COMPLETED"
echo "-----------------------------------------"