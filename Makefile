TARGET = main
CC = arm-none-eabi-gcc
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy

CFLAGS = -mcpu=cortex-m3 -mthumb -Wall -g -nostartfiles -std=c99

all: $(TARGET).bin

$(TARGET).bin: $(TARGET).elf
    $(OBJCOPY) -O binary $< $@

$(TARGET).elf: startup.o main.o stm32f103.ld
    $(LD) -T stm32f103.ld -o $@ $^

startup.o: startup.c
    $(CC) $(CFLAGS) -c $< -o $@

main.o: main.c stm32f103x_registers.h
    $(CC) $(CFLAGS) -c $< -o $@

flash: $(TARGET).bin
    # Flash the binary to your STM32 device using your preferred tool

clean:
    rm -f *.o *.elf *.bin
