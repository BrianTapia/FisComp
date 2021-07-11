reset
file = 'toma7.csv'
set datafile separator ','
fit a*sin(x*b+d)+c file u ($1):($2)  via a,b,c,d
plot file using 1:2 with p,\
a*sin(x*b+d)+c

#file u 3:4 w lp,\

