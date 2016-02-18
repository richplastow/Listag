Listag
======

@todo describe


#### The main class for Listag

    class Listag
      C: 'Listag'
      toString: -> '[object Listag]'

      constructor: (config={}) ->
        M = "/listag/src/Listag.litcoffee
          Listag()\n  "

        _o.define @, _o._, {}, 'hid'




Public Properties
-----------------


#### `total <object>`
@todo describe

        @total = {}


#### `head <object>`
@todo describe

        @head = {}


#### `tail <object>`
@todo describe

        @tail = {}




Private Properties
------------------


#### `_nodes <object>`
Contains all Node instances currently held by this Listag instance. 

        @[_o._]._nodes = {}




Methods
-------


#### `add()`
- `cargo <any>`             the new Node’s payload, can be any type
- `id <string>`             (optional) an identifier (generated if missing)
- `tags <array of string>`  (optional) must not be the special string 'node'
- `<string>`                returns the newly-added object’s identifier

Creates a new Node instance in `nodes`. 

      add: (cargo, id, tags=[]) ->
        M = "/listag/src/Listag.litcoffee
          Listag::add()\n  "

Check that the arguments are ok, and that `id` is unique. 

        id = id || _o.uid()
        _o.validator(M + "argument ", { id:id })("id <string #{ID_RULE}>")

        unless _o.isU @[_o._]._nodes[id] then throw RangeError M + "
          a node with id '#{id}' already exists"

        _o.vArray M + "argument tags", tags,
          "<array of string #{TAG_RULE}>", []

        tmp = {}
        for tag,i in tags
          if 'node' == tag then throw RangeError M + "
            argument tags[#{i}] is the special tag 'node'"
          unless _o.isU tmp[tag] then throw RangeError M + "
            argument tags[#{i}] is a duplicate of tags[#{tmp[tag]}]"
          tmp[tag] = i

Create a new Node instance, and fill the `previous` and `next` properties. 

        tags.push 'node' # every node has the special 'node' tag
        node = new Node cargo
        for tag in tags
          node.previous[tag] = if @total[tag] then @tail[tag] else null
          node.next[tag] = null

Append the new Node instance to `nodes`. 

          if @total[tag]
            @tail[tag].next[tag] = node
          else
            @head[tag] = node
            @total[tag] = 0
          @tail[tag] = node
          @total[tag]++

Allow the node to be accessed by `id`, and return the `id`. 

        @[_o._]._nodes[id] = node
        return id




#### `read()`
- `id <string>`  an identifier, unique within this Listag
- `<any>`        returns the node’s `cargo`

Retrieves a node’s cargo. 

      read: (id) ->
        M = "/listag/src/Listag.litcoffee
          Listag::read()\n  "

Look up the Node, and check that `id` is valid. 

        node = @[_o._]._nodes[id]
        if _o.isU node
          _o.validator(M + "argument ", { id:id })("id <string #{ID_RULE}>")
          throw RangeError M + "
            the node with id '#{id}' does not exist"

Return the cargo. 

        return node.cargo




Private Constants
-----------------


#### `ID_RULE, TAG_RULE <string>`
Validates the `id` and `tags` arguments. 

    ID_RULE  = '^[a-z]\\w{1,23}$'
    TAG_RULE = '^[a-z]\\w{1,23}$'





    ;
