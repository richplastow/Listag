01 Listag Constructor
=======================


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

      "`Listag::length` is an object"
      _o.O
      (listag) -> listag.length

      "`Listag::first` is an object"
      _o.O
      (listag) -> listag.first

      "`Listag::last` is an object"
      _o.O
      (listag) -> listag.last


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

      "`Listag::length` is empty"
      0
      (listag) -> Object.keys( listag.length ).length

      "`Listag::first` is empty"
      0
      (listag) -> Object.keys( listag.first ).length

      "`Listag::last` is empty"
      0
      (listag) -> Object.keys( listag.last ).length



    ];
