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




Properties
----------


#### `nodes <object>`
Contains all Node instances currently held by this Listag instance. 

        @nodes = {}


#### `total <object>`
@todo describe

        @total = {}


#### `head <object>`
@todo describe

        @head = {}


#### `tail <object>`
@todo describe

        @tail = {}




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

        v  = _o.validator M + "argument ", { id:id }
        id = v 'id <string ^[a-z]\\w{1,23}$>', _o.uid()

        unless _o.isU @nodes[id] then throw RangeError M + "
          a node with id '#{id}' already exists"

        _o.vArray M + "argument tags", tags,
          '<array of string ^[a-z]\\w{1,23}$>', []

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

        @nodes[id] = node
        return id




#### `read()`
- `id <string>`             an identifier, unique within this Listag
- `<object>`                returns a reference to the node

Retrieves a node’s cargo. 

      read: (id) ->
        M = "/listag/src/Listag.litcoffee
          Listag::read()\n  "

Check that `id` is valid. 

        _o.validator(M + "argument ", { id:id })('id <string ^[a-z]\\w{1,23}$>')
        node = @nodes[id]
        if _o.isU node then throw RangeError M + "
          the node with id '#{id}' does not exist"

Return the object. 

        return node




#### `xx()`
- `yy <zz>`      @todo describe
- `<undefined>`  does not return anything

@todo describe

      xx: (yy) ->
        M = "/listag/src/Listag.litcoffee
          Listag::xx()\n  "




Namespaced Functions
--------------------


#### `xx()`
- `yy <zz>`      @todo describe
- `<undefined>`  does not return anything

@todo describe

    Listag.xx = (yy) ->
      M = "/listag/src/Listag.litcoffee
        Listag.xx()\n  "




    ;
