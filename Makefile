# Root Makefile to (cross-)compile ARM@geddon OS

# Potential externally defined variables
CROSS_COMPILE ?= arm-none-eabi-

# Local definitions
CPP     = $(CROSS_COMPILE)cpp      # C pre-processor   *.c   -> *.i
CC      = $(CROSS_COMPILE)gcc      # Compiler          *.i   -> *.s
AS      = $(CROSS_COMPILE)as       # Assembler         *.s   -> *.o
LD      = $(CROSS_COMPILE)ld       # Linker            *.o   -> *.elf
OBJCOPY = $(CROSS_COMPILE)objcopy  # Binary image      *.elf -> binary
LINKER_FLAGS = -Wl,-T,armelf-no-page-align.x # -Wl,-verbose
CFLAGS = -O0 -g -Wall -nostartfiles $(LINKER_FLAGS) # -v
OBJECTS = startup.s main.o

# It is possible to stop the compilation at different stages :
# $(CC) -E -o X.i will stop after preprocessing
# $(CC) -S -o X.s will stop after compilation
# Otherwise let the compile step be -c to stop after assembling with $(AS)

# Main target
all: kernel.img

# Expands source code (preprocessor)
# Compiles C source files in assembly code
# Assembles into machine code
%.o : %.c %.i %.s
	$(CC) $(CFLAGS) -c $<

# Links machine code into one ELF executable
kernel.elf: $(OBJECTS)
	$(CC) $(CFLAGS) -o kernel.elf $(OBJECTS)

# Strips ELF headers from ELF file
kernel.img: kernel.elf
	$(OBJCOPY) kernel.elf -O binary kernel.img

clean:
	rm -f kernel.img kernel.elf *.o

help:
	@echo "Compile with a simple: make"
	@echo "Objects files and kernels are removed with: make clean"
	@echo "You may also provide CROSS_COMPILE variable (ie. arm-none-eabi-)."
