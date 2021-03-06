OBJS = bin/Token.o bin/PyToken.o bin/TokenEditor.o bin/PySpellingCorrector.o bin/SpellingCorrector.o
CC = g++
CFLAGS = -O3 -c -I/usr/include/python2.7 -std=c++14 -fPIC -shared -rdynamic
LFLAGS = -fPIC -shared -rdynamic

.PHONY: directories

all: directories $(OBJS) bin/*.so

directories: bin

bin:
	mkdir bin

# Directories
CYTHONDIR = cython-src
SPELLDIR = spelling-corrector/src

bin/*.so : $(OBJS)
	$(info Linking...)
	$(CC) $(LFLAGS) $(OBJS) -o bin/PyToken.so
	$(CC) $(LFLAGS) $(OBJS) -o bin/PySpellingCorrector.so

bin/PySpellingCorrector.o : $(CYTHONDIR)/PySpellingCorrector.cpp $(CYTHONDIR)/PySpellingCorrector.pyx
	$(CC) $(CFLAGS) $(CYTHONDIR)/PySpellingCorrector.cpp -o bin/PySpellingCorrector.o

bin/SpellingCorrector.o : $(SPELLDIR)/SpellingCorrector.cpp $(SPELLDIR)/SpellingCorrector.h $(SPELLDIR)/Tokenizer.h $(SPELLDIR)/TokenHistogram.h $(SPELLDIR)/util/FileReader.h
	$(CC) $(CFLAGS) $(SPELLDIR)/SpellingCorrector.cpp -o bin/SpellingCorrector.o

bin/PyToken.o : $(CYTHONDIR)/PyToken.cpp $(CYTHONDIR)/PyToken.pyx
	$(CC) $(CFLAGS) $(CYTHONDIR)/PyToken.cpp -o bin/PyToken.o

bin/Token.o : $(SPELLDIR)/Token.cpp $(SPELLDIR)/Token.h $(SPELLDIR)/TokenEditor.cpp
	$(CC) $(CFLAGS) $(SPELLDIR)/Token.cpp -o bin/Token.o

bin/TokenEditor.o : $(SPELLDIR)/TokenEditor.cpp $(SPELLDIR)/TokenEditor.h $(SPELLDIR)/Token.h
	$(CC) $(CFLAGS) $(SPELLDIR)/TokenEditor.cpp -o bin/TokenEditor.o

clean:
	rm -rf bin/*