#! /bin/bash
########################################################################################################################
## Copyright 2021-2022 Datum Technology Corporation
## SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
########################################################################################################################


# Launched from uvma_axis project sim dir
mio sim     uvmt_axis_st -CE
mio sim     uvmt_axis_st -S -t rand_traffic -s 1 -c
mio results uvmt_axis_st results
mio cov     uvmt_axis_st
