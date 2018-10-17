package MOP

Integer.metaClass.getSausages << { ->
    def stringOfSausages = []
    delegate.times {
        stringOfSausages << 'sausage'
    }
    return stringOfSausages
}

println 3.sausages