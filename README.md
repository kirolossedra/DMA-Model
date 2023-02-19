# DMA-Model
## Scenario Discussed :
* The CPU (MIPS) is executing an instruction that uses memory (store byte) then a series of R format instructions that doesn’t use the memory 
* in the beginning it recieves a request from DMA but ignores it till it finishes the Store Byte in location 63 in Memory ( offset 60 + register zero value is 3 at the beginning ) 
* then leaves the buses to the DMA and in parallel goes to executes some R format instructions while DMA deals with two IO devices to communicate with memory
*first a disk , second a keypad with keys numbered from 1 to 8 the disk just copies four words from memory and then copies to the memory another four words in different locations then the user disconnects the disk , and then connects a keypad and presses key 4 (8’b00001000) this stores the number 4 to the address in memory assigned by DMA for the keypad which is originally programmed by the user 

***

## Schematic for the Target DMA : 
![block_diagram_of_8237](https://user-images.githubusercontent.com/59807200/219954143-5e8248e2-2af6-44a0-9cce-6ba393fdd958.png)

***

## Signals Scope for different buses used to show the state of DMA and CPU mode and priorities 

![2023-02-19 (1)](https://user-images.githubusercontent.com/59807200/219954524-cb2ed07f-2488-4108-bb44-e178777fca6e.png)


