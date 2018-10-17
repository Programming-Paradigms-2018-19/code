package MOP

class Icecream {
    def scoops = [:], notes = [], cone = ''

    def order(Closure closure) {
        closure.delegate = this
        closure()
    }

    String toString() {
        def string = "I am a delicious ice cream served in a $cone with \n"
        scoops.each {
            string += " - ${it.value} scoop${it.value > 1 ? 's' : ''} of ${it.key}\n"
        }
        string += "Additional Notes:\n"
        notes.each { string += " - ${it}\n" }
        return string
    }
}

String.metaClass.getDescore << { ->
    delegate.replace('_', ' ')
}

Icecream.metaClass.propertyMissing << { String name, args ->
//	println name
    def match = name =~ /(serve_in)_(.*)/
    if (match)
        delegate.cone = match.group(2).descore
    else
        notes << name.descore
}

Icecream.metaClass.add << { newScoops ->
//	println newScoops
    scoops.putAll(newScoops)
}

Integer.metaClass.propertyMissing << { name, args ->
//println name 
    def match = name =~ /(scoop(s)?)_of_(.*)/
    if (match)
        return [(match.group(3).descore): delegate]
}

def icecream = new Icecream()

icecream.order {
    serve_in_waffle_cone

    add(3.scoops_of_chocolate_chip)
    add(2.scoops_of_pistachio)
    add(1.scoop_of_vegemite)

    make_it_snappy
    use_a_left_handed_icecream_scoop
}

println icecream


