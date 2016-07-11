# distutils: language = c++
# distutils: sources = spelling-corrector/src/SpellingCorrector.cpp

cimport PySpellingCorrector
from PyToken import *
from types import * # to check for types

cdef class PySpellingCorrector:
    cdef SpellingCorrector* c_spc
    def __init__(self):
        self.c_spc = new SpellingCorrector()

    def __dealloc__(self):
        del self.c_spc

    def train(self, file_name):
        assert type(file_name) is StringType
        self.c_spc.train(file_name)

    cdef Token Token_from_PyToken(self, convert_from):
        """
        Creates a Token object from a PyToken object.
        """
        assert type(convert_from) is PyToken
        return Token(convert_from.get_str())

    def correct_word(self, PyToken_to_correct):
        assert type(PyToken_to_correct) is PyToken
        
        cdef Token token_to_correct = self.Token_from_PyToken(PyToken_to_correct)
        cdef Token corrected_token  = self.c_spc.correct_word(token_to_correct)
        corrected_str = corrected_token.get_token_str()
        
        # Create a PyToken with the corrected string.
        ret = PyToken(corrected_str)
        return ret