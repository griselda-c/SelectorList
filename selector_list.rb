class SelectorList


  attr_accessor :selectores

  def initialize
    @selectores = []

    def addSelector(aSelector)
      #agrega el selector a su lista.

      selectores<<aSelector

    end

    def selectResponders(aList)
      #llega una lista de objetos,
      #tienen que devolver la sublista de los que entienden
      #todos los selectores registrados en el SelectorList

      aList.select{|objeto| self.selectSelectorsFor(objeto).size == selectores.size}

    end

    def selectSelectorsFor(anObject)
      #llega un objeto,
      #tienen que devolver la sublista de los selectores registrados
      #en el SelectorList, de los que entiende el objeto
      selectores.select{|selector| anObject.respond_to? selector}
    end

    def valuesFor(anObject)
      #llega un objeto,
      #tienen que devolver una lista con el resultado
      #de enviarle cada mensaje que tengo en mi lista y que entiende el objeto
      lista =self.selectSelectorsFor(anObject)
      lista.map{|selector| anObject.send(selector)}
    end



  end

end

class Animal
  attr_accessor :cuanto_come, :velocidad
end

class Perro < Animal
end

class Tortuga < Animal
end

class Auto
  attr_accessor :velocidad
end


if __FILE__ == $0
  slist = SelectorList.new
  slist.addSelector(:velocidad)
  slist.addSelector(:cuanto_come)

  fido = Perro.new
  fido.cuanto_come =3
  pepa = Tortuga.new
  tutu = Auto.new

  slist2 = SelectorList.new
  slist2.addSelector(:size)
  slist2.addSelector(:cuantoCome)
  slist2.addSelector(:empty?)

 puts slist.selectResponders([fido,pepa,tutu,"hola",4])
  puts slist.selectSelectorsFor(fido)
  #slist.selectSelectorsFor(tutu) #bien
  #slist.selectSelectorsFor(4) #bien
  puts slist.valuesFor(fido)

end