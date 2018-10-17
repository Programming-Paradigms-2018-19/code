package MOP

def s = 3
println s.class

String.constructors.each { println it }

String.interfaces.each { println it }

def d = new Date()
d.properties.each { println it }