# ---------- ARRAYS ----------
# Arrays can contain multiple data types

randArray = ["word", false, 1234, 1.234]

csOutput.insertAdjacentHTML('beforeend', "Index 2 : #{randArray[2]}<br>")

# Get the last 2 indexes
csOutput.insertAdjacentHTML('beforeend', "Last 2 : #{randArray[2..3]}<br>")

# Defines an array with a range from 1 to 10

oneTo10 = [1..10]

# You can go backwards as well

tenTo1 = [10..1]

# Combine Arrays
combinedArray = oneTo10.concat tenTo1

# Push one tenTo1 onto the end of oneTo10
# ... is called a Splat and you use it to indicate that you want to
# "soak up" a list of arguments, or all the values in the array
oneTo10.push tenTo1...

# Use a for loop to cycle through the array
for x in oneTo10
  csOutput.insertAdjacentHTML('beforeend', "#{x}<br>")

# Convert an array into a String
csOutput.insertAdjacentHTML('beforeend', "#{oneTo10.toString()}<br>")

# Filter out all odds by saving elements that return true for the condition
evensOnly = oneTo10.filter (x) -> x % 2 == 0
csOutput.insertAdjacentHTML('beforeend', "#{evensOnly.toString()}<br>")

# Get the maximum value in the array
csOutput.insertAdjacentHTML('beforeend', "Max : #{Math.max oneTo10...}<br>")

# Get the minimum value in the array
csOutput.insertAdjacentHTML('beforeend', "Min : #{Math.min oneTo10...}<br>")

# Sum items in an array
sumOfArray = oneTo10.reduce (x,y) -> x+y
csOutput.insertAdjacentHTML('beforeend', "Sum : #{sumOfArray}<br>")

# Reverse an Array
csOutput.insertAdjacentHTML('beforeend', "Reverse : #{tenTo1.reverse()}<br>")

# Create an array of objects
peopleArray = [
  {
    name: "Paul"
    age: 43
  },
  {
    name: "Sue"
    age: 39
  },
]

# Access item by key in array
csOutput.insertAdjacentHTML('beforeend', "First Name : #{peopleArray[0].name}<br>")

# ---------- LOOPING ----------
# Already covered how to cycle through an array

for x in oneTo10
  csOutput.insertAdjacentHTML('beforeend', "#{x}<br>")

# We can use the guard when to print out only odd numbers

for x in oneTo10 when x%2 isnt 0
  csOutput.insertAdjacentHTML('beforeend', "#{x}<br>")

# We can cycle trough a range of numbers and print out the evens
for x in [50..100] when x%2 is 0
  csOutput.insertAdjacentHTML('beforeend', "#{x}<br>")

# We can skip certain values using by
for x in [20..40] by 2
  csOutput.insertAdjacentHTML('beforeend', "#{x}<br>")

# We can access indexes

employees = [
  "Doug"
  "Sue"
  "Paul"
]

for employee, employeeIndex in employees
  csOutput.insertAdjacentHTML('beforeend', "Index: " +
    employeeIndex + " Employee: " + employee + "<br>")

# We can search for a value with in
if "Doug" in employees
  csOutput.insertAdjacentHTML('beforeend', "I Found Doug<br>")

# Let's count from 100 to 110 with a while loop
i = 100

while (i += 1) <= 110
  csOutput.insertAdjacentHTML('beforeend', "i = #{i}<br>")

# You can use a while loop to cycle until 0 is reached
monkeys = 10

while monkeys -= 1
  csOutput.insertAdjacentHTML('beforeend',
    "#{monkeys} little monkeys, jumping on the bed. One fell off and bumped his head.<br>")

# There is no Do While loop but it can be emulated
# Loop as long as x != 5
x = 0
loop
  csOutput.insertAdjacentHTML('beforeend', "#{++x}<br>")
  break unless x != 5

# ---------- FUNCTIONS ----------
# With functions always move your functions above calling them in code

# You define the function name with an equal followed by attributes and ->
helloFunc = (name) ->
  return "Hello #{name}"

csOutput.insertAdjacentHTML('beforeend', "#{helloFunc("Derek")}<br>")

# A function with no attributes

getRandNum = ->
  return Math.floor(Math.random() * 100) + 1

csOutput.insertAdjacentHTML('beforeend', "Random Number : #{getRandNum()}<br>")

# You can receive an undefined number of values with vars...
sumNums = (vars...) ->
  sum = 0
  for x in vars
    sum += x
  return sum

csOutput.insertAdjacentHTML('beforeend',
  "Sum : #{sumNums(1,2,3,4,5)}<br>")

# The last expression in a function is returned by default
# You can define default argument values
movieRank = (stars = 1) ->
  if stars <= 2
    "Bad"
  else
    "Good"

csOutput.insertAdjacentHTML('beforeend',
  "Movie Rank : #{movieRank()}<br>")

# Recursive function that calculates a factorial
factorial = (x) ->
  return 0 if x < 0
  return 1 if x == 0 or x == 1
  return x * factorial(x - 1)

csOutput.insertAdjacentHTML('beforeend',
  "Factorial of 4 : #{factorial(4)}<br>")

# 1st: num = 4 * factorial(3) = 4 * 6 = 24
# 2nd: num = 3 * factorial(2) = 3 * 2 = 6
# 3rd: num = 2 * factorial(1) = 2 * 1 = 2

# ---------- OBJECTS ----------

derek = {name: "Derek", age: 41, street: "123 Main St"}

csOutput.insertAdjacentHTML('beforeend', "Name : #{derek.name}<br>")

# How we add an object property
derek.state = "Pennsylvania"

# Cycle through an object
for x, y of derek
  csOutput.insertAdjacentHTML('beforeend', x + " is " + y + "<br>")

# ---------- CLASSES ----------

class Animal

  # List properties along with their default values
  name: "No Name"
  height: 0
  weight: 0
  sound: "No Sound"

  # Define a static property that is shared by all objects
  @numOfAnimals: 0

  # Static methods also start with @
  @getNumOfAnimals: () ->
    Animal.numOfAnimals

  # The constructor is called when the object is created
  # If we use @ with attributes the value is automatically assigned
  constructor: (name = "No Name", @height = 0, @weight = 0) ->

    # @ is like this in other languages
    @name = name

    # You access static properties using the class name
    Animal.numOfAnimals++

  # A class function
  makeSound: ->
    "says #{@sound}"

  # Use @ to reference the objects properties
  # Use @ to call ofther methods of this object
  getInfo: ->
    "#{@name} is #{@height} cm and weighs #{@weight} kg and #{@makeSound()}"

# Create an Animal object
grover = new Animal()

# Assign values to the Animal object
grover.name = "Grover"
grover.height = 60
grover.weight = 35
grover.sound = "Woof"

csOutput.insertAdjacentHTML('beforeend',
  "#{grover.getInfo()}<br>")

# You can attach new object methods outside of the class
Animal::isItBig = ->
  if @height >= 45
    "Yes"
  else
    "No"

csOutput.insertAdjacentHTML('beforeend',
  "Is Grover Big #{grover.isItBig()}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "Number of Animals #{Animal.getNumOfAnimals()}<br>")

# ---------- INHERITANCE ----------
# CoffeeScript makes inheritance very easy to implement
# Each class that extends another receives all its properties and methods

class Dog extends Animal
  sound2: "No Sound"

  constructor: (name = "No Name", height = 0, weight = 0) ->

    # When super is called in the constructor CS calls the super classes
    # constructor
    super(name, height, weight)

  # You override methods by declaring one with the same name
  # CS is smart enough to know you are calling the Animal version
  # of makeSound when you just type super
  makeSound: ->
    super + " and #{@sound2}"

sparky = new Dog("Sparky")

sparky.sound = "Wooooof"
sparky.sound2 = "Grrrrr"

csOutput.insertAdjacentHTML('beforeend',
  "#{sparky.getInfo()}<br>")