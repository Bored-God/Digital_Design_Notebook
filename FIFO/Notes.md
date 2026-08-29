#Alright, FIFO

today is 29th Aug 2026. And I worked on and learnt what exactly a FIFO is. 

I knew what FIFO meant in concept and in theory. 
Its supposed to mean "FIRST IN, FIRST OUT". 
essentially, any data that enters this module, exits in the same order. In computer science/coding, this is also called a Queue.

I thought about pointers but wasnt sure if it existed in the hardware cuz this felt like a very "software" solution.
So, the initial idea I had for this would be an actual queue. 8 registers are in sequence and connected to one another. (somewhat like a shift register).
There would be another one-hot encoded register that acts as a pointer. 

If there was a write instruction, the data shifts forward, data is written in the new "empty" reg, and the "pointer" incriments by 1.
On read, the data from the pointerd register is read, and the pointer is decremented (doesnt matter if the old data isnt deleted. as long as its ahead of the pointer, it would always be rewritten).

A little more tinkering with the idea made me realize how inefficient the idea was. Moving data every single time there is a write instruction becomes tedious and wasteful. 
(also realized pointers arent just a "software thing". The more you know!🌈).

SO!! New design!
Its an 8-bit ram with 8 cells
8 cells = log2(8) = 3 bits required to make the pointers.
2 pointes, 1 each for read and write.
Write pointer increments at write. read incerments at read, pointer positions are output and input by the FIFO respectively at each command. 
Write is at index 0, its empty, write is at index 7 its full.

Read,write,data and wrap-around existed in harmony. (_here is where i hear the RTL engineers of the crowd snickering in the back_)  

Wait... wrap-around?? 

(O.O)... oh.
Right, wrap-around. Well, that was the big design flaw. 

An increment at 111 would ideally result in 1000, an impossible value for the FIFO to be in, meaning it was full.
BUT! this is a 3 bit design, here 111 + 1 = 1_000. We discard the extra bit resulting in 000 which IS a possible and valid value.
Everytime the pointer crosses the last location, it comes back to the first and ends up writing over the values cuz index 0 meant empty. 

This can NOT be represented in a 3 bit system. We need that extra 4th bit to convey context. Without that, we end up with overwriting and garbage values when we needed a previously stored value.

New-new design!

Using the 4th bit as context, keep incrementing. If the lower 3 bits of the read and write are same, with a different 4th bit: full, same 4th bit: empty. 
That essentially fixes both problems with the previous 2 systems. we added pointers and fixed wrap around. The values that we writeover now are essentially useless cuz the read pointer already crossed them.
Adding a little bit of cursed debugging power, fixing up a bit of the logic, we have a fully working FIFO. 

Today I learnt the following:
1. What is a FIFO. (woahhhh, big reveal!!!)
2. Dangers of unattended wraparound bits. 
3. Handeling edge cases and designing around them.
4. Well, number 4 is coming along for the ride cuz it felt lonely.


See you tomorrow for what comes next.
