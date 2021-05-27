reset session
file1 = 'potencial.dat'

set size square
set term png size 860,860
set output "EPot_1.png"

set view map
set pm3d at b map
set contour

stats file1 using 3
set cntrlabel onecolor
set cntrparam levels disc log(STATS_min*1),\
													log(STATS_min*1.2),\
													log(STATS_min*1.4),\
													log(STATS_min*1.6),\
													log(STATS_min*1.8),\
													log(STATS_min*2),\
													log(STATS_min*2.2),\
													log(STATS_min*2.4),\
													log(STATS_min*2.6),\
													log(STATS_min*2.8),\
													log(STATS_min*3),\
													log(STATS_min*3.2),\
													log(STATS_min*3.4),\
													log(STATS_min*3.6),\
													log(STATS_min*3.8),\
													log(STATS_min*4),\
													log(STATS_min*5),\
													log(STATS_min*7)

unset clabel
set palette defined (-1 'black', 0 'red', 1 'white')

unset logscale cb
set border lw 2

set ylabel "{/:=14 y [cm]}"
set xlabel "{/:=14 x [cm]}"
set cblabel "{/:=14 ln(V) [N cm C^{-1}] }"

splot file1 u 2:1:(log($3)) lc 'white'
