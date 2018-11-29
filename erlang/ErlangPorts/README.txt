Combining Erlang and Java Using Erlang Ports
Informatics 102 Spring 2012
Code Example
--------------------------------------------
We talked in lecture about the need for mixed-language programming.  In many
real-world projects, the mixture of requirements leads to a situation in which
there isn't one "right tool" for the job, but there are "right tools" for
different parts of that job.  The trick, when solving larger-scale software
problems with multiple languages, is getting programs written in different
languages to communicate with one another.  How you do that depends on what
languages you're combining -- some fit more naturally than others -- but
there are some basic principles on which mixed-language programming is almost
always built; there are two typical styles used to combine multiple languages:

(1) Compliation to a common target language.  Examples include Java, Scala,
    and Groovy -- all of which compile to JVM bytecodes -- or compiling C++
    and Fortran by generating native code from both (and using the appropriate
    linkage when making calls from functions in one language into functions
    of the other).

(2) Communication.  This communication takes many forms (e.g., files,
    databases, sockets/networks, pipes), but always involves an agreement
    on a format or protocol for how data will be exchanged.

This example details one way that we can make Erlang and Java programs
communicate with one another, using what are called "Erlang ports,"
which fall into the second category above.

Ports, in Erlang, are connections to programs that are started up and
managed by the Erlang virtual machine, but that execute separately -- in
operating systems parlance, we say that these programs run in a separate
"process" or a separate "address space."

A port functions similarly to an Erlang process.  To send data to your
external program, you send a specially-formatted message to the port; when
the external program sends data back, it arrives as a specially-formatted
message, which is passed to whichever Erlang process is connected to it.
(By default, the process that launches a port is the one connected to it.)

A couple of restrictions apply to Erlang ports:

(1) They launch external programs on the same machine where the Erlang
    interpreter is running, so they are not generally used in a distributed
    sense.

(2) Only specially-formatted messages can be (meaningfully) sent to Erlang
    ports and only specially-formatted messages will be received from them.

Creating a port requires the use of the built-in open_port/2 function, which
takes two parameters:

* A description (location, command-line arguments) of the external program
  that should be started.

* A list of options that configure how communication between Erlang and the
  external program will take place.

The result is a port identifier, which is similar to a pid; it identifies a
kind of process (the port process), meaning you can send messages to it using
the same syntax we use to send messages to other Erlang processes.

An example call to open_port looks like this:

    open_port({spawn, Command}, [{packet, 1}])

In this example, the variable Command presumably already contains the command
used to execute the external program -- by command, I mean the string you
would type into a command prompt or terminal window to launch the program.
The {packet, 1} option says "Each message should be wrapped in a 'packet' with
a one-byte header specifying the size of the message."  (Instead of 1, you can
use 2 or 4 to allow messages to be longer: a one-byte header will only allow
messages up to 255 bytes long; a two-byte header will allow messages up to
65,535 bytes long; a four-byte header will allow messages up to four
gigabytes.)

To send a packet to the external program, you send a message to it of the
form {ReplyPid, {command, Bytes}}, where ReplyPid is the pid to which the
response should be sent and Bytes is a list of integers specifying the bytes
that should be sent.  The message is then packaged up into a packet.  So, for
example, if you evaluate this expression:

    Port ! {self(), {command, [5, 10, 15, 20]}}

then the following sequence of bytes will be sent to the external program:

    4, 5, 10, 15, 20

with 4 being the number of bytes in the remainder of the message, and the
subsequent four bytes comprising the message itself.  These bytes will
appear on the "standard input" of the external program, which means that
the program can read them as though they had been typed into the console;
if the external program is a Java program, it reads from System.in.  When
sending its response, the external program writes its response to the
"standard output;" in Java terms, that means the response is written to
System.out.

When the external program sends a packet back to Erlang, it is sent as an
Erlang message of the following form:

    {Port, {data, Message}}

where Port is the port identifier of the external program that sent the
message and Message is a list of bytes that the external program sent.


The example program
-------------------
Our Java program knows how to perform two simple math operations:

* Given an integer, square it and return the result.
* Given an integer, cube it an return the result.


The protocol
------------
As is necessary any time you want to write separate programs that communicate
with one another, there needs to be an agreement about what the communication
should look like.  That agreement is called a "protocol."

In our case, there needs to be an agreement about:

* How Erlang will ask the Java program to square an integer
* How the Java program will send the result of squaring an integer
* How Erlang will ask the Java program to cube an integer
* How the Java program will send the result of cubing an integer
* How Erlang will ask the Java program to terminate

We'll formulate each of these "messages" as a packet of bytes.  The first byte
in the packet will be the length of the packet; the remaining bytes will depend
on what kind of message is being sent.

* When Erlang wants to ask the Java program to square an integer, it will
  send a packet containing the byte 1, followed by a byte containing the
  number to be squared.

* When Erlang wants to ask the Java program to cube an integer, it will
  send a packet containing the byte 2, followed by a byte containing the
  number to be squared.

* When Erlang wants to ask the Java program to terminate, it will send a
  special "close" message to the port, which will respond with a "closed"
  message.

* After squaring or cubing an integer, the Java program will send a response
  packet containing only the byte containing the result.

* After being asked to terminate, the Java program will not send any message
  at all.

One consequence of our choice of protocol is that our results will be limited
to numbers in the range 0..255.  We could overcome this by sending multiple
bytes back instead, though we would then need to write code to handle
conversion between multi-byte sequences and ints (and back again).  To
keep things simple, we'll avoid that detail here.


Running this example
--------------------
To run this example, you'll need to follow these steps:

* First, pull the Java code into an Eclipse project.

* Compile the program (e.g., by changing one character in the program,
  changing it back, then saving it).

* Find the path to the "bin" folder in your Eclipse project, which is
  where the compiled files (.class files) are saved.  For example, that
  folder might be "C:\102Workspace\PortExample\bin".

* Find the path to the Java installation on your machine, which might
  be something like "C:\jdk1.7.0_03".  (If you're running Windows, it
  might also be within your Program Files folder.)

* Start an Erlang interpreter, then evaluate the following expression,
  substituting the path to your Eclipse project's "bin" folder and your
  Java installation:

    1> Port = open_port({spawn, "C:\\jdk1.7.0_03\\bin\\java -cp C:\\102Workspace\\PortExample\\bin;C:\\jdk1.7.0_03\\lib inf102.erlang.ports.Main"},
                        [{packet, 1}]).
    Port#<0.35.0>

  There are a couple of potential "gotchas" to be aware of.  If a path has
  spaces in it, you'll need to surround it with the character sequence \",
  like this:
  
    1> Port = open_port({spawn, "\"C:\\Program Files\\Java\\1.6.0_11\\bin\\java\" -cp \"C:\\102Workspace\\PortExample\\bin;C:\\Program Files\\Java\\1.6.0_11\\lib\" Main"},
                        [{packet, 1}]).
    Port#<0.35.0>

  Also, note that every backslash in the paths has been turned into two
  consecutive backslashes; as in Java, backslashes in string literals have
  a special meaning in Erlang, so we have to write two of them in a row if
  we literally want a backslash to appear in our string.

* Send a message to the port, asking the Java program to square the number 8.

    2> Port ! {self(), {command, [1, 8]}}.
    {<0.40.1>, {command, [1, 8]}}

  Notice that we put two bytes into the list: 1 (representing the square
  command) and 8 (representing the number to be squared).  We didn't include
  the packet length; this will be added by Erlang automatically.  (Java, on
  the other hand, will have to read and write packet lengths explicitly.)

* Receive a response from the port, which should contain the result computed
  by the Java program.
  
    3> flush().
    Shell got {Port#<0.35.0>, {data, "@"}}

  This seems like a strange result, and you may be wondering why squaring
  the number 8 gives you back a string containing '@'.  Recall that, in Erlang,
  strings and lists of integers are the same type of data.  The shell makes a
  decision about whether to print the data as a string or a list of integers
  based on whether the integers are all character codes of printable characters;
  if so, it is shown as a string, otherwise, it's shown as a list of integers.

  So, here, our answer was [64].  64 is the character code for '@', which is a
  printable character.  So the Erlang shell shows us "@" instead of [64].  To
  verify that, we can type this expression:

    4> [64].
    "@"
 
  Notice that the packet length is not included in the response, either;
  Erlang strips it away, using it only to know when the packet has ended.

* You can send as many of these messages and receive as many responses as
  you'd like in the interpreter.
  
    5> Port ! {self(), {command, [2, 3]}}.
    {<0.40.1>, {command, [2, 3]}}
    6> flush().
    Shell got {Port#<0.35.0>, {data, "\e"}}
    7> [27].
    "\e"

* Finally, ask the Java program to terminate by closing its port:

    8> Port ! {self(), close}.
    {<0.40.1>, close}
    9> flush().
    Shell got {Port#<0.35.0>, closed}


Debugging the Java program
--------------------------
The Java program should be free of bugs, but I've put extra code into the
program to demonstrate how you might debug it.  Since the program is being
started and managed by the Erlang interpreter, there is no console window
displayed; there is no ability for human interaction, so there is no
straightforward ability to debug the program in ways that you might be
accustomed (e.g., by printing output to the console or by using the graphical
debugger in Eclipse).  So, rather than debugging the program through
conventional means, I've set up the program to accommodate debugging in a
somewhat different way: by using a log file.

To turn debugging on, change the value of the DEBUG_MODE field in the Java
program to true, then change the value of the DEBUG_OUTPUT_FILE field in the
Java program to the full path to where you'd like the output file written.
The program will write to the output file each time it reads a byte from the
console or writes a byte to the console, allowing you to see what the
conversation between the programs looks like; this is a handy tool that you
can use for debugging.

Try turning debugging on, then fire up the Java program through an Erlang
port and see what the conversation looks like.
