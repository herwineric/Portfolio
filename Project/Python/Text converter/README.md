# TTCPy - Text To Columns Python

This is the Python version of the original TTC package in R. The purpose of the package is to filter strings of non-frequent words and transform it to columns with the frequency if the the common words.

The package is not big, the three things to remember, at the moment, is:

1. The initial process of the class. Give it paramters such as minimum support between a value of 0 and 1. Remember, the lower the `minSup` is, the more time it will take to compute.

```
init = TTC(minSup)
```

2. Later you can call the compute function that will compute it with the given data. The output will be a `numpy` array.

```
init.compute(data)
```

3. You can also call the words that is the most frequent. These words are in the same order as the output from step 2.

```
init.header
```

