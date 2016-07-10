# distutils: language = c++
# distutils: sources = spelling-corrector/src/SpellingCorrector.cpp

cdef extern from "../spelling-corrector/src/SpellingCorrector.h":
    cdef cppclass SpellingCorrector:
        pass