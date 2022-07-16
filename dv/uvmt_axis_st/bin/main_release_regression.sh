#! /bin/bash
########################################################################################################################
## Copyright 2021 Datum Technology Corporation
## SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################


# Launched from uvml project sim dir
shopt -s expand_aliases
source ~/.bashrc
mio cpel    uvmt_axis_st
mio sim     uvmt_axis_st -t rand_traffic -s 1 -c
mio results uvmt_axis_st results
mio cov     uvmt_axis_st
