07 Listag::each()
=================


    tudor.add [
      "07 Listag::each()"
      tudor.is




      "`each()` is a function which returns a xx"

Prepare a test-instance. 

      -> [new Listag, {}]


      "`each()` is a function"
      oo.F
      (listag) -> listag.each


      "`each()` is not writable"
      oo.F
      (listag) ->
        listag.each = 123
        listag.each


      "`each()` is not configurable"
      oo.F
      (listag) ->
        try
          Object.defineProperty listag, 'each', { writable:true }
        catch e
        listag.each = 'nope'
        listag.each


      "`each()` cannot be replaced by another method using `prototype`"
      oo.U
      ->
        Listag::each = -> 123
        listag = (new Listag) # `(new Listag)` in case `each='nope'` succeeded
        listag.each()


      "`each()` cannot be replaced by another method using direct-access"
      oo.U
      (listag) ->
        listag.each = -> []
        listag.each()


      "`each()` returns `undefined`"
      oo.U
      (listag) ->
        listag.each()


      tudor.equal


      "`each()` with a single node, containing a function as its cargo"
      1
      (listag, ctx) ->
        ctx.runTally = 0
        listag.add (() -> ctx.runTally++), 'the_1st'
        listag.each()
        ctx.runTally


      "`each()` with three nodes, all containing functions as cargo"
      134
      (listag, ctx) ->
        ctx.runTally = 0
        listag.add (() -> ctx.runTally+=10) , 'the_2nd'
        listag.add (() -> ctx.runTally+=123), 'the_3rd'
        listag.each()
        ctx.runTally




    ];

