from PyToken cimport Token
from libcpp.string cimport string

cdef extern from "../spelling-corrector/src/SpellingCorrector.h":
    cdef cppclass SpellingCorrector:
        SpellingCorrector () except+

        Token correct_word (const Token&) except+