from distutils.core import setup, Extension
from distutils.command.build import build

from Cython.Build import cythonize

from subprocess import call

class PySpellingCorrectorBuild(build):
    def run(self):
        cmd = "make"
        def build():
            call(cmd)
        
        self.execute(build, [], 'Compiling spelling corrector...')

Extensions = [
    Extension("Token", sources=["cython-src/PyToken.pyx"], language="c++"),
    Extension("SpellingCorrector", sources=["cython-src/PySpellingCorrector.pyx"], language="c++")
]

setup(
    name="py-spelling-corrector",
    description="A Python wrapper for a spelling corrector written in C++.",
    author="Joe Khoury",
    ext_modules=cythonize(Extensions),
    cmdclass={
        'build': PySpellingCorrectorBuild,
    }
)