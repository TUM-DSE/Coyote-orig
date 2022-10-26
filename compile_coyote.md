
# Change Coyote commit

To change to a specific commit, such as `c7e475e`, run the following command. 

```
cd Coyote
git checkout c7e475e
```
We are currently not using any specifi commit but just the latest one.  

# Compile Coyote Shell
```
cd Coyote/hw/
mkdir build && cd build
cmake .. -DFDEV_NAME=u50 -DEXAMPLE=bmark_fpga
make shell
make compile
```

# Program FPGA with Coyote Shell

Use vivado to write the bitstream located in `Coyote/hw/build/bitstreams/cyt_top.bit`. This is required if the server is rebooted.

A tcl script can be used to streamline this process. An example is shown below. 
```
open_hw_manager
connect_hw_server -allow_non_jtag
open_hw_target

set Device [lindex [get_hw_devices] 0]
current_hw_device $Device
refresh_hw_device -update_hw_probes false $Device
set_property PROBES.FILE {} $Device
set_property FULL_PROBES.FILE {} $Device
set_property PROGRAM.FILE {/home/jiyang/Coyote_new/hw/build/bitstreams/cyt_top.bit} $Device

program_hw_devices $Device
refresh_hw_device $Device
```

Make sure to change the PROGRAM.FILE parameter for the target bitstream. Use `vivado -mode tcl -source program_fpga.tcl` to launch the script. This script should work on system with only one FPGA card. 


# Compile Coyote driver

```
cd driver && make
sudo insmod coyote_drv.ko
```

This step might stuck, in this case a hard reset is needed. 

One can also try this command before running the `insmod`:
```
sudo ./util/hot_reset.sh b3:00.0
```
where `b3:00.0` is the fpga device id from `lspci -v`.

# Compile example host code

For newer commits (after Oct 17th),

```
cd Coyote
mkdir build_bmark_fpga_sw && cd build_bmark_fpga_sw
/usr/bin/cmake ../sw/ -DTARGET_DIR=../sw/examples/bmark_fpga
make
```

For older commits (before Oct 17th),

```
cd Coyote/sw/example/bmark_fpga
mkdir build && cd build
make
```

# Run the example
```
sudo ./main
```
