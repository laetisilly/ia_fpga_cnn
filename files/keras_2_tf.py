import os
import argparse
# Silence TensorFlow messages
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'
import tensorflow as tf
from tensorflow.keras import backend
from tensorflow.keras.models import model_from_json, load_model

def keras_convert(keras_json,keras_hdf5,tf_ckpt)

    ##############################################
    # load the saved Keras model
    ##############################################
    # set learning phase for no training
    backend.set_learning_phase(0)
    # if name of JSON file provided as command line argument, load from 
    # arg.keras_json and args.keras_hdf5.
    # if JSON not provided, assume complete model is in HDF5 format
    if (keras_json != ''):
        json_file = open(keras_json, 'r')
        loaded_model_json = json_file.read()
        json_file.close()
        loaded_model = model_from_json(loaded_model_json)
        loaded_model.load_weights(keras_hdf5)
    else:
        loaded_model = load_model(keras_hdf5)
		
    ##############################################
    # Create TensorFlow checkpoint & inference graph
    ##############################################
    print ('Keras model information:')
    print (' Input names :',loaded_model.inputs)
    print (' Output names:',loaded_model.outputs)
    print('-------------------------------------')

    # fetch the tensorflow session using the Keras backend
    tf_session = backend.get_session()

    # write out tensorflow checkpoint & meta graph
    saver = tf.compat.v1.train.Saver()
    save_path = saver.save(tf_session,tf_ckpt)
    print (' Checkpoint created :',tf_ckpt)
    return

def run_main():
    # command line arguments
    ap = argparse.ArgumentParser()
    ap.add_argument('-kj', '--keras_json',
                    type=str,
                    default='',
    	            help='path of Keras JSON. Default is empty string to indicate no JSON file')
    ap.add_argument('-kh', '--keras_hdf5',
                    type=str,
                    default='./model.hdf5',
    	            help='path of Keras HDF5. Default is ./model.hdf5')
    ap.add_argument('-tf', '--tf_ckpt',
                    type=str,
                    default='./tf_float.ckpt',
    	            help='path of TensorFlow checkpoint. Default is ./tf_float.ckpt')           
    args = ap.parse_args()

    print('-------------------------------------')
    print('keras_2_tf command line arguments:')
    print(' --keras_json:', args.keras_json)
    print(' --keras_hdf5:', args.keras_hdf5)
    print(' --tf_ckpt   :', args.tf_ckpt)
    print('-------------------------------------')
    keras_convert(args.keras_json,args.keras_hdf5,args.tf_ckpt)
if __name__ == '__main__':
    run_main()