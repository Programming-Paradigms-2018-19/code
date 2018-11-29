class Person(val name:String)

trait Nice {
    def greet() = println("Hello world!")
}

class Character(override val name:String) extends Person(name) with Nice

object TraitMain extends App {
  val flanders = new Character("Ned")
  flanders.greet
}