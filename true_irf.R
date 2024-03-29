if (DATA_TYPE=="2PL"){
  irfs = matrix(0, nrow=length(xs[idx]), ncol=1)
  irfs[,1] = alpha[j,h] + beta[j,h] * xs[idx]
}else{
  library(MASS)
  library(dplyr)
  K = SEKernel(anchor_xs[j,,h], sigma=SIGMA)
  K = K + diag(1e-6, NUM_ANCHOR,NUM_ANCHOR)
  inv_K = ginv(K)
  K1 = matrix(0, nrow=length(xs[idx]), ncol=NUM_ANCHOR)
  for ( i in 1:length(xs[idx]) ) {
    K1[i,] = dnorm(xs[idx][i]-anchor_xs[j,,h], sd=SIGMA)/dnorm(0, sd=SIGMA)
  }
  irfs = K1 %*% inv_K %*% (anchor_ys[j,,h])
}

