# distutils: language = c++
# distutils: sources = spelling-corrector/src/SpellingCorrector.cpp

cimport PySpellingCorrector
from types import * # to check for types

cdef class PySpellingCorrector:
    cdef SpellingCorrector* c_spc
    def __init__(self):
        self.c_spc = new SpellingCorrector()

    def __dealloc__(self):
        del self.c_spc

    def train(self, file_name):
        assert type(file_name) is StringType, "file_name should be a string"
        self.c_spc.train(file_name)