PyToken.so : bin/Token.o bin/PyToken.o
	g++ -fPIC -shared -rdynamic bin/PyToken.o bin/Token.o -o bin/PyToken.so

bin/PyToken.o : cython-src/PyToken.cpp cython-src/PyToken.pyx
	g++ -I/usr/include/python2.7 -c -std=c++14 -fPIC -shared -rdynamic \
		cython-src/PyToken.cpp -o bin/PyToken.o

bin/Token.o : spelling-corrector/src/Token.cpp spelling-corrector/src/Token.h
	g++ -std=c++14 -fPIC -shared -rdynamic spelling-corrector/src/Token.cpp -o bin/Token.o