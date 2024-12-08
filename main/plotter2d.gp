set terminal png size 1000,1000
set output 'xyz.png'
plot "output.csv" using 3 with lines
