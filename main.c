/* Main entry of the kernel */

volatile int counter = 0xACC0;

int kernel_main(int r0, int r1, int atags)
{
    while(1) {
        counter++;
    }

    return 0;
}
