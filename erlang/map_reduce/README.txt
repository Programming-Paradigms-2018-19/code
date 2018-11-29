Code Example
--------------------------------
MapReduce is an algorithm that asks concurrent or distributed tasks -- in
Erlang, these tasks are Erlang processes -- to each perform some portion
of a large job, then collects and combines the intermediate results from
each task into one final result.  The algorithm takes its name from two
common operations in functional programming languages like Haskell, Scheme,
and Erlang:

* map, which applies the same function to every element of a list.

* reduce (also known as fold), which combines all of the elements in a list
  into one result, using a "combiner" function that combines each element
  with a single running result

The map operation is generally thought of as a sequential operation, but the
MapReduce algorithm executes it concurrently instead, asking many separate
processes to execute the same function (albeit, possibly, with different
parameters).  The reduce operation is run sequentially; as intermediate
results arrive from the separate processes, they are combined.  When all of
the processes have returned their intermediate results, the combined result
will be complete and is ready to be returned.  In a practical implementation,
there might also be a timeout mechanism, so if one of the processes crashes
or is otherwise unresponsive, a mostly-complete result can still be returned.
The question of whether a mostly-complete result is tolerable is something
you have to consider, as a designer, on a case-by-case basis.

Where the power of this algorithm really shows is when it is run in a
distributed way, meaning that the concurrent processes are spread across
a network of machines.  A problem that can be formulated using MapReduce
is one whose solution can be scaled horizontally, meaning that you can
expect to achieve additional speedup as you add additional machines -- up
to the point where the problem can't be broken down further.  The ease with
which you can procure machines, given the rise of cloud services like Amazon's
Elastic Compute Cloud, has made approaches like this very powerful indeed.

Because of its support for message passing concurrency, Erlang allows MapReduce
to be implemented in a fairly straightforward way: the map operation is
implemented by having the reduce process send messages to the map processes,
then receive messages in response, executing the "combiner" function to
generate a single result.  Since message passing is built into the language,
there is relatively little infrastructure that needs to be built in order to
support this.

MapReduce can be very efficient if the processes can genuinely run
concurrently, which means two things:

(1) There are enough processors to run all of the processes, be it
    on one machine or many.  (Erlang natively supports running in a
    distributed scenario; for the most part, sending messages to processes
    on a different machine is no different than sending messages to
    processes on the same machine, except that the pid looks different.)

(2) There is no shared data or service that would need to be accessed
    by many of the processes simultaneously.

If these two properties hold, and so long as the time spent sending the
messages and combining the results is not prohibitive, relative to the time
that the map processes spend doing their work, MapReduce can be a very
good choice.

This code example implements the MapReduce algorithm in Erlang and also uses
it to solve a problem.  Since our goal, in general, was to demonstrate that
we could keep a number of processors busy simultaneously, the problem we
solved was decidedly non-practical -- adding all the integers from M to N
the hard way (i.e., not using a mathematical formula, but literally doing
all the additions) -- but our solution forms the basis of many more practical
problems, including the one you're being asked to solve in Assignment #3.

Suppose we have a collection of processes called "counters," each of which
runs a tail-recursive server loop that processes messages of these forms:

* {count, Start, End, ReplyPid}, which asks it to return the sum of all of
  the integers from Start through End (inclusive) and send the result
  {ok, Sum} (where Sum is the sum of those integers) back to ReplyPid.

* {stop, ReplyPid}, which asks it to stop and send the result 'ok'
  back to ReplyPid.

Given a collection of these counter processes, we can use MapReduce to
calculate an entire sum more quickly by splitting up the problem.  In
order to do so, we need to decide on what the "map" operation will be and
what the "reduce" operation will be.  In this case, they should work like
this:

* The "map" operation will be to ask each process to add up a subsequent
  of the numbers from M through N.  For example, if our goal was to add
  the numbers 1 through 1,000,000 and we had four counter processes, we
  could ask one to add the numbers 1 through 250,000, another to add the
  numbers 250,001 through 500,000, and so on.

* The "reduce" operation will be to add the results received from the
  counter processes.  The sum of all of these results will be the
  overall answer.

This code example consists of two modules:

* counterprocess.erl, which implements the counter process described here

* mapreduce.erl, which implements the MapReduce algorithm generically (which
  means it can be reused to solve any other problem that can be formulated
  using the MapReduce algorithm)

To execute this example, fire up an Erlang interpreter and evaluate the
following expressions:

    1> Pids = lists:map(
           fun(_) -> counterprocess:start() end,
           lists:seq(1, 4)).
    [<0.35.0>,<0.36.0>,<0.37.0>,<0.38.0>]
    2> Jobs = lists:map(
          fun(Pid) -> {Pid, {count, 1, 100000000, self()}} end,
          Pids).
    [{<0.35.0>,{count,1,100000000,<0.30.0>}},
     {<0.36.0>,{count,1,100000000,<0.30.0>}},
     {<0.37.0>,{count,1,100000000,<0.30.0>}},
     {<0.38.0>,{count,1,100000000,<0.30.0>}}]
    3> mapreduce:mapreduce(
           Jobs,
           fun(Total, {ok, Result}) -> Total + Result end,
           0).
    20000000200000000

A couple of things to note about that sequence of expressions:

(1) The first expression is a quick way to start up many processes and get
    a list of their pids.  lists:seq(1, 4) returns the list [1,2,3,4].  If
    you have more or fewer processors on your machine than 4, pass a different
    second parameter.

(2) The second expression converts of each of the pids to a "job", which is
    how we tell the MapReduce algorithm what to do: we give it a list of
    tuples consisting of a pid and a message to send to that pid.

(3) Finally, we call MapReduce and pass it the list of jobs, a "combiner"
    function (note that we had to handle results in the form {ok, Result},
    since that's what's returned from counterprocess when we ask it for a
    sum), and an initial result (0, which is the "sum so far" when no
    processes have reported back yet).
