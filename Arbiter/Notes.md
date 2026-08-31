# ARBITER 
Its 31st Aug 2026 and for some reason Arbiter sounds much more serious than it should. 💀💀

An Arbiter is a module which helps the system/module "choose" who is gets priority to execute their operation. 
(if you ask me, they should do a showdown and just Rock Paper Scissors the hell out of it, but ig electrons and I don't share the same level of intelligence.)

So, they need help and an Arbiter comes to the rescue. 
An Arbiter (or this specific arbiter) basically is a device which assigns priority in a round-robin fashion.

No, its not a plus sized version of Boy Wonder™️. Round-robin basically goes around in a loop and gives each one a chance to perform their operation in specific order. 
(what order? i dont know, cheeseburgers? what're you having?)

How to actually do this?

But, FIRST!! 
The problem statement: create a one-hot encoded Arbiter for 4 operation channels to use 1 resource module.

I know this is becoming a theme of sorts now, but the initial idea for this came from a software perspective. (I did Coding for a good 3 semesters, its not my fault I think in algos 😭😭).
the initial algorithm that I thought up was:
```
(Input   (3:0)   =  requests (one hot encoded).      Requests -> which operations want to use the resource.        
output   (3:0)   =  grant    (one hot encoded).         grant -> which operation gets to use said resource.
priority (1:0)   =  what the current loop starts at.                                                  )
The arbiter priority begins at 0.
```

   Input > | checks if operation 0 is requesting, then grant 0001. if not, then check if operation 1 is req.... to infinity, if no one is requesting, then grant = 0000 (default value)| > output. 

```
for this psudocode would be:    case(priority)
                                case 0: check if op 0
                                        out (0001)
                                        priority += 1
                                case 1: ...
                                case 2: ...
                                case 3: ...
                                endcase 
   ```                             
                               
But this doesnt really work well cuz we need to check each and every case for every input till atleast some operation gets to use it. 
The flaw with this was basically i was thinking that they would have to run one after the other, in sequence. That meant to make it clocked.

But if this is clocked, and this module alone will add a delay of up to 4 cycles in the longest path. (assume priority is on 0, and the only operation is the 3rd one).
There has to be an elegant solution to this. One that somehow does this in such a beautiful way that it seems like magic ✨✨

**SPOILER.**

It's an if-else ladder apparently. 😭😭😭😭😭😭😭😭.
Of all the things that someone could think up to make this solution. The most efficient way is apparently **AN IF-ELSE LADDER!??!?!?!!** 
*(My disappointment is immeasureble.)*

So, the new model basically just runs it all combinationally in each case with the help of if-else ladders and a clocked section of the arbiter updates priority.

Regardless, I still have to build this, so I swallow my anger and sit to code. 
there were a few design tweaks from the initial plan, adding a ladder or 2 here and fixing some small syntax bugs resulted in the current code. 

What I learnt today:
1. How to sometimes think inside the box for dumb but obvious solutions.
2. What an Arbiter is. (well, who would have thought)
3. Different types of Arbiters,Of which,
4. Learnt the implementation of a Round Robin arbiter in SystemVerilog.

Check out the file and ill see you tomorrow for what comes next!! 

