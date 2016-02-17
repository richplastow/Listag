03 Listag::read()
=================


    tudor.add [
      "03 Listag::read()"
      tudor.is




      "`read()` is a function which returns an object"

Prepare a test-instance. 

      -> [new Listag]


      "`read()` is a function"
      _o.F
      (listag) -> listag.read


      "`read('the_first')` returns an object"
      _o.O
      (listag) ->
        listag.add {x:'ok'}, 'the_first'
        listag.read 'the_first'



    ];


