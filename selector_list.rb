class SelectorList


  attr_accessor :lista

  def initialize
    @lista = []

    def addSelector(aSelector)
      #agrega el selector a su lista.

      lista<<aSelector

    end

    def selectResponders(aList)
      #llega una lista de objetos,
      #tienen que devolver la sublista de los que entienden
      #todos los selectores registrados en el SelectorList

      result = []

      for tipo in aList
        for selector in lista

          result<<tipo if tipo.respond_to? selector

        end
      end
      puts result

    end

    def selectSelectorsFor(anObject)
      #llega un objeto,
      #tienen que devolver la sublista de los selectores registrados
      #en el SelectorList, de los que entiende el objeto
      lista.select{|selector| anObject.respond_to? selector}
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
  slist.selectResponders([fido,pepa,tutu,"hola",4])
  puts slist.selectSelectorsFor(fido) #no me muestra cuanto_come
  #slist.selectSelectorsFor(tutu) #bien
  #slist.selectSelectorsFor(4) #bien
  puts slist.valuesFor(fido)

end