file = 'table.dat'
file2 = 'extrapolations.dat'

set xrange [1978:2010]
set yrange [   0:  30]

set xlabel "{/:=14 Year }"
set ylabel "{/:=14 Empty places %}"

l(x) = a*(x-1990)**2 + b*(x-1990) + c

fit l(x) file via a,b,c

plot file using 1:2 with linespoints pointtype 4 pointsize 1.5 linecolor "red" title 'Table Points',\
     l(x) title 'Polynomial fit (n = 2)',\
     file2 using 1:2 with linespoints pointtype 4 pointsize 1.5 linecolor "orange" title 'Extrapolated Points'
