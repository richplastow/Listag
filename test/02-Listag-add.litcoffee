02 Listag::add()
================


    tudor.add [
      "02 Listag::add()"
      tudor.is




      "`add()` is a function which returns a string"

Prepare a test-instance. 

      -> [new Listag]


      "`add()` is a function"
      _o.F
      (listag) -> listag.add


      "`add({x:'the_first'})` returns a string"
      _o.S
      (listag) -> listag.add({x:'the_first'})




      "The `node` argument accepts objects as expected"
      tudor.equal


      "A simple object is recorded"
      'the_second'
      (listag) -> listag.add({x:'the_second'}); listag.last.all.x


      "A Listag instance can be recorded in itself"
      'the_second'
      (listag) -> listag.add(listag); listag.last.all.listagL.all.x


      "A Listag instance can be recorded in another Listag instance"
      null
      (listag) -> listag.add( new Listag ); listag.last.all.last.all


@todo more allowed objects




      "`node` exceptions"
      tudor.throw


      "`node` not provided"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument node is undefined and has no fallback"""
      (listag) -> listag.add()


      "`node` is null"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument node is type null not object"""
      (listag) -> listag.add null


      "`node` is a Date object"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument node is type date not object"""
      (listag) -> listag.add new Date()


@todo more objects exceptions




      "The `id` argument accepts a string as expected"
      tudor.equal


      "Shortest possible id"
      11
      (listag) ->
        listag.add {x:11}, 'aB'
        listag.last.all.x


      "Longest possible id"
      22
      (listag) ->
        listag.add {x:22}, 'abcdefghijklmnopqrst123_'
        listag.last.all.x


      "Can repeat existing id, if case is different"
      33
      (listag) ->
        listag.add {x:33}, 'aBcDeFgHiJkLmNoPqRsT123_'
        listag.last.all.x




      "`id` exceptions"
      tudor.throw


      "Is boolean"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument id is type boolean not string"""
      (listag) -> listag.add {}, true


      "Empty string"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument id fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.add {}, ''


      "Too short"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument id fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.add {}, 'a'


      "Too long"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument id fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.add {}, 'aBcDeFgHiJkLmNoPqRsT123_X'


      "Underscore is an invalid first character"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument id fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.add {}, '_abc'


      "Number is an invalid first character"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument id fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.add {}, '1abc'


      "Uppercase is an invalid first character"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument id fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.add {}, 'Abc'


      "Must not contain a hyphen"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument id fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.add {}, 'ab-c'


      "Must be unique"
      """
      /listag/src/Listag.litcoffee Listag::add()
        a node with id 'the_last' already exists"""
      (listag) ->
        listag.add {}, 'the_last'
        listag.add {}, 'the_last'




      "The `tags` argument accepts an array as expected"
      tudor.equal


      "An empty array"
      789
      (listag) -> listag.add({x:789}, 'abc', []); listag.last.all.x


      "An array with arbitrary properties"
      234
      (listag) ->
        tags = ['cat', 'dog']
        tags.thing = 'Unexpected!'
        listag.add({x:234}, 'def', tags); listag.last.all.x


      "Can be undefined"
      'second_from_last'
      (listag) ->
        listag.add({x:'second_from_last'}, 'ghi', undefined)
        listag.last.all.x


      "Can be null"
      'the_last'
      (listag) ->
        listag.add({x:'the_last'}, 'klm', null)
        listag.last.all.x




      "`tags` exceptions"
      tudor.throw


      "A string"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument tags is type string not array"""
      (listag) -> listag.add {}, undefined, 'nope'


      "Contains a number"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument tags[2] is type number not string"""
      (listag) -> listag.add {}, undefined, ['ok', 'fine', 123456, 'uh_oh']


      "Contains an empty string"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument tags[3] fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.add {}, undefined, ['no', 'empties', 'allowed', '']


      "Contains an invalid string"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument tags[0] fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.add {}, undefined, ['123abc', 'nope']




      "`length`, `first`, `last`, `listagL` and `listagR` as expected"
      tudor.equal


      "The first Item is 'the_first'"
      'the_first'
      (listag) -> listag.first.all.x

      "The last Item is 'the_last'"
      'the_last'
      (listag) -> listag.last.all.x

      "The first Item’s `listagL` is null"
      null
      (listag) -> listag.first.all.listagL.all

      "The last Item’s `listagR` is null"
      null
      (listag) -> listag.last.all.listagR.all

      "The first Item’s `listagR` is 'the_second'"
      'the_second'
      (listag) -> listag.first.all.listagR.all.x

      "The last Item’s `listagL` is 'second_from_last'"
      'second_from_last'
      (listag) -> listag.last.all.listagL.all.x




    ];


