// Main.java
//
// Informatics 102 Spring 2012
// Code Example
//
// This program is intended to be executed through an Erlang port.  It reads
// bytes from System.in and writes bytes to System.out, using the protocol
// described in the README.txt file that accompanies this example.  It also
// provides a debug option, which can be used to go back and view the sequence
// of bytes read and written.

package inf102.erlang.ports;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;


public class Main
{
	private static final boolean DEBUG_MODE = false;
	private static final String DEBUG_OUTPUT_FILE = "C:\\debug.out";
	
	
	public static void main(String[] args)
	{
		try
		{
			log("Started");
			
			while (true)
			{
				// If we get back -1 here, the Erlang port thorugh which this
				// program is communicating has been closed, so we'll bail out
				// of this otherwise infinite loop.
				if (readByte() == -1)
				{
					break;
				}
				
				// Read the byte specifying the command.
				int command = readByte();
	
				if (command == 1)
				{
					// If the command is the square command (1), we expect the
					// next byte to contain the number that should be squared.
					int param = readByte();
					int result = square(param);
	
					// We should respond with two bytes: the packet length
					// (always 1) and the byte containing the result.
					writeByte(1);
					writeByte(result);
	
					// This turns out to be critical, since output to System.out
					// can be buffered, meaning that the Java program will collect
					// a bunch of it before actually writing it to System.out.
					// This matters because, on the Erlang side, we might be
					// sitting and waiting for a response, so we want to be sure
					// our bytes are sent immediately.
					System.out.flush();
				}
				else if (command == 2)
				{
					// The cube command (2) is handled similarly to the square
					// command.
					
					int param = readByte();
					int result = cube(param);
					writeByte(1);
					writeByte(result);
					System.out.flush();
				}
				else
				{
					// We got an unrecognized command.  The safest thing to do is
					// to shut the program down.
					break;
				}
			}

			log("Stopped");
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
	
	
	// readByte() reads one byte from System.in, returning its value as an int
	// value.  If System.in has been closed, this method returns -1.  If the
	// DEBUG_MODE constant is true, it also writes a line to the debug output
	// file specifying what byte was read.
	private static int readByte()
	throws IOException
	{
		int b = System.in.read();

		log("Read Byte: " + b);
		
		return b;
	}

	
	// writeByte() writes one byte to System.out.  If the DEBUG_MODE constant
	// is true, it also writes a line to the debug output file specifying what
	// byte was written.
	private static void writeByte(int b)
	{
		try
		{
			System.out.write((byte) b);
			
			log("Wrote Byte: " + b);
		}
		catch (Exception e)
		{
		}
	}
	
	
	private static int square(int n)
	{
		return n * n;
	}
	
	
	private static int cube(int n)
	{
		return n * n * n;
	}


	private static void log(String message)
	{
		// The reason I'm opening and closing the file every time I write
		// to it is so it will be possible to open it and see its contents
		// (say, in a text editor) even while the program continues to run.

		if (DEBUG_MODE)
		{
			PrintWriter pw = null;

			// This try/finally idiom for closing the final can be replaced,
			// in Java 7, with a try-with-resources block instead.  I'll
			// use the pre-Java 7 approach here, so you won't need Java 7
			// to run the example.

			try
			{
				pw = new PrintWriter(new FileWriter(DEBUG_OUTPUT_FILE, true));
				pw.println(message);
			}
			catch (Exception e)
			{
				// There's nothing we can do here, since logging is our only
				// contact with the outside world for debugging, so we'll just
				// swallow the exception.
			}
			finally
			{
				if (pw != null)
				{
					pw.close();
				}
			}
		}
	}
}
