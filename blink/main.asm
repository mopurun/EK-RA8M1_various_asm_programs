

.section .text
.syntax unified
.cpu cortex-m35p //cortex-m85


//LED1:P600:BLUE
//LED2:P414:GREEN
//LED3:P107:RED

.equ GPIO_BASE, 0x40400000  // p429
.equ GPIO1_PCNTR1, 0x20 * 1        
.equ GPIO1_PCNTR4, 0x20 * 4
.equ GPIO1_PCNTR6, 0x20 * 6



.global _start
.type _start, %function

    .word   0x220D0000 //p129
    .word   _start
    .word   _start
    .word   _start

.org 0x200
_start:

    //LED1
    ldr r0, =GPIO_BASE+GPIO1_PCNTR6
    ldr r1, =0x00000001    
    str r1, [r0, 0]

    //LED2
    ldr r0, =GPIO_BASE+GPIO1_PCNTR4
    ldr r1, =0x00004000    
    str r1, [r0, 0]

    //LED3 ON
    ldr r0, =GPIO_BASE
    ldr r1, =0x00800080    
    str r1, [r0, #GPIO1_PCNTR1]


loop:

    bl wait

    //LED1 
    ldr r0, =GPIO_BASE+GPIO1_PCNTR6    
    ldr r2, [r0, #0]
    ldr r1, =0x00010000
    eor r1, r1, r2   
    str r1, [r0, #0]

    //LED3 
    ldr r0, =GPIO_BASE    
    ldr r2, [r0, #GPIO1_PCNTR1]
    ldr r1, =0x00800000
    eor r1, r1, r2   
    str r1, [r0, #GPIO1_PCNTR1]

    bl wait

    //LED2 
    ldr r0, =GPIO_BASE+GPIO1_PCNTR4    
    ldr r2, [r0, #0]
    ldr r1, =0x40000000
    eor r1, r1, r2   
    str r1, [r0, #0]

    //LED1
    ldr r0, =GPIO_BASE+GPIO1_PCNTR6     
    ldr r2, [r0, #0]
    ldr r1, =0x00010000
    eor r1, r1, r2   
    str r1, [r0, #0]

    bl wait


    //LED3
    ldr r0, =GPIO_BASE     
    ldr r2, [r0, #GPIO1_PCNTR1]
    ldr r1, =0x00800000
    eor r1, r1, r2   
    str r1, [r0, #GPIO1_PCNTR1]


    //LED2
    ldr r0, =GPIO_BASE+GPIO1_PCNTR4     
    ldr r2, [r0, #0]
    ldr r1, =0x40000000
    eor r1, r1, r2   
    str r1, [r0, #0]

    b loop

wait:
    mov r3, #0
wait1:
    mov r2, #0 
wait2:

    add r2, r2, #1
    cmp r2, #1000
    bne wait2
    add r3, r3, #1    
    cmp r3, #100
    bne wait1

    bx lr



