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

        oo.define @, oo._, {}, 'hid'




Public Properties
-----------------


#### `total <object>`
@todo describe

        @total = {}


#### `head, tail <object>`
@todo describe

        @head = {}
        @tail = {}




Private Properties
------------------


#### `_nodes <object>`
Contains all Node instances currently held by this Listag instance. 

        @[oo._]._nodes = {}



Prevent properties being accidentally modified or added to the instance. 

        if 'Listag' == @C then oo.lock this




Methods
-------


#### `add()`
- `cargo <any>`             the new Node’s payload, can be any type
- `id <string>`             (optional) an identifier (generated if missing)
- `tags <array of string>`  (optional) must not be the special string 'node'
- `<string>`                returns the newly-added object’s identifier

Creates a new Node instance in `_nodes`. 

      add: (cargo, id, tags=[]) ->
        M = "/listag/src/Listag.litcoffee
          Listag::add()\n  "

Check that the arguments are ok, and that `id` is unique. 

        id = id || oo.uid()
        oo.validator(M + "argument ", { id:id })("id <string #{ID_RULE}>")

        unless oo.isU @[oo._]._nodes[id] then throw RangeError M + "
          a node with id '#{id}' already exists"

        oo.vArray M + "argument tags", tags,
          "<array of string #{TAG_RULE}>", []

        tmp = {}
        for tag,i in tags
          if 'node' == tag then throw RangeError M + "
            argument tags[#{i}] is the special tag 'node'"
          unless oo.isU tmp[tag] then throw RangeError M + "
            argument tags[#{i}] is a duplicate of tags[#{tmp[tag]}]"
          tmp[tag] = i

Create a new Node instance, and fill the `previous` and `next` properties. 

        tags.push 'node' # every node has the special 'node' tag
        node = new Node cargo
        for tag in tags
          node.previous[tag] = if @total[tag] then @tail[tag] else null
          node.next[tag] = null

Append the new Node instance to `_nodes`. 

          if @total[tag]
            @tail[tag].next[tag] = node
          else
            @head[tag] = node
            @total[tag] = 0
          @tail[tag] = node
          @total[tag]++

Allow the node to be accessed by `id`, and return the `id`. 

        @[oo._]._nodes[id] = node
        return id




#### `read()`
- `id <string>`  an identifier, unique within this Listag
- `<any>`        returns the node’s `cargo`

Retrieves a node’s cargo. 

      read: (id) ->
        M = "/listag/src/Listag.litcoffee
          Listag::read()\n  "

Look up the Node, and check that `id` is valid. 

        node = @[oo._]._nodes[id]
        if oo.isU node
          oo.validator(M + "argument ", { id:id })("id <string #{ID_RULE}>")
          throw RangeError M + "
            the node with id '#{id}' does not exist"

Return the cargo. 

        return node.cargo




#### `delete()`
- `id <string>`  an identifier, unique within this Listag
- `undefined`    does not return anything

Removes a node from this Listag. 

      delete: (id) ->
        M = "/listag/src/Listag.litcoffee
          Listag::delete()\n  "

Look up the Node, and check that `id` is valid. 

        node = @[oo._]._nodes[id]
        if oo.isU node
          oo.validator(M + "argument ", { id:id })("id <string #{ID_RULE}>")
          throw RangeError M + "
            the node with id '#{id}' does not exist"

Delete the Node. If the cargo is a primative it will be immediately destroyed. 
if the cargo references an object, it will only be destroyed if it’s not 
referenced from anywhere else. 

        for tag in Object.keys node.next

Update the previous and next node in `_nodes`. 

          if node.previous[tag] then node.previous[tag].next[tag] = node.next[tag]
          if node.next[tag]     then node.next[tag].previous[tag] = node.previous[tag]

Update the `total`, `head` and `tail` properties. 

          if --@total[tag]
            if ! node.previous[tag] then @head[tag] = node.next[tag]
            if ! node.next[tag]     then @tail[tag] = node.previous[tag]
          else
            delete @total[tag]
            delete @head[tag]
            delete @tail[tag]


Delete the Item from `_nodes`. 

          delete @[oo._]._nodes[id]

Do not return anything. 

        return undefined




Private Constants
-----------------


#### `ID_RULE, TAG_RULE <string>`
Validates the `id` and `tags` arguments. 

    ID_RULE  = '^[a-z]\\w{1,23}$'
    TAG_RULE = '^[a-z]\\w{1,23}$'




    ;
