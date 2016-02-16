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
      100
      (listag) ->
        secondListag = new Listag
        secondListag.x = 100
        listag.add(secondListag)
        listag.last.all.x


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
      'leftmost_dog'
      (listag) ->
        tags = ['dog', 'ok123']
        tags.thing = 'Unexpected!'
        listag.add({x:'leftmost_dog'}, undefined, tags); listag.last.all.x


      "Can be mixed-case 'aLL'"
      'rightmost_dog'
      (listag) ->
        listag.add({x:'rightmost_dog'}, 'rightmost_dog', ['cat', 'dog', 'aLL'])
        listag.last.all.x


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


      "Contains a string starting with a digit"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument tags[0] fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.add {}, undefined, ['123abc', 'nope']


      "Contains a string starting with an uppercase letter"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument tags[3] fails ^[a-z]\\w{1,23}$"""
      (listag) -> listag.add {}, undefined, ['must', 'be', 'only', 'Lowercase']


      "Contains the special string 'all'"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument tags[0] is the special tag 'all'"""
      (listag) -> listag.add {}, undefined, ['all', 'is', 'reserved']


      "Contains duplicate tags at indices 1 and 3"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument tags[3] is a duplicate of tags[1]"""
      (listag) -> listag.add {}, undefined, ['here', 'again', 'there', 'again']


      "Contains many duplicate tags, including indices 0 and 2"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument tags[2] is a duplicate of tags[0]"""
      (listag) -> listag.add {}, undefined, ['aa', 'bb', 'aa', 'aa', 'bb']




      "'all' `length`, `first`, `last`, `listagL` and `listagR` as expected"
      tudor.equal


      "13 nodes created during the '02 Listag::add()' test"
      13
      (listag) -> listag.length.all

      "Traversing rightward from `first` takes 13 steps"
      13
      (listag) ->
        i = 0
        node = listag.first.all
        while node
          i++
          node = node.listagR.all
        i

      "Traversing leftward from `last` takes 13 steps"
      13
      (listag) ->
        i = 0
        node = listag.last.all
        while node
          i++
          node = node.listagL.all
        i

      "Traversing rightward from `aB` takes 9 steps"
      9
      (listag) ->
        i = 0
        node = listag.nodes.aB
        while node
          i++
          node = node.listagR.all
        i

      "The leftmost node is 'the_first'"
      'the_first'
      (listag) -> listag.first.all.x

      "The rightmost node is 'the_last'"
      'the_last'
      (listag) -> listag.last.all.x

      "The leftmost node’s leftward node is null"
      null
      (listag) -> listag.first.all.listagL.all

      "The rightmost node’s rightward node is null"
      null
      (listag) -> listag.last.all.listagR.all

      "The leftmost node’s `listagR.all` is 'the_second'"
      'the_second'
      (listag) -> listag.first.all.listagR.all.x

      "The rightmost node’s `listagL.all` is 'second_from_last'"
      'second_from_last'
      (listag) ->
        listag.last.all.listagL.all.x




      "'dog' `length`, `first`, `last`, `listagL` and `listagR` as expected"

      "2 'dog' nodes created during the '02 Listag::add()' test"
      2
      (listag) -> listag.length.dog

      "Traversing dogs rightward from the leftmost dog takes 2 steps"
      2
      (listag) ->
        i = 0
        node = listag.first.dog
        while node
          i++
          node = node.listagR.dog
        i

      "Traversing dogs leftward from the rightmost dog takes 2 steps"
      2
      (listag) ->
        i = 0
        node = listag.last.dog
        while node
          i++
          node = node.listagL.dog
        i

      "Traversing dogs rightward from `rightmost_dog` takes 1 steps"
      1
      (listag) ->
        i = 0
        node = listag.nodes.rightmost_dog
        _o 
        while node
          i++
          node = node.listagR.dog
        i

      "The leftmost dog node is 'leftmost_dog'"
      'leftmost_dog'
      (listag) -> listag.first.dog.x

      "The rightmost dog node is 'rightmost_dog'"
      'rightmost_dog'
      (listag) -> listag.last.dog.x

      "The leftmost dog’s leftward dog is null"
      null
      (listag) -> listag.first.dog.listagL.dog

      "The rightmost dog’s rightward dog is null"
      null
      (listag) -> listag.last.dog.listagR.dog

      "The leftmost dog’s `listagR.dog` is 'rightmost_dog'"
      'rightmost_dog'
      (listag) -> listag.first.dog.listagR.dog.x

      "The rightmost dog’s `listagL.dog` is 'leftmost_dog'"
      'leftmost_dog'
      (listag) ->
        listag.last.dog.listagL.dog.x

    ];


