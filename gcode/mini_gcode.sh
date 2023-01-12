#!/bin/bash


PS=prusa-slicer
#PS=/home/roman/Aplications/PrusaSlicer-2.5.0+linux-x64-GTK3-202209060725.AppImage

N=8

for file in ../stl/*.stl;
do
  ((i=i%N)); ((i++==0)) && wait
  echo $file
  $PS --load config_mini_PrusaSlicer.ini "$file" --export-gcode -o mini/$(basename "$file" .stl).gcode &
done

echo "Generovani dokonceno"

