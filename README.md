# FAST-OpenBox_S4-impl
### What are these files?

This is a FAST implementation on OpenBox S4 (using Xilinx zynq 7000 SoC). Learn more about FAST from [here](http://www.fastswitch.org).

- fast-sw/: contains the software components of FAST framework.
- platform/: contains a embedded OS and necessary file systems for PS part of Zynq board, and also bitstream that is used to program the PL part.
- fast-hw/: contains the hardware components of FAST framework. This is a complete and runnable vivado project to reduce users' workload to develop their PL logics based FAST.



### How to run the built-in applications?

Necessary steps in order to run FAST on a OpenBox S4:

1. override the TF card with the whole files in `platform/`.
2. switch on the device, connect the PS to a PC using whether an ethernet port or serial port. 
3. `cd` to `/mnt/` and execute `l2switch`.
4. connect two PCs (within the same port) using two random ports on the box.
5. If the PCs can communicate with each other, congrets that you can run the built-in apps now!

**Note**: after the above procedures are finished, you will be able to run all the apps in the `/mnt/fast/` directory. 



### How to develop my own network prototype based on FAST?

FAST provides users with clear and understandable programming abstractions both on software and hardware. learn more from our [paper]() or [FAST white paper](). Be noted that FAST white paper now are written in Chinese, we hope to make the English version to the community ASAP. 

#### Write your own hardware code using FAST libs 

users are able to create their own apps using FAST API. To write yourown code:

1. `cd` to `fast-sw/app/`, create your own directory using `mkdir`.

2. create a blank c file, `include` FAST headers at the beginning.

3. write your own code, etc., a load balancer, a firewall, a packet generator...

4. exit the file and create a `Makefile` in your self-constructed directory.

   > FAST uses **gnome autotools** to compile all the project. So you only need to write a `Makefile.am` to tell the autoconf tool how to generate a `Makefile` automatically. 
   >
   > If you don't know how to write it, you can simply copy one from other built-in apps. But DO REMEMBER to change macros such as `bin_PROGRAMS` and `xx_SOURCES` in `Makefile.am` according to your own code.

5. modify the `Makefile.am` in the `app/` directory to add your app into it.

Note: FAST API is defined in `fast-sw/include/` , you can read them before you write your own software code. As FAST is fully opensourced, **you can also invoke/write API for your own convenience**.

#### Write your own software code within UM pipeline

As the PL part is based on a Xilinx FPGA board, you can simply use Xilinx IDE (Vivado) to develop your hardware logics. 

We have encapsulate the platform related designs into netlist so there is nothing you need to care about. All you have to do is writing your verilog code in `/um` modules and testbench them before you synthesize the PL project. 



#### Compile your code

The most tricky thing here is to install cross-compile the `fast-sw` project on a x86 Linux PC before you can run them on the OpenBox S4 box.

If you don't know what is **cross-compile** and how to cross-compile the project. This [web]() may be helpful. **We also provide users with a virtual machine that already installed the environment for cross-compile**. You can find it [here](https://pan.baidu.com/s/1WbF6FwBU2Jp5k3uDcUaLsQ#list/path=%2F&parentPath=%2Fsharelink1884726292-1101305735633291) with the access passwd: **r7gz**. THE VIRTUAL MACHHINE IS IN `fast/1.0/OpenBox-S4/` directory.

After you prepare the cross-compile settings, the procedure is like this:

1. type `aclocal` in terminal (in the top-directory of `fast-sw`);
2. type `autoreconf` to generate the `configure.in`;
3. type `automake --add-missing --foreign` to generate the `Makefile.in`;
4. type `./configure --host=arm-xilinx-linux-gnueabi-gcc` to generate `Makefile`;
5. type `make` to generate your software that can run on the arm core of OpenBox S4;
6. you can find your app in the same directory you created. 



#### Run your own prototype on OpenBox S4

1. use whatever tools to copy the generated app into the arm core to OpenBox S4;
2. implement your hardware project onto the FPGA part of OpenBox S4 (this procedure is optional, it's depend on whether you changed the built-in pipeline of FAST);
3. use `./xxx` to run your application.
