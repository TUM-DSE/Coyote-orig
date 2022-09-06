
# Compile Coyote Shell
```
cd Coyote/hw/
mkdir build && cd build
cmake .. -DFDEV_NAME=u50 -DEXAMPLE=bmark_fpga
make shell
make compile
```

# Program FPGA with Coyote Shell

Use vivado to write the bitstream located in `Coyote/hw/build/bitstreams/top.bit`.


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
```
cd Coyote/sw/example/bmark_fpga
mkdir build && cd build
make
```

# Run the example
```
sudo ./main
```
