cimport PyToken

cdef extern from "../spelling-corrector/src/SpellingCorrector.h":
    cdef extern from "../spelling-corrector/src/Token.h":
        cdef cppclass Token
    
    cdef cppclass SpellingCorrector:
        SpellingCorrector () except+
        Token correct_word (const Token&) except+