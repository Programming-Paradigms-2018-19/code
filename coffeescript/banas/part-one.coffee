# I'll use the NodeJS compiler to process CoffeeScript so download Node if you
# don't have it here https://nodejs.org/en/

# Then in your terminal install CoffeeScript by typing
# npm install -g coffee-script

# You compile to a JS file with the same name but the js extension with
# coffee --compile cstut.coffee

# To auto compile use this in the terminal coffee -wc *.coffee

###
Multiline Comment
###

# ---------- INTRO ----------
# There is no var or semicolons in CoffeeScript

# Variables in CoffeeScript are not global by default

name = "Phil"

# Get access to the element with the id csoutput
csOutput = document.getElementById("csoutput")

# Assign this string with the variable to it
# Use double quotes for Interpolation
csOutput.innerHTML = "Hello #{name}<br>"

# ---------- VARIABLES ----------
# The data types are string, number, boolean, array, object, undefined
# and null

aString = "I'm a String"

csOutput.insertAdjacentHTML('beforeend', 'aString is a String<br>') if typeof aString is 'string'

largestNum = Number.MAX_VALUE
smallestNum = Number.MIN_VALUE

largeNumStr = "The largest number is #{largestNum}<br>"
smallNumStr = "The smallest number is #{smallestNum}<br>"

csOutput.insertAdjacentHTML('beforeend', largeNumStr)
csOutput.insertAdjacentHTML('beforeend', smallNumStr)

areYouHappy = no

# Booleans have the value of (true, yes, or on) or (false, no, or off)
csOutput.insertAdjacentHTML('beforeend', 'areYouHappy is a Boolean<br>') if typeof areYouHappy is 'boolean'

# ---------- MATH ----------
csOutput.insertAdjacentHTML('beforeend',
  "5 + 2 = #{5 + 2}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "5 - 2 = #{5 - 2}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "5 * 2 = #{5 * 2}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "5 / 2 = #{5 / 2}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "5 % 2 = #{5 % 2}<br>")

# CS has 16 digits of precision
precisionTest = 0.1000000000000001;

csOutput.insertAdjacentHTML('beforeend',
  "Precision : #{precisionTest + 0.10000000000000011}<br>")

# Round to 2 digits
balance = 1563.87
csOutput.insertAdjacentHTML('beforeend',
  "Monthly Payment = #{(balance/12).toFixed(2)}<br>")

# Shortcut for adding 1
randNum = 5
csOutput.insertAdjacentHTML('beforeend',
  "randNum++ = #{randNum++}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "++randNum = #{++randNum}<br>")

# Shortcut for subtracting 1
randNum = 5
csOutput.insertAdjacentHTML('beforeend',
  "randNum-- = #{randNum--}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "--randNum = #{--randNum}<br>")

# Order of operations
csOutput.insertAdjacentHTML('beforeend',
  "3 + 2 * 5 = #{3 + 2 * 5}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "(3 + 2) * 5 = #{(3 + 2) * 5}<br>")

# Math properties and functions
csOutput.insertAdjacentHTML('beforeend',
  "Math.E = #{Math.E}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "Math.PI = #{Math.PI}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "Math.abs(-8) = #{Math.abs(-8)}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "Math.cbrt(1000) = #{Math.cbrt(1000)}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "Math.ceil(6.45) = #{Math.ceil(6.45)}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "Math.floor(6.45) = #{Math.floor(6.45)}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "Math.round(6.45) = #{Math.round(6.45)}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "Math.log(10) = #{Math.log(10)}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "Math.log10(10) = #{Math.log10(10)}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "Math.pow(4,2) = #{Math.pow(4,2)}<br>")

csOutput.insertAdjacentHTML('beforeend',
  "Math.sqrt(1000) = #{Math.sqrt(1000)}<br>")

# Generate a random number
randNum = Math.floor(Math.random() * 100) + 1

csOutput.insertAdjacentHTML('beforeend',
  "Random Number = #{randNum}<br>")

# ---------- STRINGS ----------

fName = "Derek"
lName = "Banas"

# You can combine Strings with a +
csOutput.insertAdjacentHTML('beforeend', fName + " " + lName + "<br>")

longString = "This is a long string that goes on forever"

# Get the String length
csOutput.insertAdjacentHTML('beforeend',
  "String Length : #{longString.length}<br>")

# Get the index of a matching string
csOutput.insertAdjacentHTML('beforeend',
  "Index of string : #{longString.indexOf("goes")}<br>")

# Get a character at an index
csOutput.insertAdjacentHTML('beforeend',
  "Index 8 : #{longString.charAt(8)}<br>")

# Get a substring
csOutput.insertAdjacentHTML('beforeend',
  "Word at 27 : #{longString.slice(27,31)}<br>")

# Get everything after an index
csOutput.insertAdjacentHTML('beforeend',
  "After 27 : #{longString.slice(27)}<br>")

# Replace a string with another
longString = longString.replace("forever", "and on forever   ")

csOutput.insertAdjacentHTML('beforeend',
  "New String : #{longString}<br>")

# Convert a string into an Array
strArray = longString.split(" ")

# Output an array
for x in strArray
  csOutput.insertAdjacentHTML('beforeend',
  "#{x}<br>")

# Trim whitespace
longString = longString.trim()

# Convert to all uppercase
csOutput.insertAdjacentHTML('beforeend',
  "#{longString.toUpperCase()}<br>")

# Convert to all lowercase
csOutput.insertAdjacentHTML('beforeend',
  "#{longString.toLowerCase()}<br>")

# ---------- CONDITIONALS ----------
# If works like JavaScript except with indentation and not curly brackets
# Comparison operators are ==, !=, >, <, >=, <=
# == and != in CS is the same as === and !== in JS

age = 3

if age >= 18
  # Insert text either beforebegin or beforeend
  csOutput.insertAdjacentHTML('beforeend', 'You can Vote<br>')
  if (age >= 16)
    csOutput.insertAdjacentHTML('beforeend', 'You can Drive also<br>')
else if (age >= 16)
  csOutput.insertAdjacentHTML('beforeend', 'You can Drive<br>')
else
  csOutput.insertAdjacentHTML('beforeend', 'You\'ll be 16 soon<br>')

# Unless executes if the test returns false

unless (age >= 19)
  csOutput.insertAdjacentHTML('beforeend', 'You are in school<br>')
else
  csOutput.insertAdjacentHTML('beforeend', 'You may go to college<br>')

# Logical operators are &&, || and !

hsGrad = true

if !(age > 4) || (age > 65)
  csOutput.insertAdjacentHTML('beforeend', 'You don\'t go to school<br>')
else if (age >= 5) && (age <= 6)
  csOutput.insertAdjacentHTML('beforeend', 'Go to Kindergarten<br>')
else if (age > 6) && (age <= 18)
  schoolGrade = "Go to Grade #{age - 5}<br>"
  csOutput.insertAdjacentHTML('beforeend', schoolGrade)
else
  csOutput.insertAdjacentHTML('beforeend', 'Go to Work<br>')

# Ternary operator
votingAge = if age > 18 then true else false
csOutput.insertAdjacentHTML('beforeend', "Can Vote : #{votingAge}<br>")

# Switch

childAge = 7

switch childAge
  when 5 then csOutput.insertAdjacentHTML('beforeend', 'Go to Kindergarten<br>')

  when 6, 7, 8, 9, 10 then csOutput.insertAdjacentHTML('beforeend', 'Go to Elementary School<br>')

  else csOutput.insertAdjacentHTML('beforeend', 'Go to Someplace<br>')

# Do something if the variable has a value
if age?
  csOutput.insertAdjacentHTML('beforeend',
    "#{age} years old<br>")

# The existential operator can also assign 1 value if it exists or
# another if not
chicken = null

chickenName = chicken ? "Fred"

csOutput.insertAdjacentHTML('beforeend',
    "Chickens Name : #{chickenName}<br>")

# We can stack conditions
hat = "Winter Hat"
coat = "Winter Coat"
gloves = null

# Only execute if we have a hat and coat
# If null output '?' instead of null
if hat? and coat?
  csOutput.insertAdjacentHTML('beforeend',
    "#{hat} #{coat} #{gloves ? '?'}<br>")
