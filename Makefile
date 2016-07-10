OBJS = bin/Token.o bin/PyToken.o bin/TokenEditor.o
CC = g++
CFLAGS = -c -I/usr/include/python2.7 -std=c++14 -fPIC -shared -rdynamic
LFLAGS = -fPIC -shared -rdynamic

# Directories
CYTHONDIR = cython-src
SPELLDIR = spelling-corrector/src

PyToken.so : $(OBJS)
	$(info Linking...)
	$(CC) $(LFLAGS) $(OBJS) -o bin/PyToken.so

bin/PyToken.o : $(CYTHONDIR)/PyToken.cpp $(CYTHONDIR)/PyToken.pyx
	$(CC) $(CFLAGS) $(CYTHONDIR)/PyToken.cpp -o bin/PyToken.o

bin/Token.o : $(SPELLDIR)/Token.cpp $(SPELLDIR)/Token.h $(SPELLDIR)/TokenEditor.cpp
	$(CC) $(CFLAGS) $(SPELLDIR)/Token.cpp -o bin/Token.o

bin/TokenEditor.o : $(SPELLDIR)/TokenEditor.cpp $(SPELLDIR)/TokenEditor.h $(SPELLDIR)/Token.h
	$(CC) $(CFLAGS) $(SPELLDIR)/TokenEditor.cpp -o bin/TokenEditor.o

clean:
	rm -rf bin/*