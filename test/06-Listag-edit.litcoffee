06 Listag::edit()
=================


    tudor.add [
      "06 Listag::edit()"
      tudor.is




      "`edit()` is a function which returns a string" #@todo or an array

Prepare a test-instance. 

      -> [new Listag]


      "`edit()` is a function"
      oo.F
      (listag) -> listag.edit


      "`edit()` is not writable"
      oo.F
      (listag) ->
        listag.edit = 123
        listag.edit


      "`edit()` is not configurable"
      oo.F
      (listag) ->
        try
          Object.defineProperty listag, 'edit', { writable:true }
        catch e
        listag.edit = 'nope'
        listag.edit


      "`edit()` cannot be replaced by another method using `prototype`"
      oo.U
      ->
        Listag::edit = -> 123
        listag = (new Listag) # `(new Listag)` in case `edit='nope'` succeeded
        listag.add (new Date), 'the_first'
        listag.edit 'the_first'


      "`edit()` cannot be replaced by another method using direct-access"
      oo.U
      (listag) ->
        listag.edit = -> []
        listag.add 22, 'the_first'
        listag.edit 'the_first'


      "`edit('the_first')` returns `undefined`"
      oo.U
      (listag) ->
        listag.edit 'the_first'


      "The `config` argument can be an empty object"
      oo.U
      (listag) ->
        listag.edit 'the_first', {}




      "`config.cargo` replaces the node’s current cargo"
      tudor.equal

      "`config.cargo` can be changed from a number to boolean `false`"
      false
      (listag) ->
        listag.edit 'the_first', { cargo:false }
        listag.read 'the_first'

      "`config.cargo` can be changed from boolean `false` to the number `123`"
      123
      (listag) ->
        listag.edit 'the_first', { cargo:123 }
        listag.read 'the_first'

      "If `config.cargo` is not set, it remains `123`"
      123
      (listag) ->
        listag.edit 'the_first', {}
        listag.read 'the_first'

      "`config.cargo` can be changed to `undefined`"
      """
      id.........type.....
      the_first  undefined"""
      (listag) ->
        listag.edit 'the_first', { cargo:undefined }
        listag.browse()




      "`id` exceptions"
      tudor.throw


      "Is boolean"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        argument id is type boolean not string"""
      (listag) -> listag.edit true


      "Too short"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        argument id fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.edit 'a'


      "Too long"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        argument id fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.edit 'aBcDeFgHiJkLmNoPqRsT123_X'


      "Underscore is an invalid first character"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        argument id fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.edit '_abc'


      "Number is an invalid first character"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        argument id fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.edit '1abc'


      "Uppercase is an invalid first character"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        argument id fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.edit 'Abc'


      "Must not contain a hyphen"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        argument id fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.edit 'ab-c'


      "Does not exist"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        the node with id 'non_existant' does not exist"""
      (listag) ->
        listag.edit 'non_existant'




      "`config.tags` accepts an array as expected"
      tudor.equal


      "Straightforward addition of a single tag"
      """
      id.........type.......aa
      the_first  undefined  x 
      node:1 aa:1 bb:0 cc:0"""
      (listag) ->
        listag.edit 'the_first', { tags:['aa'] }
        listag.browse() + '\n' + 
          'node:' + listag.total.node + ' aa:' + (listag.total.aa||0) + ' bb:' + (listag.total.bb||0) + ' cc:' + (listag.total.cc||0)


      "Without a `config.tags` property, nothing changes"
      """
      id.........type.......aa
      the_first  undefined  x 
      node:1 aa:1 bb:0 cc:0"""
      (listag) ->
        listag.edit 'the_first', {}
        listag.browse() + '\n' + 
          'node:' + listag.total.node + ' aa:' + (listag.total.aa||0) + ' bb:' + (listag.total.bb||0) + ' cc:' + (listag.total.cc||0)


      "With an empty `config.tags` array, no tags remain"
      """
      id.........type.....
      the_first  undefined
      node:1 aa:0 bb:0 cc:0"""
      (listag) ->
        listag.edit 'the_first', { tags:[] }
        listag.browse() + '\n' + 
          'node:' + listag.total.node + ' aa:' + (listag.total.aa||0) + ' bb:' + (listag.total.bb||0) + ' cc:' + (listag.total.cc||0)


      "Two tags can be added at once (also, changing cargo during edit)"
      """
      id.........type....aa..bb
      the_first  number  x   x 
      node:1 aa:1 bb:1 cc:0

      head.node: the_first
      tail.node: the_first
      head.aa:   the_first
      tail.aa:   the_first
      head.bb:   the_first
      tail.bb:   the_first
      head.cc:   undefined
      tail.cc:   undefined

      head.node.next.aa:     null
      tail.node.next.aa:     null
      head.node.previous.aa: null
      tail.node.previous.aa: null
      head.node.next.bb:     null
      tail.node.next.bb:     null
      head.node.previous.bb: null
      tail.node.previous.bb: null
      head.node.next.cc:     undefined
      tail.node.next.cc:     undefined
      head.node.previous.cc: undefined
      tail.node.previous.cc: undefined""" + '\n'
      (listag) ->
        summary = (node) -> (if node then node.id else node) + '\n'
        listag.edit 'the_first', { cargo:1, tags:['aa', 'bb'] }
        listag.browse() + '\n' + 
          'node:' + listag.total.node + ' aa:' + (listag.total.aa||0) + ' bb:' + (listag.total.bb||0) + ' cc:' + (listag.total.cc||0) + '\n\n' +
          'head.node: '             + summary(listag.head.node) +
          'tail.node: '             + summary(listag.tail.node) +
          'head.aa:   '             + summary(listag.head.aa) +
          'tail.aa:   '             + summary(listag.tail.aa) +
          'head.bb:   '             + summary(listag.head.bb) +
          'tail.bb:   '             + summary(listag.tail.bb) +
          'head.cc:   '             + summary(listag.head.cc) +
          'tail.cc:   '             + summary(listag.tail.cc) + '\n' +
          'head.node.next.aa:     ' + summary(listag.head.node.next.aa) +
          'tail.node.next.aa:     ' + summary(listag.tail.node.next.aa) +
          'head.node.previous.aa: ' + summary(listag.head.node.previous.aa) +
          'tail.node.previous.aa: ' + summary(listag.tail.node.previous.aa) +
          'head.node.next.bb:     ' + summary(listag.head.node.next.bb) +
          'tail.node.next.bb:     ' + summary(listag.tail.node.next.bb) +
          'head.node.previous.bb: ' + summary(listag.head.node.previous.bb) +
          'tail.node.previous.bb: ' + summary(listag.tail.node.previous.bb) +
          'head.node.next.cc:     ' + summary(listag.head.node.next.cc) +
          'tail.node.next.cc:     ' + summary(listag.tail.node.next.cc) +
          'head.node.previous.cc: ' + summary(listag.head.node.previous.cc) +
          'tail.node.previous.cc: ' + summary(listag.tail.node.previous.cc)


      "Removal of a single tag - was `['aa', 'bb']`, now `['bb']`"
      """
      id.........type....bb
      the_first  number  x 
      node:1 aa:0 bb:1 cc:0"""
      (listag) ->
        listag.edit 'the_first', { tags:['bb'] }
        listag.browse() + '\n' + 
          'node:' + listag.total.node + ' aa:' + (listag.total.aa||0) + ' bb:' + (listag.total.bb||0) + ' cc:' + (listag.total.cc||0)


      "Without a `config.tags` property (but changing cargo), tags do not change"
      """
      id.........type....bb
      the_first  string  x 
      node:1 aa:0 bb:1 cc:0"""
      (listag) ->
        listag.edit 'the_first', { cargo:'ok' }
        listag.browse() + '\n' + 
          'node:' + listag.total.node + ' aa:' + (listag.total.aa||0) + ' bb:' + (listag.total.bb||0) + ' cc:' + (listag.total.cc||0)


      "With an empty `config.tags` array (but changing cargo), no tags remain"
      """
      id.........type..
      the_first  number
      node:1 aa:0 bb:0 cc:0"""
      (listag) ->
        listag.edit 'the_first', { cargo:123, tags:[] }
        listag.browse() + '\n' + 
          'node:' + listag.total.node + ' aa:' + (listag.total.aa||0) + ' bb:' + (listag.total.bb||0) + ' cc:' + (listag.total.cc||0)


      "An array with arbitrary properties - also, added another node"
      """
      id..........type....aa..bb..cc
      the_first   number  x   x     
      the_second  number  x       x 
      node:2 aa:2 bb:1 cc:1

      head.node: the_first
      tail.node: the_second
      head.aa:   the_first
      tail.aa:   the_second
      head.bb:   the_first
      tail.bb:   the_first
      head.cc:   the_second
      tail.cc:   the_second

      head.node.next.aa:     the_second
      tail.node.next.aa:     null
      head.node.previous.aa: null
      tail.node.previous.aa: the_first
      head.node.next.bb:     null
      tail.node.next.bb:     undefined
      head.node.previous.bb: null
      tail.node.previous.bb: undefined
      head.node.next.cc:     undefined
      tail.node.next.cc:     null
      head.node.previous.cc: undefined
      tail.node.previous.cc: null""" + '\n'
      (listag) ->
        summary = (node) -> (if node then node.id else node) + '\n'
        tags = ['aa', 'bb']
        tags.thing = 'Unexpected!'
        listag.edit 'the_first', { tags:tags }
        listag.add 55, 'the_second', ['aa','cc']
        listag.browse() + '\n' + 
          'node:' + listag.total.node + ' aa:' + (listag.total.aa||0) + ' bb:' + (listag.total.bb||0) + ' cc:' + (listag.total.cc||0) + '\n\n' +
          'head.node: '             + summary(listag.head.node) +
          'tail.node: '             + summary(listag.tail.node) +
          'head.aa:   '             + summary(listag.head.aa) +
          'tail.aa:   '             + summary(listag.tail.aa) +
          'head.bb:   '             + summary(listag.head.bb) +
          'tail.bb:   '             + summary(listag.tail.bb) +
          'head.cc:   '             + summary(listag.head.cc) +
          'tail.cc:   '             + summary(listag.tail.cc) + '\n' +
          'head.node.next.aa:     ' + summary(listag.head.node.next.aa) +
          'tail.node.next.aa:     ' + summary(listag.tail.node.next.aa) +
          'head.node.previous.aa: ' + summary(listag.head.node.previous.aa) +
          'tail.node.previous.aa: ' + summary(listag.tail.node.previous.aa) +
          'head.node.next.bb:     ' + summary(listag.head.node.next.bb) +
          'tail.node.next.bb:     ' + summary(listag.tail.node.next.bb) +
          'head.node.previous.bb: ' + summary(listag.head.node.previous.bb) +
          'tail.node.previous.bb: ' + summary(listag.tail.node.previous.bb) +
          'head.node.next.cc:     ' + summary(listag.head.node.next.cc) +
          'tail.node.next.cc:     ' + summary(listag.tail.node.next.cc) +
          'head.node.previous.cc: ' + summary(listag.head.node.previous.cc) +
          'tail.node.previous.cc: ' + summary(listag.tail.node.previous.cc) +
          ''


      "After editing a node’s tags, `head`, `tail`, `previous` and `next` are as expected"
      """
      id..........type....aa..bb..cc
      the_first   number  x   x     
      the_second  number      x   x 
      node:2 aa:1 bb:2 cc:1

      head.node: the_first
      tail.node: the_second
      head.aa:   the_first
      tail.aa:   the_first
      head.bb:   the_first
      tail.bb:   the_second
      head.cc:   the_second
      tail.cc:   the_second

      head.node.next.aa:     null
      tail.node.next.aa:     undefined
      head.node.previous.aa: null
      tail.node.previous.aa: undefined
      head.node.next.bb:     the_second
      tail.node.next.bb:     null
      head.node.previous.bb: null
      tail.node.previous.bb: the_first
      head.node.next.cc:     undefined
      tail.node.next.cc:     null
      head.node.previous.cc: undefined
      tail.node.previous.cc: null""" + '\n'
      (listag) ->
        summary = (node) -> (if node then node.id else node) + '\n'
        listag.edit 'the_second', { tags:['bb','cc'] }
        listag.browse() + '\n' + 
          'node:' + listag.total.node + ' aa:' + (listag.total.aa||0) + ' bb:' + (listag.total.bb||0) + ' cc:' + (listag.total.cc||0) + '\n\n' +
          'head.node: '             + summary(listag.head.node) +
          'tail.node: '             + summary(listag.tail.node) +
          'head.aa:   '             + summary(listag.head.aa) +
          'tail.aa:   '             + summary(listag.tail.aa) +
          'head.bb:   '             + summary(listag.head.bb) +
          'tail.bb:   '             + summary(listag.tail.bb) +
          'head.cc:   '             + summary(listag.head.cc) +
          'tail.cc:   '             + summary(listag.tail.cc) + '\n' +
          'head.node.next.aa:     ' + summary(listag.head.node.next.aa) +
          'tail.node.next.aa:     ' + summary(listag.tail.node.next.aa) +
          'head.node.previous.aa: ' + summary(listag.head.node.previous.aa) +
          'tail.node.previous.aa: ' + summary(listag.tail.node.previous.aa) +
          'head.node.next.bb:     ' + summary(listag.head.node.next.bb) +
          'tail.node.next.bb:     ' + summary(listag.tail.node.next.bb) +
          'head.node.previous.bb: ' + summary(listag.head.node.previous.bb) +
          'tail.node.previous.bb: ' + summary(listag.tail.node.previous.bb) +
          'head.node.next.cc:     ' + summary(listag.head.node.next.cc) +
          'tail.node.next.cc:     ' + summary(listag.tail.node.next.cc) +
          'head.node.previous.cc: ' + summary(listag.head.node.previous.cc) +
          'tail.node.previous.cc: ' + summary(listag.tail.node.previous.cc) +
          ''


      "More tag editing still produces proper `head`, `tail`, `previous` and `next`"
      """
      id..........type....aa..bb..cc
      the_first   number  x       x 
      the_second  number      x   x 
      node:2 aa:1 bb:1 cc:2

      head.node: the_first
      tail.node: the_second
      head.aa:   the_first
      tail.aa:   the_first
      head.bb:   the_second
      tail.bb:   the_second
      head.cc:   the_first
      tail.cc:   the_second

      head.node.next.aa:     null
      tail.node.next.aa:     undefined
      head.node.previous.aa: null
      tail.node.previous.aa: undefined
      head.node.next.bb:     undefined
      tail.node.next.bb:     null
      head.node.previous.bb: undefined
      tail.node.previous.bb: null
      head.node.next.cc:     the_second
      tail.node.next.cc:     null
      head.node.previous.cc: null
      tail.node.previous.cc: the_first""" + '\n'
      (listag) ->
        summary = (node) -> (if node then node.id else node) + '\n'
        listag.edit 'the_first' , { tags:[] }
        listag.edit 'the_first' , { tags:['aa','cc'] }
        listag.browse() + '\n' + 
          'node:' + listag.total.node + ' aa:' + (listag.total.aa||0) + ' bb:' + (listag.total.bb||0) + ' cc:' + (listag.total.cc||0) + '\n\n' +
          'head.node: '             + summary(listag.head.node) +
          'tail.node: '             + summary(listag.tail.node) +
          'head.aa:   '             + summary(listag.head.aa) +
          'tail.aa:   '             + summary(listag.tail.aa) +
          'head.bb:   '             + summary(listag.head.bb) +
          'tail.bb:   '             + summary(listag.tail.bb) +
          'head.cc:   '             + summary(listag.head.cc) +
          'tail.cc:   '             + summary(listag.tail.cc) + '\n' +
          'head.node.next.aa:     ' + summary(listag.head.node.next.aa) +
          'tail.node.next.aa:     ' + summary(listag.tail.node.next.aa) +
          'head.node.previous.aa: ' + summary(listag.head.node.previous.aa) +
          'tail.node.previous.aa: ' + summary(listag.tail.node.previous.aa) +
          'head.node.next.bb:     ' + summary(listag.head.node.next.bb) +
          'tail.node.next.bb:     ' + summary(listag.tail.node.next.bb) +
          'head.node.previous.bb: ' + summary(listag.head.node.previous.bb) +
          'tail.node.previous.bb: ' + summary(listag.tail.node.previous.bb) +
          'head.node.next.cc:     ' + summary(listag.head.node.next.cc) +
          'tail.node.next.cc:     ' + summary(listag.tail.node.next.cc) +
          'head.node.previous.cc: ' + summary(listag.head.node.previous.cc) +
          'tail.node.previous.cc: ' + summary(listag.tail.node.previous.cc) +
          ''




      "`tags` exceptions"
      tudor.throw


      "A string"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        config.tags is type string not array"""
      (listag) -> listag.edit 'the_first', { tags:'nope' }


      "Contains a number"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        config.tags[2] is type number not string"""
      (listag) -> listag.edit 'the_first', { tags:['ok', 'fine', 123456, 'uh_oh']}


      "Contains an empty string"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        config.tags[3] fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.edit 'the_first', { tags:['no', 'empties', 'allowed', '']}


      "Contains a string starting with a digit"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        config.tags[0] fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.edit 'the_first', { tags:['123abc', 'nope']}


      "Contains a string starting with an uppercase letter"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        config.tags[3] fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.edit 'the_first', { tags:['must', 'be', 'only', 'Lowercase']}


      "Contains the special string 'node'"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        config.tags[0] is the special tag 'node'"""
      (listag) -> listag.edit 'the_first', { tags:['node', 'is', 'reserved']}


      "Contains duplicate tags at indices 1 and 3"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        config.tags[3] is a duplicate of config.tags[1]"""
      (listag) -> listag.edit 'the_first', { tags:['here', 'again', 'there', 'again']}


      "Contains many duplicate tags, including indices 0 and 2"
      """
      /listag/src/Listag.litcoffee Listag::edit()
        config.tags[2] is a duplicate of config.tags[0]"""
      (listag) -> listag.edit 'the_first', { tags:['aa', 'bb', 'aa', 'aa', 'bb']}


    ];

