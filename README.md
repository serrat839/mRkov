this is a markov chain twitter package

i am too lazy to write a good readme right now

## Build instructions
(You need the roxygen2 and devtools libraries)
The following code blocks make it easy to construct and test the package quickly

```setwd("C:/Users/thebr/Documents/UW WORK/Stat_499/package")
document()

setwd("C:/Users/thebr/Documents/UW WORK/Stat_499")
install("package")
```
## Bugs
- if prompt is in the corpus, but it only appears within other characters, it will crash. for example, `prompt = navy` but navy only is in the string (navy)
