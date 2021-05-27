file1 = 'EvTemporal_x1.dat'
file2 = 'EvTemporal_x2.dat'

set border lw 2

set ylabel "{/:=14 u(x_i, t)}"
set xlabel "{/:=14 t}"

plot file1 using 1:2 w l lw 2 lc "red"    title 'x_1',\
		 file2 using 1:2 w l lw 2 lc "orange" title 'x_2',\
