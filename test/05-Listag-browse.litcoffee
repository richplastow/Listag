05 Listag::browse()
===================


    tudor.add [
      "05 Listag::browse()"
      tudor.is




      "`browse()` is a function which returns a string" #@todo or an array

Prepare a test-instance. 

      -> [new Listag]


      "`browse()` is a function"
      oo.F
      (listag) -> listag.browse


      "`browse()` is not writable"
      oo.F
      (listag) ->
        listag.browse = 123
        listag.browse


      "`browse()` is not configurable"
      oo.F
      (listag) ->
        try
          Object.defineProperty listag, 'browse', { writable:true }
        catch e
        listag.browse = 'nope'
        listag.browse


      "`browse()` cannot be replaced by another method using `prototype`"
      oo.S
      ->
        Listag::browse = -> false
        (new Listag).browse() # `(new Listag)` in case `browse='nope'` succeeded


      "`browse()` cannot be replaced by another method using direct-access"
      oo.S
      (listag) ->
        listag.browse = -> []
        listag.browse()


      "`browse()` returns a string"
      oo.S
      (listag) ->
        listag.browse()


      "`browse({format:'array'})` returns an array"
      oo.A
      (listag) ->
        listag.browse { format:'array' }


      tudor.equal


      "For an empty Listag instance, `browse()` returns the string '[empty]'"
      '[empty]'
      (listag) ->
        listag.browse()


      "If empty, `browse({format:'array'})` returns an empty array"
      0
      (listag) ->
        (listag.browse { format:'array' }).length


      "For a populated Listag instance, `browse()` returns a table, as a string"
      """
      ..................aa..bbbb
      the_1st  boolean  x   x   """
      (listag) ->
        listag.add true, 'the_1st', ['aa','bbbb']
        listag.browse()

@todo `config` which returns an array




      "The `config` argument accepts an object as expected"


      "Empty object"
      """
      .....................aa..bbbb..ccc
      the_1st     boolean  x   x        
      the_second  number       x     x  
      third       array                 
      fourth      regexp             x  """
      (listag) ->
        listag.add 222, 'the_second', ['bbbb','ccc']
        listag.add [3], 'third'
        listag.add /4/, 'fourth',     ['ccc']
        listag.browse {}


      "Can contain arbitrary properties"
      """
      .....................aa..bbbb..ccc
      the_1st     boolean  x   x        
      the_second  number       x     x  
      third       array                 
      fourth      regexp             x  """
      (listag) ->
        listag.browse { a:1, '-!•':'ok' }


      "Can be `null`"
      """
      .....................aa..bbbb..ccc
      the_1st     boolean  x   x        
      the_second  number       x     x  
      third       array                 
      fourth      regexp             x  """
      (listag) ->
        listag.browse null


      "Can be `undefined`"
      """
      .....................aa..bbbb..ccc
      the_1st     boolean  x   x        
      the_second  number       x     x  
      third       array                 
      fourth      regexp             x  """
      (listag) ->
        listag.browse undefined




      "`config` exceptions"
      tudor.throw


      "Is boolean"
      """
      /listag/src/Listag.litcoffee Listag::browse()
        config is type boolean not object"""
      (listag) -> listag.browse true


      "Is an array"
      """
      /listag/src/Listag.litcoffee Listag::browse()
        config is type array not object"""
      (listag) -> listag.browse [1,2,3]




      "`config.format` usage"

      tudor.equal


      "The string 'text'"
      """
      ....................bbbb..ccc
      the_second  number  x     x  
      third       array            
      fourth      regexp        x  """
      (listag) ->
        listag.delete 'the_1st'
        listag.browse { format:'text' }


      "The string 'array'"
      """
      {"id":"the_second","tags":{"bbbb":"x","ccc":"x","node":"x"},"type":"number"}
      {"id":"third","tags":{"node":"x"},"type":"array"}
      {"id":"fourth","tags":{"ccc":"x","node":"x"},"type":"regexp"}"""
      (listag) ->
        nodes = listag.browse { format:'array' }
        out = ( JSON.stringify(node) for node in nodes )
        out.join '\n'




      "`config.format` exceptions"
      tudor.throw


      "Is number"
      """
      /listag/src/Listag.litcoffee Listag::browse()
        config.format is type number not string"""
      (listag) -> listag.browse { format:123 }


      "Is RegExp"
      """
      /listag/src/Listag.litcoffee Listag::browse()
        config.format is type regexp not string"""
      (listag) -> listag.browse { format:/text/ }


      "Is empty string"
      """
      /listag/src/Listag.litcoffee Listag::browse()
        config.format fails ^text|array$"""
      (listag) -> listag.browse { format:'' }


      "Is an invalid string"
      """
      /listag/src/Listag.litcoffee Listag::browse()
        config.format fails ^text|array$"""
      (listag) -> listag.browse { format:'Text' }





    ];

