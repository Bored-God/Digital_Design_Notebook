# UART PROTOCOL
The most fashionable serial transfer protocol.

Today is 12th Sept 2026 and we are looking at:
  
## Universal Asynchronous Receiver Transmitter protocol 
(his friends call him UART, but you may call him john) 

UART is a very universal and very important protocol/interface that allows for inter-device serial communication via an on-board/peripheral module.

Cutting the history of UART and small talk, this device transmits and receives information in a specific format without needing to have common/sync'd clock inputs, ideally allowing for communication over a distance and across time, provided the transmitter and receiver are clear on the format.

Extrapolating from the previous sentence, UART requires 2 modules, a transmitter and a receiver. Both these devices have a few constraints that allow for communication, which are:

    1) Baud Rate
    2) Parity Configuration
    3) Bit Width
    4) Stop Bit size

Now comes the interesting part, we have established the 'what', let's get to the 'how'.

## THE "HOW?" 👀👀

In it's most basic sense, communication means transfer of information between 2 or more entities; as long as the other person understands what you wanted to say, communication is successful. 

That's why books, texts, speaking and gesturing work generally similarly in the processes of communication. But if you notice, 2 out of the 4 mentioned examples work even when "the speaker" (the transmitter) isn't present in the same time/spatial position as "the listener" (the receiver). The reason texts and books (or even recorded messages) work is that the receiver understands the *language* that the transmitter is using.

The same way, UART defines the 'language' using the constraints mentioned above. 

    The transmission is in a resting high position.

    It sends a low bit to initiate a transmission, then proceeds to transmit the bit. 

    The receiver (wherever it is connected) receives that low and understands that this is the information is going to be transmitted.

    It starts listening for the datastream for as long as the pre-configured number of bits, and stores them LSB to MSB.

    Once it receives a "Stop" as high for the predefined bit width, it goes back to dormant. 

    That only happens after the proper bit width is received. Example: 

    if the bit width is 8 bits and stop bit size is 2, then the receiver goes dormant if it receives 2 high bits after 8 actual bits from the transmitter.

Now, we know "how" it happens in its most surface level speak. Let's go a bit deeper into the concept of UART (skip to "UART Transmitter.md" or "UART Receiver.md" if you want the technical details!!)

We know that UART is an async protocol, but what exactly does Async mean here? Asynchronous means that it can work even when the clocks aren't shared among the Transmitter and Receiver. 

BUT!! communication as a concept and in implementation requires that both the speaker and the listener are in sync. Imagine talking to a friend on call who is on a 2 second delay, how annoying would that feel? Now imagine that there are high stakes on the line and you still need to be able to communicate even in that kind of delay. Crazy, right?

UART pulls this off by bending the rules a little. We say that the clocks on the devices are different, but that's not fully accurate. The "clock" here is not an actual clock but rather an agreed-upon rate of communication of the device. This is known as **Baud Rate**, or more accurately, Baud rate is defined as the rate of symbols transmitted per unit time. 

This is denoted by the local parameter clk_per_bit in the design. This is calculated by the using the current clock/oscillator freq divided by the baud rate. This tells the devices, "Hey, it will take exactly these many of our cycles for one of their transmission to come to us. Keep reading for this long, then we move forward."

This can be mentioned as a formula in:
                                              $\ N_{cycles} = \frac{f_{clk}}{baud} \$

This allows the 2 systems to communicate a similar "simulated" clock that they can use for transmission. The some of the most common Baud rates are 9600 and 115200 Baud, and the reason these are so common is older systems used to use it and it makes it easier for backward compatibility. But truly, it doesn't really matter what Baud you take as long as the value is configured on both sides.

The test bench uses 2 different clocks at 2 different speeds to simulate the different oscillators that could be possible in each device and the data still passes through without a problem.
  
  <img width="1321" height="306" alt="image" src="https://github.com/user-attachments/assets/c741047a-6e8e-40ed-9907-e1365b279d4e" />

code for both has been uploaded within this folder.

What I learnt along with this project:
  1. What is UART and how it works.
  2. How i can make stable FSM
  3. Debugging FSMs are a nightmare 😭😭😭
