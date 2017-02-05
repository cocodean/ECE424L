@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.4\\bin
call %xv_path%/xelab  -wto e2b009f0aedb46d2b71bab24592291bd -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot SPI_Interface_test_behav xil_defaultlib.SPI_Interface_test -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
