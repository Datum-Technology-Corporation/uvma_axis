# About
## [Home Page](https://datum-technology-corporation.github.io/uvma_axil/)
The Moore.io Arm® AMBA® IP Suite's Advanced eXtensible Interface (AXI)-Stream UVM Agent is a compact, sequence-based solution to Driving/Monitoring both sides of an AXI-Stream interface.  This project consists of the agent (`uvma_axis_pkg`), the self-testing UVM environment (`uvme_axis_st_pkg`) and the test bench (`uvmt_axis_st_pkg`) to verify the agent against itself.

## IP
* DV
> * uvma_axis
> * uvme_axis_st
> * uvmt_axis_st
* RTL
* Tools


# Simulation
```
cd ./sim
cat ./README.md
./setup_project.py
source ./setup_terminal.sh
export VIVADO=/path/to/vivado/install
dvm --help
clear && dvm all uvmt_axis_st -t rand_traffic -s 1 -w
```
