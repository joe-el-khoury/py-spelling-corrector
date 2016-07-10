from distutils.core import setup, Extension
from distutils.command.build import build

from Cython.Build import cythonize

from subprocess import call

class PySpellingCorrectorBuild(build):
    def run(self):
        cmd = "make"
        def compile():
            call(cmd)
        
        self.execute(compile, [], 'Compiling spelling corrector...')

EXT = Extension("Token", sources=["cython-src/PyToken.pyx"], language="c++")

setup(
    name="py-spelling-corrector",
    description="A Python wrapper for a spelling corrector written in C++.",
    author="Joe Khoury",
    ext_modules=cythonize(EXT),
    cmdclass={
        'build': PySpellingCorrectorBuild,
    }
)