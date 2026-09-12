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

