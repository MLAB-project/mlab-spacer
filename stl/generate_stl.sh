#!/bin/bash


for file in ../examples/*.scad;
do
  echo $(basename "$file" .scad).stl
  openscad-nightly "$file" -o $(basename "$file" .scad).stl
done
