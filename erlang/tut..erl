-module(tut).

% Import string functions
-import(string, [len/1, concat/2, chr/2, substr/3, str/2, 
				 to_lower/1, to_upper/1]).

% Defines what functions can be called from this module
% /0 defines that this function doesn't receive attributes
% /2 defines that add recieves 2
% -export([hello_world/0, add/2, add/3, main/0]).
-export([main/0]).

% We execute functions like this tut:hello_world().
% fwrite outputs a string to the console
hello_world() -> 
	io:fwrite("Hello World\n").

% Recieve 2 values and return the sum
add(A, B) -> 
	% You can call other functions
	% Separate multiple statements with a comma
	hello_world(),
	A + B.

% You can define functions with the same name
% as long as the number of attributes differ
add(A, B, C) ->
	A + B + C.

% tut:module_info(). gives you info on your module

% ----- VARIABLES -----

% Variable names start with an uppercase letter
% or _ and then letters, numbers, _, or @
% A variables value cannot change
% A variables type is defined dynamically

% You can call a function before it was created
% Even if you call multiple functions only
% output from the last shows
main() ->
	var_stuff(),
	atom_stuff(),
	do_math(5,4),
	compare(4,4.0),
	what_grade(10),
	say_hello(german),
	string_stuff(),
	tuple_stuff(),
	list_stuff(),
	lc_stuff(),
	type_stuff(),
	find_factorial(3),
	sum([1,2,3]),
	sum2([1,2,3], 0),
	for(3,1),
	map_stuff(),
	record_stuff(),
	do_math2(),
	fun_stuff("Derek"),
	fun_stuff2(),
	write_txt("Write to the file"),
	write_txt2(" More text for the file"),
	read_txt(),
	error_stuff(0),
	read_txt2(),
	macro_stuff(5,6),
	spawner(),
	spawner(),
	spawner2(50,1),
	spawner2(100, 51).

var_stuff() ->
	Num = 1,
	Num.

% An Atom is variable thats name equals its value
% They start with lowercase letters, or are 
% surrounded by single quotes
atom_stuff() ->
	'An Atom'.

% ----- MATH -----
do_math(A, B) ->
	A + B,
	A - B,
	A * B,
	
	% Float division
	A / B,
	
	% Integer division
	A div B,

	% Modulus returns the remainder
	A rem B,
	
	% e raised to the X power
	math:exp(1),
	
	% Natural log
	math:log(2.71828),
	
	% Common log
	math:log10(1000),
	
	% Power
	math:pow(10,2),

	% Square root
	math:sqrt(100),

	% There is also sin, cos, tan, asin, acos, atan,
	% sinh, cosh, tanh, asinh, acosh, atanh

	% Generate random number from 1 to 10
	random:uniform(10).

% ----- COMPARING VALUES -----
% You receive true or fale from comparisons
% 0 isn't equal to false
compare(A, B) ->
	% Check for equality of value and type
	A =:= B,
	
	% Check for inequality of value and type
	A =/= B,

	% Disregard type
	A == B,
	
	% Disregard type
	A /= B,
	
	% >, <, >=, =<, and, or, not, xor
    Age = 18,
	(Age >= 5) or (Age =< 18).

% ----- IF CONDITIONALS -----
% If is used to perform different actions
% based on conditions
preschool() ->
	'Go to preschool'.

kindergarten() ->
	'Go to kindergarten'.

grade_school() ->
	'Go to grade school'.

what_grade(X) ->
	if X < 5 -> preschool()
	; X == 5 -> kindergarten()
	; X > 5 -> grade_school()
	end.

% ----- CASE CONDITIONALS -----
% Case performs different actions based on values
say_hello(X) ->
	case X of
		french -> 'Bonjour';
		german -> 'Guten Tag';
		english -> 'Hello'
	end.

% ----- STRINGS -----
% Strings must be surrounded by double quotes

string_stuff() ->
	Str1 = "Random string",
	Str2 = "Another string",
	
	% You can place strings or any data in
	% output using ~p
	io:fwrite("String : ~p ~p\n", [Str1, Str2]),
	
	% format can be used for similar results
	Str3 = io_lib:format("It's a ~s and ~s\n", [Str1, Str2]),
	io:fwrite(Str3),
	
	% Get string length
	len(Str3),

	% Concatenate strings
	Str4 = concat(Str1, Str2),
	Str4,
	
	% Get index for character
	CharIndex = chr(Str4, $n),
	CharIndex,
	
	% Return string start at index and number
	% of characters
	Str5 = substr(Str4, 8, 6),
	Str5,
	
	% Get index of string
	StrIndex = str(Str4, Str2),
	StrIndex,
	
	% All uppercase
	to_upper(Str1),
	
	% All lowercase
	to_lower(Str1).

% ----- TUPLES -----
% A Tuple can hold multiple values

tuple_stuff() ->
	My_Data = {42, 175, 6.25},
	
	% Get all values
	My_Data,
	
	% Store values in another tuple
	{A,B,C} = My_Data,
	
	% Return just 1 value
	C,
	
	% Use an anonymous variable to match a pattern
	{D,_,_} = My_Data,
	D,

	% You can use an Atom as the key for a value
	% Tagged Tuple
	My_Data_2 = {height, 6.25},
	{height, Ht} = My_Data_2,
	Ht.

% ----- LISTS -----
% Lists contain multiple values from any 
% data type

list_stuff() ->
	List1 = [1,2,3],
	List2 = [4,5,6],
	
	% Join lists with ++
	List3 = List1 ++ List2,
	List3,

	% Subtract a list
	List4 = List3 -- List1,
	List4,
	
	% Retrieve the 1st element (Head)
	hd(List4),
	
	% Retrieve all but the first (Tail)
	tl(List4),
	
	% Add a value to the list with the cons operator
	List5 = [3|List4],
	List5,
	
	% Get the head and tail
	[Head|Tail] = List5,
	Head.

% ----- LIST COMPREHENSIONS -----
% List comprehensions make it easy to manipulate lists

lc_stuff() ->
	List1 = [1,2,3],
	
	% Multiply every list item times 2
	% N is an incrementing list item
	List2 = [2*N || N <- List1],
	List2,
	
	% You can add conditions like to get only evens
	List3 = [1,2,3,4],
	List4 = [N || N <- List3, N rem 2 == 0],
	List4,

	% Search through a list of tuples for perfect weather
	City_Weather = [{pittsburgh, 50}, {'new york', 53}, 
					{charlotte, 68}, {miami, 78}],
	Great_Temp = [{City, Temp} || {City, Temp} <- City_Weather, Temp >= 50],
	Great_Temp.

% ----- TYPE CONVERSIONS -----
type_stuff() ->
	% You can check the type of a variable
	is_atom(name),
	is_float(3.14),
	is_integer(10),
	is_boolean(false),
	is_list([1,2,3]),
	is_tuple({height, 6.24}),

	% You can convert from one to another using
	% type_to_type
	% atom_to_binary, atom_to_list, binary_to_atom, 
	% binary_to_list, bitstring_to_list, binary_to_term, 
	% float_to_list, fun_to_list, integer_to_list, 
	% integer_to_list, iolist_to_binary, iolist_to_atom, 
	% list_to_atom, list_to_binary, list_to_bitstring, 
	% list_to_float, list_to_integer, list_to_pid, 
	% list_to_tuple, pid_to_list, port_to_list, ref_to_list, 
	% term_to_binary, term_to_binary, tuple_to_list
	List1 = integer_to_list(21),
	List1.

% ----- RECURSION -----
% Recursion is the act of a function calling itself
% Those things you normally accomplish with looping
% in other languages are done using recursion 
% with Erlang

% We can use recursion to find the factorial

factorial(N) when N == 0 -> 1;
factorial(N) when N > 0 -> N * factorial(N - 1).

find_factorial(X) ->
	Y = factorial(X),
	io:fwrite("Factorial : ~p\n", [Y]).

% 1st: 3 -> 3 * f(2) == 3 * 2 = 6
% 2nd: 2 -> 2 * f(1) == 2 * 1 (Send Above)
% 3rd: 1 -> 1 * f(0) == 1 * 1 (Send Above)

% Sum a list

sum([]) -> 0;
sum([H|T]) -> H + sum(T).

% sum([1,2,3])
% 1 + sum([2,3])
% 1 + 2 + sum([3])
% 1 + 2 + 3 + sum([])

% Tail Recursive
% Instead of holding up the additions
% we can keep a running count

sum2([], Sum) -> Sum;
sum2([H|T], Sum) -> 
	io:fwrite("Sum : ~p\n", [Sum]),
	sum2(T, H + Sum).

% sum2([1,2,3], 0)
% sum2([2,3], 1)
% sum2([3], 3)
% sum2([], 6)

% You can create a for loop with recursion
for(0,_) -> 
   ok; 
   
for(Max,Min) when Max > 0 -> 
   io:fwrite("Num : ~p\n", [Max]), 
   for(Max-1,Min). 
   
% for(3,1) Num : 3
% for(2,1) Num : 2
% for(1,1) Num : 1
% for(0,1) End

% ----- MAPS -----
% A Map is a group of key value pairs

map_stuff() ->
	Bob = #{f_name=>'Bob', l_name=>'Smith'},
	
	% Get value assigned to a key
	io:fwrite("1st Name : ~p\n",[maps:get(f_name, Bob)]),
	
	% Get all keys
	io:fwrite("~p\n", [maps:keys(Bob)]),
	
	% Get all values
	io:fwrite("~p\n", [maps:values(Bob)]),
	
	% Return everything except the key designated
	io:fwrite("~p\n", [maps:remove(l_name, Bob)]),
	
	% Check if a key exists
	maps:find(f_name, Bob),
	
	% Add a key value to the map
	maps:put(address, "123 Main", Bob).

% ----- RECORDS -----
% You can define a custom type that contains
% multiple fields

-record(customer, {name = "", bal = 0.00}).

record_stuff() ->
	
	% Define a customer
	Sally = #customer{name="Sally Smith", bal=100.00},
	
	% Change data
	Sally2 = Sally#customer{bal = 50},
	
	% Output data
	io:fwrite("~p owes $ ~p\n", [Sally2#customer.name, 
							 Sally2#customer.bal]).

% ----- HIGHER ORDER FUNCTIONS -----
% Functions that can receive other functions as
% a parameter is known as a higher order function

% Define a function that multiplies
% every item by 2
double(X) -> X * 2.

% This one triples the number
triple(X) -> X * 3.

% lists:map takes a function and applies
% that function to every item in the list

% Fun is used to assign a function
% to a variable
do_math2() -> 
	lists:map(fun double/1, [1,2,3]),
	lists:map(fun triple/1, [1,2,3]).

% You can use fun to define anonymous functions
fun_stuff(N) ->
	Fun_Stuff = fun() -> io:fwrite("Hello ~p\n",[N]) end,
	Fun_Stuff().

% You can also access values outside of the function
fun_stuff2() ->
	X = 3,
	Y = 4,
	Z = fun() ->
				io:fwrite("Sum : ~p\n",[X + Y]) end,
	Z().

% ----- FILE I/O -----
% Create and write to a file
write_txt(N) ->
	% Get file handler and write
	{ok, Fh} = file:open("MyFile.txt", [write]),
	
	% Write the text
	file:write(Fh, N).

write_txt2(N) ->
	% Get file handler and append
	{ok, Fh} = file:open("MyFile.txt", [append]),
	
	file:write(Fh, N).

% Read from file
read_txt() ->
	% Get read permission
	{ok, File} = file:open("MyFile.txt", [read]),
	
	% Read text from file
	Words = file:read(File, 1024 * 1024),
	io:fwrite("~p\n", [Words]).

% ----- EXCEPTION HANDLING -----
% Exception handling allows our program to
% handle errors rather then just crashing

% You place code that could crash after 
% try and then list what happens when certain
% errors occur after catch
error_stuff(N) ->
	try
		Ans = 2 / N,
		Ans
	catch
		error:badarith ->
			"Can't divide by zero"
	end.

read_txt2() ->
	try
		{ok, File} = file:open("MyFile1.txt", [read]),
		Words = file:read(File, 1024 * 1024),
		io:fwrite("~p\n", [Words])
	catch
		% This will catch all errors
		_:_ ->
			"File Doesn't Exist"
	end.

% ----- MACROS -----
% Macros provide for inline code replacement

% Define the constant and what replaces it
-define(add(X,Y), {X+Y}).

macro_stuff(X,Y) ->
	
	% ? defines to use the macro
	io:fwrite("~p\n", [?add(X,Y)]).

% ----- CONCURRENCY -----
% Concurrency is the when several processes
% execute at the same time and potentially
% interact

% As long as the processes aren't dependent
% on each other they can run at the same time
% Count to 1 million, calculate Pi aren't dependent
% but start engine drive car are

get_id(M) ->
	io:fwrite("ID : ~p\n", [M]).

% You can generate a process and define the function
% to execute. This passes the process ID
spawner() ->
	spawn(fun() -> get_id([self()]) end).

% Create a for loop that counts using different
% ranges
for2(0,_) -> 
   ok; 
   
for2(Max,Min) when Max > 0 -> 
   io:fwrite("Num : ~p\n", [Max]), 
   for(Max-1,Min). 

% The process take turns doing their jobs
spawner2(Max, Min) ->
	spawn(fun() -> for2(Max, Min) end).