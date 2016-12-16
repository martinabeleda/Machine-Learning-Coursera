# Hackerrank R exercises

## Solve me first

Read 2 inputs from `stdin` and print the sum of these to `stdout`

```R
# The complete code is given. You can just review and submit!
nums <- read.table("/dev/stdin", sep=" ");
nums <- as.list(as.data.frame(t(nums)))
write.table(as.numeric(nums[1])+as.numeric(nums[2]), sep = "", append=T, row.names = F, col.names = F)
```
## Diagonal Difference

```R
# Enter your code here. Read input from STDIN. Print output to STDOUT
nums <- read.table("/dev/stdin", sep=" ", fill = TRUE);

size <- nums[1,1]
nums <- as.data.frame(t(nums[2:(size+1),]))
str(nums)
prim <- 0
sec <- 0

for (i in 1:size) {
    
    prim <- prim + nums[i, i]
    sec <- sec + nums[size+1-i, i]
}

write.table(as.numeric(abs(prim-sec)), sep = "", append=T, row.names = F, col.names = F)
```
