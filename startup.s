.section ".text.startup"

.global _start

_start:
	/* Set the stack pointer (progresses downwards through memory) */
	ldr	sp, =0x8000	

	/* Zeroes the bss section */
	ldr	r3, =(__bss_start__) // __bss_start__ is defined in the linker script
	ldr	r4, =(__bss_end__) // __bss_end__ is defined in the linker script
	mov	r5, #0
clear_word:
	str	r5, [r3]
	add	r3, r3, #4
	cmp	r3, r4 // bss > __bss_end__ ?
	blt	clear_word

	/* Starts the main function, r0, r1 and r2 (ATAGS) are filled by the booloader */
	b	kernel_main
	
	/* We should never return from main */
_endless:
	b	_endless


.section ".text.exit"

.global _exit

_exit:
	b 	_exit
