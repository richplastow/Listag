Listag
======

@todo describe


```
id.......kind..cat..red..dog
tibbles  Pet   x    x       
fluffy   Pet   x            
fido     Pet        x    x  




.------------------------------------------------------------------------------.
|                |  .------.  .---------.  .---------.  .---------.  .------.  |
|     Listag     |  | null |  | tibbles |  | fluffy  |  |  fido   |  | null |  |
|                |  |      |  | cat,red |  |   cat   |  | dog,red |  |      |  |
|----------------|  |      |  |         |  |         |  |         |  |      |  |
|                |  |      |  |         |  |         |  |         |  |      |  |
|                |  |     <----- node  <----- node  <----- node   |  |      |  |
| node.previous. |  |     <----- cat   <----- cat    |  |         |  |      |  |
|                |  |     <----- red   <---|         |---- red    |  |      |  |
|                |  |     <---|         |--|         |---- dog    |  |      |  |
|----------------|  |      |  |         |  |         |  |         |  |      |  |
|                |  |      |  |   node ----->  node ----->  node ----->     |  |
|                |  |      |  |    cat ----->   cat ----|         |--->     |  |
|   node.next.   |  |      |  |    red ----|         |--->   red ----->     |  |
|                |  |      |  |         |  |         |  |    dog ----->     |  |
|                |  |      |  |         |  |         |  |         |  |      |  |
|                |  '======'  '==|======'  '====|===='  '======|=='  '======'  |
|----------------|---------------|--------------|--------------|---------------|
| total.node = 3 |   head.node --|              |              |-- tail.node   |
| total.cat  = 2 |   head.cat  --|              '-- tail.cat   |               |
| total.red  = 2 |   head.red  --'                             |-- tail.red    |
| total.dog  = 1 |                                  head.dog --'-- tail.dog    |
'=============================================================================='
```



#### The main class for Listag

    class Listag
      C: 'Listag'
      toString: -> '[object Listag]'

      constructor: (config={}) ->
        M = '/listag/src/Listag.litcoffee
          Listag()\n  '

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

        if 'Listag' == @C then oo.lock @




B.R.E.A.D. Methods
------------------


#### `browse()`
- `config <object> {}`  defines what to show, and how to show it
  - `config.format <string ^text|array$> 'text'`  how to format the output
  - `config.tags <[string]> []`                   only browse certain tags
- `<array|string>`  the return type depends on `config.format`

Filters and formats `_nodes` in various ways. 

      browse: (config={}) ->
        M = '/listag/src/Listag.litcoffee
          Listag::browse()\n  '

        v = oo.vObject M, 'config', config
        v 'format <string ^text|array$>', 'text'
        config.tags = oo.vArray(M + 'config.tags', config.tags, 
          "<[string #{TAG_RULE}]>", [])

Deal with an empty Listag. 

        if ! @total.node
          return if 'array' == config.format then [] else '[empty]'

Summarize the node metadata. 

        [meta, maxId, maxType, aToZtags] = if config.tags.length
          summarizeAndFilterNodes @head.node, config.tags
        else
          summarizeNodes @head.node

Deal with a request for metadata in 'array' format. @todo more formats

        if 'array' == config.format then return meta

Otherwise, render the metadata as a text-based table, suitable for CLI output. 

        row = oo.pad('id', maxId + 2, '.') + oo.pad('type', maxType, '.')
        (if 'node' != t then row += '..' + t) for t in aToZtags

        out = [row]
        for node in meta
          row = oo.pad(node.id, maxId) + '  ' + oo.pad(node.type, maxType)
          for t in aToZtags
            if 'node' != t
              row += '  ' + oo.pad(node.tags[t] || ' ', t.length)
          out.push row

        return out.join '\n'




#### `read()`
- `id <string>`  an identifier, unique within this Listag
- `<any>`        returns the node’s `cargo`

Retrieves a node’s cargo. 

      read: (id) ->
        M = '/listag/src/Listag.litcoffee
          Listag::read()\n  '

Look up the Node, and check that `id` is valid. 

        node = @[oo._]._nodes[id]
        if oo.isU node
          oo.vArg M, id, "id <string #{ID_RULE}>"
          throw RangeError M + "
            the node with id '#{id}' does not exist"

Return the cargo. 

        return node.cargo




#### `edit()`
- `id <string>`               an identifier, unique within this Listag
- `config <object> {}`        defines what to modify
  - `config.cargo <any>`      replacement for the current cargo, can be any type
  - `config.tags <[string]>`  replacement for the current tags
- `undefined`                 does not return anything

Modifies a node’s tags or cargo. 

      edit: (id, config={}) ->
        M = '/listag/src/Listag.litcoffee
          Listag::edit()\n  '

Look up the Node, and check that the arguments are valid. 

        node = @[oo._]._nodes[id]
        if oo.isU node
          oo.vArg M, id, "id <string #{ID_RULE}>"
          throw RangeError M + "
            the node with id '#{id}' does not exist"

        v = oo.vObject M, 'config', config
        if config.tags
          oo.vArray M + 'config.tags', config.tags, "<[string #{TAG_RULE}]>"
          tmp = {}
          for tag,i in config.tags
            if 'node' == tag then throw RangeError M + "
              config.tags[#{i}] is the special tag 'node'"
            unless oo.isU tmp[tag] then throw RangeError M + "
              config.tags[#{i}] is a duplicate of config.tags[#{tmp[tag]}]"
            tmp[tag] = i

Replace cargo if `config.cargo` exists - note that it may be set to `undefined`.

        if 0 <= Object.keys(config).indexOf 'cargo' #@todo polyfill MSIE8 and earlier
          node.cargo = config.cargo

Process `config.tags`, if set. 

        if config.tags

Remove existing tags which are not in `config.tags`. 

          for tag of node.next
            if 'node' == tag or 0 <= config.tags.indexOf tag then continue

If a tag only exists in the edited node, remove it from the `total`, `head` and 
`tail` properties. Otherwise, just update `total`, `head` and `tail`. 

            if --@total[tag]
              if ! node.previous[tag] # no previous node...
                @head[tag] = node.next[tag] # ...so the head changes
              if ! node.next[tag] # no next node...
                @tail[tag] = node.previous[tag] # ...so the tail changes
            else
              delete @total[tag]
              delete @head[tag]
              delete @tail[tag]

Update the previous and next node. 

            if node.previous[tag]
              node.previous[tag].next[tag] = node.next[tag]
            if node.next[tag]
              node.next[tag].previous[tag] = node.previous[tag]

Remove the tag from the edited node. 

            delete node.previous[tag]
            delete node.next[tag]

Add new tags from the `config.tags` array if they don’t already exist. 

          for tag in config.tags
            unless oo.isU node.next[tag] then continue

If the new tag is _not_ already in use, it can be inserted very easily...

            unless @total[tag]
              @total[tag] = 1
              @head[tag] = node
              @tail[tag] = node
              node.previous[tag] = null
              node.next[tag]     = null

...otherwise, we need to find the previous and next nodes with the new tag, so 
that we can insert this node inbetween. 

            else
              @total[tag]++
              prevNode = node.previous.node # begin with the previous node...
              while prevNode # ...and loop ‘headwards’ until `@head.node`
                if oo.isU nextNode = prevNode.next[tag] # tag not on prev node
                  prevNode = prevNode.previous.node # make one step headwards
                  continue
                prevNode.next[tag] = node # found the previous tagged node
                node.previous[tag] = prevNode
                node.next[tag]     = nextNode
                if nextNode # `nextNode` is a node
                  nextNode.previous[tag] = node
                else # `nextNode` is `null`
                  @tail[tag] = node
                break
              unless node.previous[tag] # didn’t find the tagged node backwards
                node.previous[tag] = null
                @head[tag] = node
                nextNode = node.next.node
                while nextNode
                  if oo.isU prevNode = nextNode.previous[tag] # not on next node
                    nextNode = nextNode.next.node
                    continue
                  nextNode.previous[tag] = node
                  node.next[tag]         = nextNode
                  break

Do not return anything. 

        return undefined




#### `add()`
- `cargo <any>`      the new Node’s payload, can be any type
- `id <string>`      (optional) an identifier (generated if missing)
- `tags <[string]>`  (optional) must not be the special string 'node'
- `<string>`         returns the newly-added object’s identifier

Creates a new Node instance in `_nodes`. 

      add: (cargo, id, tags=[]) ->
        M = '/listag/src/Listag.litcoffee
          Listag::add()\n  '

Check that the arguments are ok, and that `id` is unique. 

        id = id || oo.uid()
        oo.vArg M, id, "id <string #{ID_RULE}>"

        if @[oo._]._nodes[id] then throw RangeError M + "
          a node with id '#{id}' already exists"

        oo.vArray M + 'argument tags', tags, "<[string #{TAG_RULE}]>"

        tmp = {}
        for tag,i in tags
          if 'node' == tag then throw RangeError M + "
            argument tags[#{i}] is the special tag 'node'"
          unless oo.isU tmp[tag] then throw RangeError M + "
            argument tags[#{i}] is a duplicate of tags[#{tmp[tag]}]"
          tmp[tag] = i

Create a new Node instance, and fill the `previous` and `next`. 

        tags.push 'node' # every node has the special 'node' tag
        node = new Node cargo, id
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




#### `delete()`
- `id <string>`  an identifier, unique within this Listag
- `undefined`    does not return anything

Removes a node from this Listag. 

      delete: (id) ->
        M = '/listag/src/Listag.litcoffee
          Listag::delete()\n  '

Look up the Node, and check that `id` is valid. 

        node = @[oo._]._nodes[id]
        if oo.isU node
          oo.vArg M, id, "id <string #{ID_RULE}>"
          throw RangeError M + "
            the node with id '#{id}' does not exist"

Delete the Node. If the cargo is a primative it will be immediately destroyed. 
if the cargo references an object, it will only be destroyed if it’s not 
referenced from anywhere else. 

        for tag in Object.keys node.next

Update the previous and next node in `_nodes`. 

          if node.previous[tag]
            node.previous[tag].next[tag] = node.next[tag]
          if node.next[tag]
            node.next[tag].previous[tag] = node.previous[tag]

Update the `total`, `head` and `tail` properties. 

          if --@total[tag]
            if ! node.previous[tag]
              @head[tag] = node.next[tag]
            if ! node.next[tag]
              @tail[tag] = node.previous[tag]
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
Used for validating the `id` and `tags` arguments. 

    ID_RULE  = '^[a-z]\\w{1,23}$'
    TAG_RULE = '^[a-z]\\w{1,23}$'




Private Functions
-----------------


#### `removeTag()`
- `listag <Listag>`  a Listag instance to remove the tag from, typically `this`
- `tag <string>`     the tag which should be removed
- `undefined`        does not return anything

@todo use this function  
Removes all traces of a tag from a Listag instance, and all its Node instances. 

    removeTag = (listag, tag) ->
      M = '/listag/src/Listag.litcoffee
        removeTag()\n  '

This is a private function, so we don’t need to validate arguments. However, 
it’s very important that the special 'node' tag is not removed, so just in case:

      if 'node' == tag then return

Remove the tag from each Node instance. 

      node = listag.head[tag]
      while node
        nextNode = node.next[tag]
        delete node.previous[tag]
        delete node.next[tag]
        node = nextNode

Remove the tag from the `total`, `head` and `tail` properties. 

      delete listag.total[tag]
      delete listag.head[tag]
      delete listag.tail[tag]

Do not return anything. 

      return undefined




#### `summarizeNodes()`
- `node <Node>`       the start-node, typically `@head.node`
- `<array>`           contains four useful elements:
  - `0 <object>`      `meta`, @todo describe
  - `1 <array>`       `maxId`, @todo describe
  - `2 <integer>`     `maxType`, @todo describe
  - `3 <integer>`     `aToZtags`, @todo describe

Rapidly summarizes all nodes, without performing any filtering. 

    summarizeNodes = (node) ->
      M = '/listag/src/Listag.litcoffee
        summarizeNodes()\n  '

Summarize the node metadata in an array, and find the longest id and type. 

      meta     = []
      maxId    = 2
      maxType  = 4
      aToZtags = {} # will contain all tags, sorted in alphabetical order
      while node
        metaTags = {}
        for tag of node.next
          metaTags[tag] = 'x'
          aToZtags[tag] = 1
        type = oo.type node.cargo
        meta.push { id:node.id, tags:metaTags, type:type }
        maxId   = Math.max maxId,   node.id.length
        maxType = Math.max maxType, type.length
        node = node.next.node

Convert `aToZtags` from a hash to an array, and sort it in alphabetical order.  
Return the four elements. 

      return [ meta, maxId, maxType, Object.keys(aToZtags).sort() ]




#### `summarizeAndFilterNodes()`
- `node <Node>`       the start-node, typically `@head.node`
- `tags <array>`      tags to filter the result
- `<array>`           contains four useful elements:
  - `0 <object>`      `meta`, @todo describe
  - `1 <array>`       `maxId`, @todo describe
  - `2 <integer>`     `maxType`, @todo describe
  - `3 <integer>`     `aToZtags`, @todo describe

Summarizes all nodes, filtering by tag. Slower than `summarizeNodes()`. 

    summarizeAndFilterNodes = (node, tags) ->
      M = '/listag/src/Listag.litcoffee
        summarizeAndFilterNodes()\n  '

Prepare `tagFilters`, which will speed up filtering by tags. 

      tagFilters = {}
      tagFilters[tag] = 1 for tag in tags

Summarize the node metadata in an array, and find the longest id and type. 

      meta     = []
      maxId    = 2
      maxType  = 4
      aToZtags = {} # will only contain tags from nodes which pass the filter
      while node
        passesFilter = false
        metaTags = {}
        for tag of node.next
          metaTags[tag] = 'x'
          if tagFilters[tag] then passesFilter = true
        if passesFilter
          type = oo.type node.cargo
          meta.push { id:node.id, tags:metaTags, type:type }
          maxId   = Math.max maxId,   node.id.length
          maxType = Math.max maxType, type.length
          for tag of node.next
            aToZtags[tag] = 1
        node = node.next.node

Convert `aToZtags` from a hash to an array, and sort it in alphabetical order.  
Return the four elements. 

      return [ meta, maxId, maxType, Object.keys(aToZtags).sort() ]




    ;
