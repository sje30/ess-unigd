
## Step 1 - start the httpgd() process and launch a hgd() device,
## This can be done from Emacs with M-x ess-unigd-start
## which also starts the *unigd-watcher* comint process to periodically
## poll for changes in the plots.
require(httpgd)
hgd(port=5900, token=FALSE)

## Step 2 - start plotting.

plot(runif(100), pch=20, main="100 points")

plot(runif(100), pch=20, col='red', main="plot 3")

plot(rnorm(100), pch=20, col='blue', main="plot 4")

## When you kill the latest.svg buffer, the comint buffer is also killed.





