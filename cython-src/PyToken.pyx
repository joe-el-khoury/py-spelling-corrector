# distutils: language = c++
# distutils: sources = spelling-corrector/src/Token.cpp

from PyToken cimport PyToken
from libcpp.string cimport string

cdef class PyToken:
    cdef Token* c_token
    def __init__(self, string _token_str):
        self.c_token = new Token(_token_str)

    def __dealloc__(self):
        del self.c_token

    def get_str(self):
        return self.c_token.get_token_str()