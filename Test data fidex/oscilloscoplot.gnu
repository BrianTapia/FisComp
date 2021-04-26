reset
file = 'toma6.csv'
set datafile separator ','
fit a*x+c file u ($1):2 via a,c
set autoscale
plot file using 1:2  with lines,\
a*x+c

#file u 3:4 w lp,\

