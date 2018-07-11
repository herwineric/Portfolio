from setuptools import setup

with open("README.md", "r") as fh:
    long_description = fh.read()

setup(
    name='TTCPy',
    version="0.1.1",
    author='Eric Herwin',
    author_email = 'herwineric@gmail.com',
    long_description=long_description,
    long_description_content_type="text/markdown",
    url= "https://github.com/herwineric/Portfolio",
    license='MIT',
    install_requires=['numpy'],
    python_requires='>=3',
    classifiers=(
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ),
)
