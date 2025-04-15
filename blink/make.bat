cd %~dp0
arm-none-eabi-as -mcpu=cortex-m35p -mthumb -o main.out main.asm
arm-none-eabi-ld -Ttext=0x02000000 -o main.elf main.out
arm-none-eabi-objcopy -O srec  --srec-len 16 --srec-forceS3 main.elf main.mot
arm-none-eabi-objdump -D main.elf > objdump.txt
