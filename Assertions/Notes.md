# Alright, ASSERTIONS

It's 1st Sept 2026 and today we are working on assertions.

(Apparently I forgot to upload what i learnt that day onto github 💀💀)

there are a few kinds of assertions. 

there's in-cycle and across cycles. 

In Cycle:
	These assertions check if something happened in this current cycle.
	
Here, lets say there is an adder. The adder basically goes, "Hey, i got a few inputs and the enable 'go ahead', lets do the addition and give the output immediately."
```
		Then we can do something along the lines of 
			assert property (en |-> sum = a+b);
		Here, we are seeing that the sum must be equal to a + b within this clock cycle (|->)
```


There's also one-hot encoded verification. (only 1 bit must be high, all others must be low)

	Lets take the example of the arbiter that I made, it requires grant to be one-hot encoded
	So the assertion can be: 
		assert property($onehot0(grant));
	
Most Boolean operation verifications also happen in the same cycle.
	
	Things like 'assert (a & b)' or 'assert (a || b)' , etc.
	All these could be perfectly verified within the same cycle.

There is also something called rise() and fall()
	
	This basically checks for negedge and posedge of specified signals per clock cycle.
