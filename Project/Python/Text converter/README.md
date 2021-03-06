# TTCPy - Text To Columns Python

This is the Python version of the original TTC package in R. The purpose of the package is to filter strings of non-frequent words and transform it to columns with the frequency of the common words.

The package is not big, the three things to remember, for the moment, is:

- - -

1. The initial process of the class. Give it paramters such as minimum support between a value of 0 and 1. Remember, the lower the `minSup` is, the more time it will take to compute.

```
init = TTC(data, minSup)
```
The parameters:

- `data`: Is the list of strings that you want to transform.
- `minSup`: If the frequency of the word is below this value, then it is filtered out. A value between 0 and 1.

- - -

2. Later you can call the compute function that will compute it with the given data. The output will be a `numpy` array with the frequencies of the words.

```
init.compute()
```
- - -

3. You can also call the words that is the most frequent. These words are in the same order as the output from step 2. The output will be a `numpy` array with the frequent words.

```
init.header
```





--- Updates for package TTCPy ---


- 19/07/2018 - Version 0.2.0
Introduced the `numba` module for some functions. Also took away the dependency of the module `re`.

- 11/07/2018 - Version 0.1.0
Implemented the TTC version from R to Python (TTCPy). There is not option for filtering out specific words as in the R package.
