#!/bin/bash

#PWD="$(pwd)"
#cd ..
#cd ..
BASE_DIR="$(pwd)"
ARDUPI_DIR="$BASE_DIR/arduPi"
ARDUPIAPI_DIR="$BASE_DIR/cooking-api"
EXAMPLES_DIR="$BASE_DIR/Ejemplos-LoraWAN"
LIBRARY_DIR="$BASE_DIR/arduPiLoRaWAN"

#compile arduPi
cd "$ARDUPI_DIR"
file="./arduPi.o"
if [ -e $file ]; then
  if [ "$1" == "-clean" ]; then
    echo "arduPi.o -> purged"
    rm ./arduPi.o
  else
    echo "arduPi already compiled"
  fi
else 
  if [ "$1" != "-clean" ]; then
    echo "Compiling arduPi..."
	echo "ARDUPIDIR is $ARDUPI_DIR"
    g++ -c arduPi.cpp -l $ARDUPI_DIR -o arduPi.o
  fi
fi 

#compile arduPi-api
cd "$ARDUPIAPI_DIR"
file="./arduPiUART.o"
if [ -e $file ]; then
  if [ "$1" == "-clean" ]; then
    echo "arduPiUART.o -> purged"
    rm ./arduPiUART.o
  else
	echo "arduPiUART already compiled"
  fi
else 
  if [ "$1" != "-clean" ]; then
	echo "Compiling arduPiUART..."
 echo "ARDUPIDIR is $ARDUPI_DIR"

    g++ -c arduPiUART.cpp -I $ARDUPI_DIR -o arduPiUART.o
  fi
fi 

file="./arduPiUtils.o"
if [ -e $file ]; then
  if [ "$1" == "-clean" ]; then
    echo "arduPiUtils.o -> purged"
    rm ./arduPiUtils.o
  else
	echo "arduPiUtils already compiled"
  fi
else 
  if [ "$1" != "-clean" ]; then
	echo "Compiling arduPiUtils..."
    g++ -c arduPiUtils.cpp -I $ARDUPI_DIR -o arduPiUtils.o
  fi
fi 
: ' Not used?
file="./arduPiMultiprotocol.o"
if [ -e $file ]; then
  if [ "$1" == "-clean" ]; then
    echo "arduPiMultiprotocol.o -> purged"
    rm ./arduPiMultiprotocol.o
  else
	echo "arduPiMultiprotocol already compiled"
  fi
else 
  if [ "$1" != "-clean" ]; then
	echo "Compiling arduPiMultiprotocol..."
    g++ -c arduPiMultiprotocol.cpp -I $ARDUPI_DIR -o arduPiMultiprotocol.o
  fi
fi 
'
#compile library
cd "$LIBRARY_DIR"
file="./arduPiLoRaWAN.o"
if [ -e $file ]; then
  if [ "$1" == "-clean" ]; then
    echo "arduPiLoRaWAN.o -> purged"
    rm ./arduPiCAN.o
  else
	echo "arduPiLoRaWAN already compiled"
  fi
else 
  if [ "$1" != "-clean" ]; then
	echo "Compiling arduPiLoRaWAN..."
    g++ -c arduPiLoRaWAN.cpp -I $ARDUPI_DIR -I $ARDUPIAPI_DIR -o arduPiLoRaWAN.o 
  fi
fi 

sleep 1


#compile example
cd "$EXAMPLES_DIR"
file="./$1"

if [ "$1" != "-clean" ]; then
  if [ -e $file ]; then
    if [ "$1" != "" ]; then
    echo "Compiling Example..."
       
    g++ -lrt -lpthread -lstdc++ "$1" \
      "$LIBRARY_DIR/arduPiLoRaWAN.o" \
      "$ARDUPIAPI_DIR/arduPiUART.o" \
      "$ARDUPIAPI_DIR/arduPiUtils.o" \
     # "$ARDUPIAPI_DIR/arduPiMultiprotocol.o" \
      "$ARDUPI_DIR/arduPi.o" \
      -I"$ARDUPI_DIR" \
      -I"$ARDUPIAPI_DIR" \
      -I"$LIBRARY_DIR" \
      -o "$1_exe" 
    else
      echo "---------------HELP------------------"
      echo "Modifyed by Nicholas Swiatecki"
	echo "based on the files in LoRaWAN_library_ardupi_v1_0"
	echo "copy the ardupi.cpp ardupi.h to the /arduPi folder"
      echo "Compiling: ./cookNS filetocompile.cpp"
      echo "Cleaning:  ./cookNS -clean"
      echo "-------------------------------------"
    fi
  else
    echo "ERROR No such file or directory: $file"
  fi
else
  echo "Cocina limpia :-) (The kitchen is clean)"
fi
 
sleep 1

exit 0


