package MOP

Integer.metaClass.getSeconds << { ->
    delegate * 1000
}

Integer.metaClass.getDays << { ->
    delegate.seconds * 60 * 60 * 24
}

Integer.metaClass.getWeeks << { ->
    delegate.days * 7
}

def waitFor(Integer[] mills) {
    println "Well, I'm not really going to wait " +
            "for ${GroovyCollections.sum(mills)} milliseconds"
}

waitFor(2.weeks, 5.days + 3.seconds)
