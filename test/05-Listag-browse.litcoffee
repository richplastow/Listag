05 Listag::browse()
===================


    tudor.add [
      "05 Listag::browse()"
      tudor.is




      "`browse()` is a function which returns a string or an array"

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
      i..id.......type.....aa..bbbb
      1  the_1st  boolean  1   1   """
      (listag) ->
        listag.add true, 'the_1st', ['aa','bbbb']
        listag.browse()

@todo `config` which returns an array




      "The `config` argument accepts an object as expected"


      "Empty object"
      """
      i..id..........type.....aa..bbbb..ccc
      1  the_1st     boolean  1   1        
      2  the_second  number       2     1  
      3  third       array                 
      4  fourth      regexp             2  """
      (listag) ->
        listag.add 222, 'the_second', ['bbbb','ccc']
        listag.add [3], 'third'
        listag.add /4/, 'fourth',     ['ccc']
        listag.browse {}


      "Can contain arbitrary properties"
      """
      i..id..........type.....aa..bbbb..ccc
      1  the_1st     boolean  1   1        
      2  the_second  number       2     1  
      3  third       array                 
      4  fourth      regexp             2  """
      (listag) ->
        listag.browse { a:1, '-!•':'ok' }


      "Can be `null`"
      """
      i..id..........type.....aa..bbbb..ccc
      1  the_1st     boolean  1   1        
      2  the_second  number       2     1  
      3  third       array                 
      4  fourth      regexp             2  """
      (listag) ->
        listag.browse null


      "Can be `undefined`"
      """
      i..id..........type.....aa..bbbb..ccc
      1  the_1st     boolean  1   1        
      2  the_second  number       2     1  
      3  third       array                 
      4  fourth      regexp             2  """
      (listag) ->
        listag.browse undefined




      "`config` exceptions"
      tudor.throw


      "Is a regexp"
      """
      /listag/src/Listag.litcoffee Listag::browse()
        config is type regexp not object"""
      (listag) -> listag.browse /abc/


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
      i..id..........type....bbbb..ccc
      1  the_second  number  1     1  
      2  third       array            
      3  fourth      regexp        2  """
      (listag) ->
        listag.delete 'the_1st'
        listag.browse { format:'text' }


      "The string 'array'"
      """
      {"i":1,"id":"the_second","tags":{"bbbb":"1","ccc":"1","node":"1"},"type":"number"}
      {"i":2,"id":"third","tags":{"node":"2"},"type":"array"}
      {"i":3,"id":"fourth","tags":{"ccc":"2","node":"3"},"type":"regexp"}"""
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




      "`config.tags` usage"

      tudor.equal


      "An empty array"
      """
      i..id..........type....bbbb..ccc
      1  the_second  number  1     1  
      2  third       array            
      3  fourth      regexp        2  """
      (listag) ->
        listag.browse { tags:[] }


      "A single tag, text format"
      """
      i..id..........type....bbbb..ccc
      1  the_second  number  1     1  
      3  fourth      regexp        2  """
      (listag) ->
        listag.add true, 'the_1st', ['aa','bbbb']
        listag.browse { tags:['ccc'] }


      "A single tag, array format"
      """
      {"i":1,"id":"the_second","tags":{"bbbb":"1","ccc":"1","node":"1"},"type":"number"}
      {"i":3,"id":"fourth","tags":{"ccc":"2","node":"2"},"type":"regexp"}"""
      (listag) ->
        nodes = listag.browse { tags:['ccc'], format:'array' }
        out = ( JSON.stringify(node) for node in nodes )
        out.join '\n'


      "Two tags, text format"
      """
      i..id..........type.....aa..bbbb..ccc
      1  the_second  number       1     1  
      3  fourth      regexp             2  
      4  the_1st     boolean  1   2        """
      (listag) ->
        listag.browse { tags:['aa','ccc'] }


      "Two tags, array format"
      """
      {"i":1,"id":"the_second","tags":{"bbbb":"1","ccc":"1","node":"1"},"type":"number"}
      {"i":3,"id":"fourth","tags":{"ccc":"2","node":"2"},"type":"regexp"}
      {"i":4,"id":"the_1st","tags":{"aa":"1","bbbb":"2","node":"3"},"type":"boolean"}"""
      (listag) ->
        nodes = listag.browse { tags:['aa','ccc'], format:'array' }
        out = ( JSON.stringify(node) for node in nodes )
        out.join '\n'


      "Tag which does not exist, text format"
      '[no matches]'
      (listag) ->
        listag.browse { tags:['non_existant'] }


      "Tag which does not exist, array format"
      0
      (listag) ->
        nodes = listag.browse { tags:['non_existant'], format:'array' }
        nodes.length




      "`config.tags` exceptions"
      tudor.throw


      "Is number"
      """
      /listag/src/Listag.litcoffee Listag::browse()
        config.tags is type number not array"""
      (listag) -> listag.browse { tags:123 }






    ];

