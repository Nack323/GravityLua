set terminal png size 1000,1000
set xrange [-26000000: 26000000]
set yrange [-26000000: 26000000]
set zrange [-26000000: 26000000]
set output 'xyz.png'
splot "output.csv" using 1:2:3 with lines
