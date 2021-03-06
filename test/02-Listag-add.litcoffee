02 Listag::add()
================


    tudor.add [
      "02 Listag::add()"
      tudor.is




      "`add()` is a function which returns a string"

Prepare a test-instance. 

      -> [new Listag]


      "`add()` is a function"
      oo.F
      (listag) -> listag.add


      "`add({x:'the_first'})` returns a string"
      oo.S
      (listag) -> listag.add {x:'the_first'}

      tudor.equal

      "The returned string is the same as the `id` argument"
      'passed_an_id_argument'
      (listag) -> listag.add {x:'the_second'}, 'passed_an_id_argument'

      "If no `id` argument is passed, an id is generated"
      true
      (listag) ->
        /^id_[a-zA-Z0-9]{8}$/.test listag.add {}




      "The `node` argument accepts objects as expected"


      "A simple object can be recorded"
      'simple_object'
      (listag) -> listag.add({x:'simple_object'}); listag.tail.node.cargo.x


      "A Listag instance can be recorded in itself"
      'simple_object'
      (listag) -> listag.add(listag); listag.tail.node.previous.node.cargo.x


      "A Listag instance can be recorded in another Listag instance"
      'obj_in_subListag'
      (listag) ->
        subListag = new Listag
        subListag.add {x:'obj_in_subListag'}
        listag.add(subListag)
        listag.tail.node.cargo.tail.node.cargo.x


@todo more allowed node objects, and also other types




      "The `id` argument accepts a string as expected"
      tudor.equal


      "Shortest possible id"
      11
      (listag) ->
        listag.add {x:11}, 'aB'
        listag.tail.node.cargo.x


      "Longest possible id"
      22
      (listag) ->
        listag.add {x:22}, 'abcdefghijklmnopqrst123_'
        listag.tail.node.cargo.x


      "Can repeat existing id, if case is different"
      33
      (listag) ->
        listag.add {x:33}, 'aBcDeFgHiJkLmNoPqRsT123_'
        listag.tail.node.cargo.x


      "Can be empty string (id is autogenerated)"
      44
      (listag) ->
        listag.add {x:44}, ''
        listag.tail.node.cargo.x




      "`id` exceptions"
      tudor.throw


      "Is boolean"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument id is type boolean not string"""
      (listag) -> listag.add {}, true


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
      (listag) -> listag.add({x:789}, 'abc', []); listag.tail.node.cargo.x


      "An array with arbitrary properties"
      'leftmost_dog'
      (listag) ->
        tags = ['dog', 'ok123']
        tags.thing = 'Unexpected!'
        listag.add({x:'leftmost_dog'}, undefined, tags); listag.tail.node.cargo.x


      "Can be mixed-case 'aLL'"
      'rightmost_dog'
      (listag) ->
        listag.add({x:'rightmost_dog'}, 'rightmost_dog', ['cat', 'dog', 'aLL'])
        listag.tail.node.cargo.x


      "Can be undefined"
      'second_from_last'
      (listag) ->
        listag.add({x:'second_from_last'}, 'ghi', undefined)
        listag.tail.node.cargo.x


      "Can be null"
      'the_last'
      (listag) ->
        listag.add({x:'the_last'}, 'klm', null)
        listag.tail.node.cargo.x




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


      "Contains the special string 'node'"
      """
      /listag/src/Listag.litcoffee Listag::add()
        argument tags[0] is the special tag 'node'"""
      (listag) -> listag.add {}, undefined, ['node', 'is', 'reserved']


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




      "'node' `total`, `head`, `tail`, `previous` and `next` as expected"
      tudor.equal


      "16 nodes created during the '02 Listag::add()' test"
      16
      (listag) -> listag.total.node

      "5 tags created during the '02 Listag::add()' test"
      5
      (listag) -> Object.keys(listag.total).length

      "Traversing rightward from `head` takes 16 steps"
      16
      (listag) ->
        i = 0
        node = listag.head.node
        while node
          i++
          node = node.next.node
        i

      "Traversing leftward from `tail` takes 16 steps"
      16
      (listag) ->
        i = 0
        node = listag.tail.node
        while node
          i++
          node = node.previous.node
        i

      "Traversing rightward from `aB` takes 10 steps"
      10
      (listag) ->
        i = 0
        node = listag[oo._]._nodes.aB
        while node
          i++
          node = node.next.node
        i

      "The leftmost node is 'the_first'"
      'the_first'
      (listag) -> listag.head.node.cargo.x

      "The rightmost node is 'the_last'"
      'the_last'
      (listag) -> listag.tail.node.cargo.x

      "The leftmost node’s leftward node is null"
      null
      (listag) -> listag.head.node.previous.node

      "The rightmost node’s rightward node is null"
      null
      (listag) -> listag.tail.node.next.node

      "The leftmost node’s `next.node` is 'the_second'"
      'the_second'
      (listag) -> listag.head.node.next.node.cargo.x

      "The rightmost node’s `previous.node` is 'second_from_last'"
      'second_from_last'
      (listag) ->
        listag.tail.node.previous.node.cargo.x




      "'dog' `total`, `head`, `tail`, `previous` and `next` as expected"

      "2 'dog' nodes created during the '02 Listag::add()' test"
      2
      (listag) -> listag.total.dog

      "Traversing dogs rightward from the leftmost dog takes 2 steps"
      2
      (listag) ->
        i = 0
        node = listag.head.dog
        while node
          i++
          node = node.next.dog
        i

      "Traversing dogs leftward from the rightmost dog takes 2 steps"
      2
      (listag) ->
        i = 0
        node = listag.tail.dog
        while node
          i++
          node = node.previous.dog
        i

      "Traversing dogs rightward from `rightmost_dog` takes 1 steps"
      1
      (listag) ->
        i = 0
        node = listag[oo._]._nodes.rightmost_dog
        oo 
        while node
          i++
          node = node.next.dog
        i

      "The leftmost dog node is 'leftmost_dog'"
      'leftmost_dog'
      (listag) -> listag.head.dog.cargo.x

      "The rightmost dog node is 'rightmost_dog'"
      'rightmost_dog'
      (listag) -> listag.tail.dog.cargo.x

      "The leftmost dog’s leftward dog is null"
      null
      (listag) -> listag.head.dog.previous.dog

      "The rightmost dog’s rightward dog is null"
      null
      (listag) -> listag.tail.dog.next.dog

      "The leftmost dog’s `next.dog` is 'rightmost_dog'"
      'rightmost_dog'
      (listag) -> listag.head.dog.next.dog.cargo.x

      "The rightmost dog’s `previous.dog` is 'leftmost_dog'"
      'leftmost_dog'
      (listag) ->
        listag.tail.dog.previous.dog.cargo.x

    ];


