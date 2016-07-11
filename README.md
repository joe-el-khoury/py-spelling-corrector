# py-spelling-corrector
Python wrapper for the C++ [spelling corrector](https://github.com/joe-el-khoury/spelling-corrector).

This has only been tested on **Python 2.7** so far.

###Steps to build/install:

* Clone the repository:

HTTPS:
```
$ git clone --recursive https://github.com/joe-el-khoury/py-spelling-corrector.git
```

SSH:
```
$ git clone --recursive git@github.com:joe-el-khoury/py-spelling-corrector.git
```

* Build the repository:

First, create a `bin` folder:
```
$ mkdir bin
```

Now, build the project:
```
$ python setup.py build
```
`setup.py` will build the project and put all the `.o` and `.so` files in the `bin` folder.

To make sure everything works:
```
$ cd bin
$ python
>>> from PyToken import PyToken
>>> from PySpellingCorrector import PySpellingCorrector
```
Obviously, this should not throw any errors. If it does, please open an issue here and I will look into it.

* Install the modules (optional)

Just do:
```
$ python setup.py install
```
