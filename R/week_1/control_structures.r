## if/else
x <- 1
y <- if(x>3) {
  10
} else {
  0
}

## for
for(i in 1:10) {
  print(i)
}

x <- c("a","b","c")
for(i in 1:3) {
  print(x[i])
}

for(i in seq_along(x)) {
  print(x[i])
}

for(letter in x) {
  print(letter)
}

x <- matrix(1:6, 2, 3)
for(i in seq_len(nrow(x))) {
  for(j in seq_len(ncol(x))) {
    print(x[i,j])
  }
}

# while

count <- 0
while(count < 10) {
  print(count)
  count <- count + 1
}

# repeat (usually used in tasks where you are looking for emerging values)
counter <- 10
repeat {
  if(counter == 0) break;
  print(counter)
  counter <- counter - 1;
}

#next
for(i in 1:30) {
  if(i<10) {
    next
  }
  print(i)
}

#functions