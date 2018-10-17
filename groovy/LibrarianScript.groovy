package MOP

class Librarian {
    def methodMissing(String name, args) {
        println "Method $name with args $args"
        def match = name =~ /findBookBy(.*)/
        if (match) {
            def mission = "Find a book with a "
            mission += "${match.group(1).toLowerCase()}" +
                    " of ${args[0]}"
            println mission
        } else {
            throw new Exception("Method ${name} not found")
        }
    }
}

def lib = new Librarian()
lib.findBookByISBN("123456")
lib.findBookByTitle("oh....")
lib.findBook("ouch")
