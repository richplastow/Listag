01 Listag Constructor
=====================


    tudor.add [
      "01 Listag Constructor"
      tudor.is




      "The class and instance are expected types"

Prepare a test-instance. 

      -> [new Listag]


      "The Listag class is a function"
      _o.F
      -> Listag

      "`new` returns an object"
      _o.O
      (listag) -> listag




      "Instance properties as expected"


      "`Listag::nodes` is an object"
      _o.O
      (listag) -> listag.nodes

      "`Listag::total` is an object"
      _o.O
      (listag) -> listag.total

      "`Listag::head` is an object"
      _o.O
      (listag) -> listag.head

      "`Listag::tail` is an object"
      _o.O
      (listag) -> listag.tail


      tudor.equal

      "`Listag::C` is 'Listag'"
      'Listag'
      (listag) -> listag.C

      "`Listag::toString()` is '[object Listag]'"
      '[object Listag]'
      (listag) -> listag+''

      "`Listag::nodes` is empty"
      0
      (listag) -> Object.keys( listag.nodes ).length

      "`Listag::total` is empty"
      0
      (listag) -> Object.keys( listag.total ).length

      "`Listag::head` is empty"
      0
      (listag) -> Object.keys( listag.head ).length

      "`Listag::tail` is empty"
      0
      (listag) -> Object.keys( listag.tail ).length



    ];
