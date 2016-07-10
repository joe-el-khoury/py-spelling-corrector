OBJS = bin/Token.o bin/PyToken.o bin/TokenEditor.o bin/PySpellingCorrector.o bin/SpellingCorrector.o \
	bin/Tokenizer.o bin/TokenHistogram.o bin/FileReader.o
CC = g++
CFLAGS = -c -I/usr/include/python2.7 -std=c++14 -fPIC -shared -rdynamic
LFLAGS = -fPIC -shared -rdynamic

# Directories
CYTHONDIR = cython-src
SPELLDIR = spelling-corrector/src

bin/PySpellingCorrector.so : $(OBJS)
	$(info Linking...)
	$(CC) $(LFLAGS) $(OBJS) -o bin/PySpellingCorrector.so

bin/PySpellingCorrector.o : $(CYTHONDIR)/PySpellingCorrector.cpp $(CYTHONDIR)/PySpellingCorrector.pyx
	$(CC) $(CFLAGS) $(CYTHONDIR)/PySpellingCorrector.cpp -o bin/PySpellingCorrector.o

bin/SpellingCorrector.o : $(SPELLDIR)/SpellingCorrector.cpp $(SPELLDIR)/SpellingCorrector.h $(SPELLDIR)/Tokenizer.h $(SPELLDIR)/TokenHistogram.h $(SPELLDIR)/util/FileReader.h
	$(CC) $(CFLAGS) $(SPELLDIR)/SpellingCorrector.cpp -o bin/SpellingCorrector.o

bin/Tokenizer.o : $(SPELLDIR)/Tokenizer.cpp $(SPELLDIR)/Tokenizer.h $(SPELLDIR)/Token.h
	$(CC) $(CFLAGS) $(SPELLDIR)/Tokenizer.cpp -o bin/Tokenizer.o

bin/TokenHistogram.o : $(SPELLDIR)/TokenHistogram.cpp $(SPELLDIR)/TokenHistogram.h $(SPELLDIR)/Token.h
	$(CC) $(CFLAGS) $(SPELLDIR)/TokenHistogram.cpp -o bin/TokenHistogram.o

bin/FileReader.o : $(SPELLDIR)/util/FileReader.cpp $(SPELLDIR)/util/FileReader.h
	$(CC) $(CFLAGS) $(SPELLDIR)/util/FileReader.cpp -o bin/FileReader.o

bin/PyToken.o : $(CYTHONDIR)/PyToken.cpp $(CYTHONDIR)/PyToken.pyx
	$(CC) $(CFLAGS) $(CYTHONDIR)/PyToken.cpp -o bin/PyToken.o

bin/Token.o : $(SPELLDIR)/Token.cpp $(SPELLDIR)/Token.h $(SPELLDIR)/TokenEditor.cpp
	$(CC) $(CFLAGS) $(SPELLDIR)/Token.cpp -o bin/Token.o

bin/TokenEditor.o : $(SPELLDIR)/TokenEditor.cpp $(SPELLDIR)/TokenEditor.h $(SPELLDIR)/Token.h
	$(CC) $(CFLAGS) $(SPELLDIR)/TokenEditor.cpp -o bin/TokenEditor.o

clean:
	rm -rf bin/*