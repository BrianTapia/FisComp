reset
file = 'toma6.csv'
set datafile separator ','
fit a*sin(x*b+c)+d file u ($1):2 via a,b,c,d
set autoscale
plot file using 1:2  with lines,\
a*sin(x*b+c)+d 

#file u 3:4 w lp,\

