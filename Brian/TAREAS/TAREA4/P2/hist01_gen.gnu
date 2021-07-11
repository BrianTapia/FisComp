reset session
f = 'l01.dat'

set xrange [0:1.0]
#set output "P2_A1.png"
set border lw 2

Min = 0.0 # where binning starts
Max = 1.0 # where binning ends
n   = 20     # the number of bins
width = (Max-Min)/n # binwidth; evaluates to 1.0
bin(x) = width*(floor((x-Min)/width)+0.5) + Min

stats f u 3

# First plot using points
set style data points
set table 'hist01.dat'
plot [0:5][0:*] f using (bin($3)):(1./(STATS_records*width)) smooth freq with points
unset table
