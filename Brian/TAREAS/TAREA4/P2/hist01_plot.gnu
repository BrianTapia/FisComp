reset session
f  = 'hist01.dat'
ff = 'l01.dat'

set xrange [0:1.0]
#set output "P2_A1.png"
set border lw 2
set logscale y

Min = 0.0 # where binning starts
Max = 1.0 # where binning ends
n   = 20     # the number of bins
width = (Max-Min)/n # binwidth; evaluates to 1.0
bin(x) = width*(floor((x-Min)/width)+0.5) + Min

lgeneric(x) = (1/lambda)*exp(-(x)/lambda)
fit lgeneric(x) f via lambda

stats ff u 2

plot f using 1:2 with points,\
		 lgeneric(x) title 'fit',\
		 ff using (bin($2)):(1./(STATS_records*width)) smooth freq with points
