reset session
file1 = 'potencial.dat'

unset terminal
set size square
set term png size 860,860
set output "EPot_2.png"
set view map
set pm3d at b map
set contour

set cntrparam levels disc 10, -10,\
													9 , -9 ,\
													8 , -8 ,\
													7 , -7 ,\
													6 , -6 ,\
													5 , -5 ,\
													4 , -4 ,\
													3 , -3 ,\
													2 , -2
set cntrlabel onecolor font "7"
unset clabel
set palette defined (-1 'red', 0 'black', 1 'white')

unset logscale cb
set border lw 2
#set cbrange [-10: 10]


set ylabel "{/:=14 y [cm]}"
set xlabel "{/:=14 x [cm]}"
set cblabel "{/:=14 symln(V) [N cm C^{-1}] }"

splot file1 u 2:1:($3 > 0 ? log($3) :-log(abs($3))) lc 'white'
