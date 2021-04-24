file = 'freep1___e0_1.dat'

set yrange [-1:12]

set title "{/:=14 e = 0.1}"

set xlabel "{/:=14 Time [s] }"
set ylabel "{/:=14 Height [m]}"

plot file using 2:3 with linespoints pointtype 7 pointsize 1 linecolor "red" title 'Table Points'
