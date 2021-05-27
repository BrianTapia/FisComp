reset session
file = 'L1200.dat'

set size square
set term png size 860,860
set output "Pot_1_200.png"

set pm3d at bss

set ylabel "{/:=14 y [A. U.]}"
set xlabel "{/:=14 x [A. U.]}"
set zlabel "{/:=14 V [A. U.]}"

set palette defined (-1 'black', 0 'red', 1 '#E5E5E5')
splot file u 1:2:3 w pm3d
