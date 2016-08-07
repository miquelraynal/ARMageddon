# ARM@geddon
Lightweight Operating System for a specific ARM architecture

## Tools
-> sudo apt-get install gcc-arm-none-eabi
-> sudo apt-get -o Dpkg::Options::="--force-overwrite" install gdb-arm-none-eabi (use dpkg's force-overwrite option if needed or this will fail because some files like the manual have to be overwritten over the native ones natively presents in gdb package for Debian/Ubuntu distributions)

## Compile and simulate
make clean
make
arm-none-eabi-gdb
> target sim
> load kernel.elf
> file kernel.elf

