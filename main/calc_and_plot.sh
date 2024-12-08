echo 'running lua'
lua grav.lua > output.csv
echo 'started plotting'
gnuplot -c plotter.gp



