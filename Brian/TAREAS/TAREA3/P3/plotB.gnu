file1 = 'fort.44'
file2 = 'fort.55'
file3 = 'fort.66'

set border lw 2

set ylabel "{/:=14 u(x, t_f)}"
set xlabel "{/:=14 x}"

plot file1 using 1:2 w l lw 2 lc "black"  title 't_f = 0.05',\
		 file2 using 1:2 w l lw 2 lc "red"    title 't_f = 1.00',\
		 file3 using 1:2 w l lw 2 lc "orange" title 't_f = 5.00',\
