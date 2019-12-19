Source of dataset:
=================

	Source:
		https://github.com/uchidalab/book-dataset
	Download link: 
		https://drive.google.com/a/human.ait.kyushu-u.ac.jp/file/d/1LVWYXn2WdF-7NuLbl_LyyEwXSvIJUdPr/view?usp=sharing
	Usage: 
		Used first 700 images (alphabetically ordered) = 500 in training + 200 in validation
		
Modifications:
=============

train.ipynb:

- model.add(Dense(1))
+ model.add(Dense(3))
# To specify three outputs(cat, dog, book).  It is dimensionality of the output space.  Number of columns we acqurie on the last dense layer is the number of outputs we specify in Dense() function.
# There will be 3 rows or columns instead of 1, in weights.h5 file under bias and kernel.

- model.add(Activation('sigmoid'))
+ model.add(Activation('softmax'))
# One-hot encoding creates three output features.  Softmax is multi-class sigmoid.
# In general, we use softmax for multi-classification task, while sigmod is used for binary-classification task.
# The sum of all softmax units is one. In case of sigmoid, it's not a requirement.

- model.compile(loss='binary_crossentropy',
+ model.compile(loss='categorical_crossentropy',
# These both are loss functions for last-layer where for binary classification(cat vs dog) sigmoid last-layer activation sigmoid is used with 'binary_crossentropy'.
# For multi-class, single-label classification we use softmax last-layer activation along with categorical_crossentropy loss function.  This applicable only when the classes are mutually-exclusive.
# In later, targets are encoded as one-hot vectors, whereas in former it has scalar targets.

- class_mode='binary')
+ class_mode='categorical')
# As per Keras documentation, 'binary' is used for 1D array of binary labels.
# 'categorical' supports multi-label output(cat, dog, books) and used for 2D array of one-hot encoded labels, which is the case here for (cat, dog, books).  One-hot encoded for books = [0, 0, 1]

- class_mode='binary')
+ class_mode='categorical')
# Same explanation as above for validation_generator.

classify.ipynb:

# Same first 3 changes as train.ipynb:

+ result = numpy.argmax(result)
# The above is so that [1 0 0] gets output as 0 (first class), [0 1 0] gets output as 1 (second class), and [0 0 1], as 2.