file = 'table2.dat'

set xrange [1978:2010]
set yrange [   0:  30]

set xlabel "{/:=14 Year }"
set ylabel "{/:=14 Empty places %}"

l(x) = a*(x-1990)**3 + b*(x-1990)**2 + c*(x-1990) + d

fit l(x) file via a,b,c,d

plot file using 1:2 with linespoints pointtype 4 pointsize 1.5 linecolor "red" title 'Table Points',\
     l(x) title 'Polynomial fit (n = 3)'
     
