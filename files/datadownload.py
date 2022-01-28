import numpy as np
import os
# Silence TensorFlow messages
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'
import tensorflow as tf

def datadownload():

    # CIFAR10 dataset has 60k images. Training set is 50k, test set is 10k.
    # Each image is 32x32x8bits
    (x_train, y_train), (x_test, y_test) = tf.keras.datasets.cifar10.load_data()
    # Scale image data from range 0:255 to range 0:1.0
    # Also converts train & test data to float from uint8
    x_train = (x_train/255.0).astype(np.float32)
    x_test = (x_test/255.0).astype(np.float32)
    # one-hot encode the labels
    y_train = tf.keras.utils.to_categorical(y_train, num_classes=10)
    y_test = tf.keras.utils.to_categorical(y_test, num_classes=10)
    return (x_train,y_train), (x_test,y_test)