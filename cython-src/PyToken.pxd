from libcpp.string cimport string

cdef extern from "../spelling-corrector/src/Token.h":
    cdef cppclass Token:
        Token () except+
        Token (string) except+
        
        const string& get_token_str()