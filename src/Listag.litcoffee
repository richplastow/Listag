Listag
========

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
Contains all objects currently held by this Listag instance. 

        @nodes = {}


#### `length <object>`
@todo describe

        @length = {}


#### `first <object>`
@todo describe

        @first = {}


#### `last <object>`
@todo describe

        @last = {}




Methods
-------


#### `add()`
- `node <object>`           `listagL/R` properties will be added to this
- `id <string>`             (optional) an identifier (generated if missing)
- `tags <array of string>`  (optional) @todo prevent the special string 'all'
- `<string>`                returns the newly-added object’s identifier

Records an object in `nodes`. 

      add: (node, id, tags=[]) ->
        M = "/listag/src/Listag.litcoffee
          Listag::add()\n  "

Check that the arguments are ok, and that `id` is unique. 

        v = _o.validator M + "argument ", { node:node, id:id }
        node = v 'node <object>'
        id   = v 'id <string ^[a-z]\\w{1,23}$>', _o.uid _o.type node

        unless _o.isU @nodes[id] then throw RangeError M + "
          a node with id '#{id}' already exists"

        _o.vArray M + "argument tags", tags, 
          '<array of string ^[a-z]\\w{1,23}$>', []

        tmp = {}
        for tag,i in tags
          if 'all' == tag then throw RangeError M + "
            argument tags[#{i}] is the special tag 'all'"
          unless _o.isU tmp[tag] then throw RangeError M + "
            argument tags[#{i}] is a duplicate of tags[#{tmp[tag]}]"
          tmp[tag] = i

Apply the `listagL` and `listagR` object properties. 

        tags.push 'all' # every node has the special 'all' tag
        node.listagL = node.listagL || {}
        node.listagR = node.listagR || {}
        for tag in tags
          node.listagL[tag] = if @length[tag] then @last[tag] else null
          node.listagR[tag] = null

Append the new object to `nodes`. 

          if @length[tag]
            @last[tag].listagR[tag] = node
          else
            @first[tag] = node
            @length[tag] = 0
          @last[tag] = node
          @length[tag]++

Allow the node to be accesed by `id`, and return the `id`. 

        @nodes[id] = node
        return id




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
