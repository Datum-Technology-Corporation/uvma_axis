# About
## [Home Page](https://datum-technology-corporation.github.io/uvma_axis/)
The Moore.io Arm® AMBA® IP Suite's Advanced eXtensible Interface (AXI-Stream) (AXI-S) (AXIS) UVM Agent is a compact, sequence-based solution to Driving/Monitoring both sides of an AXI-Stream interface.  This project consists of the agent (`uvma_axis_pkg`), the self-testing UVM environment (`uvme_axis_st_pkg`) and the test bench (`uvmt_axis_st_pkg`) to verify the agent against itself.

## IP
* DV
> * uvma_axis
> * uvme_axis_st
> * uvmt_axis_st
* RTL
* Tools


# Simulation
**1. Change directory to 'sim'**

This is from where all jobs will be launched.
```
cd ./sim
```

**2. Project Setup**

Only needs to be done once, or when libraries must be updated. This will pull in dependencies from the web.
```
./setup_project.py
```

**3. Terminal Setup**

This must be done per terminal. The script included in this project is for bash:

```
export VIVADO=/path/to/vivado/bin # Set locaton of Vivado installation
source ./setup_terminal.sh
```

**4. Launch**

All jobs for simulation are performed via `dvm`.

> At any time, you can invoke its built-in documentation:

```
dvm --help
```

> To run test 'rand_traffic' with seed '1' and wave capture enabled:


```
clear && dvm all uvmt_axis_st -t rand_traffic -s 1 -w
```
