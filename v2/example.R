## Step 1: Emacs pre-requisites
## Visit the file ess-websocket.el and run M-x eval-buffer

## Step 2: R pre-requisites
require(httpgd)
require(unigd)

essgd_url_and_token <- function() {
  d <- hgd_details()
  s <- sprintf("http://%s:%d--TOKEN--%s\n", d$host, d$port, d$token)
  cat(s)
}

## Step 3: Start the httpgd device.
## I like to provide transparent background.
hgd(bg="transparent")


## Step 4: Start the Emacs interface.
## Do this from an R buffer that has an ess process attached to it.
## e.g. the *R* buffer, or this *R* script.
## M-x essgd-start
## (essgd-start)


## Step 5:  Do some plotting!

curve(1+(x*0), col='blue', main='Plot 1', lwd=4)
curve(1+x, col='green', main='Plot 2', lwd=3)
curve(x^2, col='purple', main='Plot 3', xlim=c(-1,1))
curve(1+x^2+x^3, col='orange', main='Plot 4', xlim=c(-1,1),lwd=2)
plot(rnorm(1000), main='plot 5')
hist(runif(100),col='orange', main='plot6 ')

