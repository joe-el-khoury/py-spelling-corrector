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

    @staticmethod
    cdef PyToken PyToken_from_Token(self, const Token& convert_from):
        """
        Creates a PyToken object from a token object.
        """
        cdef string token_str = convert_from.get_token_str()
        return PyToken(token_str)

    @staticmethod
    cdef Token Token_from_PyToken(self, convert_from):
        assert type(convert_from) is PyToken, "make sure the second argument is of type PyToken"
        return Token(convert_from.get_str())

    def get_str(self):
        return self.c_token.get_token_str()