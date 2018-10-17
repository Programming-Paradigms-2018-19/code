package MOP

class Marine {
    def yell() {
        return """${toString()} is my toString.
There are many like it but this is mine."""
    }
}

def m = new Marine()
println m.yell()


def marines = []

3.times {
    marines << new Marine()
}

def newMetaClass = new ExpandoMetaClass(marines[2].class)
newMetaClass.yell = { -> "I'm an individual" }
newMetaClass.initialize()
marines[2].metaClass = newMetaClass

for (x in marines)
    println x.yell()
