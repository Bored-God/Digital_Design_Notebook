# Alright, ASSERTIONS

It's 1st Sept 2026 and today we are working on assertions.

(Apparently I forgot to upload what i learnt that day onto github 💀💀)

There are a few kinds of assertions. 

There's in-cycle and across cycles. 

## In Cycle:
	These assertions check if something happened in this current cycle.
	
### Same Cycle Implication (|->) :
		Then we can do something along the lines of 
			assert property (en |-> sum = a+b);
		Here, we are seeing that the sum must be equal to a + b within this clock cycle (|->)

### One-Hot encoded (only 1 bit must be high, all others must be low) :
	Lets take the example of the arbiter that I made, it requires grant to be one-hot encoded
	So the assertion can be: 
		assert property($onehot0(grant));
	This allows the signal to either be one-hot or 0
	
### Boolean operation :
	Things like 'assert (a & b)' or 'assert (a || b)' , etc.
	All these could be perfectly verified within the same cycle.

### Rise() and Fall() :
	This basically checks for posedge and negedge of specified signals per clock cycle. (respecitvely)

## Across Cycles:
    These Assertions check if something that was supposed to happen after a few cycles, Happened. A few types are:

### Next Cycle Implementation (|=>) :
		Next cycle implementation states that if 'A' occurred, then 'B' must happen in the next cycle.
		Eg: assert property (req |=> grant) 
		This would translate to, if we received a 'req', it must be granted within the next cycle.
	
### ##N  (delay between signals) :
		This is a slightly advanced version of the previous one, this allows arbitrary delay over multiple cycles.
		Eg: assert property (error_code == 4'b1101 |=> ##4 error_code == 4'b0000)
		This could translate to, if there was a specific error, it must be resolved within 4 cycles.
	
### $past() :
		This is one of the most powerful assertions as it deals with previous values of a signal.
		Eg: assert property (en |=> q == $past(d))
		This verifies that q is the same as d sampled in the previous clock.

Alright, enough writing notes, I ain't gonna learn anything if there is no implementation. I'm gonna start implementing SVA as a part of verification across all future testbenches. 

Now, let's move ahead to the next topic
