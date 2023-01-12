#!/bin/bash


N=8

for file in ../examples/*.scad;
do
  ((i=i%N)); ((i++==0)) && wait
  echo $(basename "$file" .scad).stl
  openscad "$file" -o $(basename "$file" .scad).stl &
done

echo "Generovani dokonceno"
