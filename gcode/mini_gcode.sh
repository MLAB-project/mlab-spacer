#!/bin/bash


for file in ../stl/*.stl;
do
  prusa-slicer --load config_mini_PrusaSlicer.ini "$file" --export-gcode -o mini/$(basename "$file" .stl).gcode
done

