Oopish Helpers
==============

#### Define the core Oopish helper functions

Oopish’s helper functions are visible to all code defined in ‘src/’ and ‘test/’ 
but are hidden from code defined elsewhere in the runtime environment. 

- Helpers have no side-effects, other than throwing exceptions
- They run identically in all modern environments (browser, server, desktop, …)
- They are short - each minifies to xxx bytes, at most @todo how big? zipped?
- They return the same output for a given set of arguments (except `oo.uid()`)




#### `oo.is()`
Useful for reducing CoffeeScript’s verbose conditional syntax, eg:  
`if condition then 123 else 456` becomes `oo.is condition, 123, 456`. 

    oo.is = (c, t=true, f=false) ->
      if c then t else f


#### `oo.isU()`
@todo description

    oo.isU = (x) ->
      oo.U == typeof x


#### `oo.isX()`
@todo description

    oo.isX = (x) ->
      null == x


#### `oo.type()`
To detect the difference between 'null', 'array', 'regexp' and 'object' types, 
we use [Angus Croll’s one-liner](http://goo.gl/WlpBEx). This can be used in 
place of JavaScript’s familiar `typeof` operator, with one important exception: 
when the variable being tested does not exist, `typeof foobar` will return 
`undefined`, whereas `oo.type(foobar)` will throw an error. 

    oo.type = (a) ->
      return oo.X if oo.isX a # prevent `domwindow` in some UAs
      ta = typeof a
      return ta if { undefined:1, string:1, number:1, boolean:1 }[ta]
      if ! a.nodeName and a.constructor != Array and /function/i.test(''+a)
        return oo.F # IE<=8 http://goo.gl/bTbbov
      ({}).toString.call(a).match(/\s([a-z0-9]+)/i)[1].toLowerCase()


#### `oo.ex()`
Exchanges a character from one set for its equivalent in another. To decompose 
an accent, use `oo.ex(c, 'àáäâèéëêìíïîòóöôùúüûñç', 'aaaaeeeeiiiioooouuuunc')`

    oo.ex = (x, a, b) ->
      if -1 == pos = a.indexOf x then x else b.charAt pos


#### `oo.has()`
Determines whether haystack contains a given needle. @todo arrays and objects

    oo.has = (h, n, t=true, f=false) ->
      if -1 != h.indexOf n then t else f


#### `oo.uid()`
Xx optional prefix. @todo description

    oo.uid = (p='id') ->
      p + '_' + ( Math.random().toString(36) + '00000000' ).substr 2,8


#### `oo.uid62()`
Xx optional prefix. @todo description

    oo.uid62 = (p='id', l=8) ->
      c = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
      p + '_' + ( c.charAt(Math.floor(Math.random()*62)) while l-- ).join('')




#### `oo.pad()`
Xx. @todo description

    oo.pad = (s, l, c=' ') ->
      s + Array(l-s.length+1).join(c)




#### `oo.insert()`
Xx. @todo description

    oo.insert = (basis, overlay, offset) ->
      basis.slice(0, offset) + overlay + basis.slice(offset+overlay.length)




#### `oo.define()`
- `'constant'` Enumerable but immutable

Convert a property to one of XX kinds:

    oo.define = (obj, name, value, kind) ->
      switch kind
        when 'constant'
          Object.defineProperty obj, name, { value:value, enumerable:true }
        when 'hid'
          Object.defineProperty obj, name, { value:value, enumerable:false }




#### `oo.lock()`

@todo describe

    oo.lock = (obj) ->
      for key in Object.keys obj
        Object.defineProperty obj, key, { writable:false, configurable:false }
      Object.preventExtensions obj
      if obj.prototype and obj != obj.prototype then oo.lock obj.prototype




#### `oo.vArray()`
- `M <string>`            a method-name prefix to add to exception messages
- `arr <array>`           the array which contains the values to validate
- `signature <string>`    type and rules for elements
- `fallback <array>`      (optional) a value to use if the array is empty
- `<array>`               returns the valid array

Validates an array. 

    oo.vArray = (M, arr, signature, fallback) ->

Get `types` and `rule` from the signature. 

        matches = signature.match /^<array of ([|a-z]+)\s*(.*)>$/i
        if ! matches then throw RangeError "/listag/oopish/oo-helpers.litcoffee
          oo.vArray()\n  signature #{signature} is invalid"
        [signature, types, rule] = matches

Use the fallback, if needed. 

        if ! arr then return fallback

Step through each element in `arr`, and get its value’s type. 

        if oo.A != oo.type arr then throw RangeError M +
          " is type #{oo.type arr} not array"

        for value,i in arr
          tv = oo.type value

Check the type and rule. 

          pass = false
          for type in types.split '|'
            if (oo.N == type or oo.I == type) and oo.N == tv
              if oo.I == type and value % 1
                throw RangeError M + "[#{i}] is a number but not an integer"
              if rule
                [min, max] = rule.split '-'
                if value < min or value > max
                  throw RangeError M + "[#{i}] is #{value} (must be #{rule})"
              pass = true
              break
            if type == tv
              if oo.S == tv and rule
                unless RegExp(rule).test value
                  throw RangeError M + "[#{i}] fails #{rule}"
              pass = true
              break
            if /^[A-Z]/.test type
              if oo.O == tv
                if eval "value instanceof #{type}" #@todo refactor to avoid `eval()`
                  pass = true
                  break

          if pass then continue
          throw TypeError M + "[#{i}] is type #{tv} not #{types}"




#### `oo.vArg()`
- `M <string>`          a method-name prefix to add to exception messages
- `value <any>`         the value to validate
- `signature <string>`  the value’s name and type
- `fallback <mixed>`    (optional) a value to use if `arg` is undefined
- `<mixed>`             returns the valid value

Creates a custom validator. 

    oo.vArg = (M, value, signature, fallback) ->

Get `key`, `types` and `rule` from the signature. 

        matches = signature.match /^([_a-z][_a-z0-9]*)\s+<([|a-z]+)\s*(.*)>$/i
        if ! matches then throw RangeError "/listag/oopish/oo-helpers.litcoffee
          oo.vArg()\n  signature #{signature} is invalid"
        [signature, key, types, rule] = matches

Prepare a prefix for errors. 

        pfx = M + "argument #{key} "

Use the fallback, if needed. 

        tv = oo.type value
        if oo.U == tv
          if 4 == arguments.length then return fallback
          throw TypeError pfx + "is undefined and has no fallback"

Check the type and rule. 

        for type in types.split '|'
          if (oo.N == type or oo.I == type) and oo.N == tv
            if oo.I == type and value % 1
              throw RangeError pfx + "is a number but not an integer"
            if rule
              [min, max] = rule.split '-'
              if value < min or value > max
                throw RangeError pfx + "is #{value} (must be #{rule})"
            return value
          if type == tv
            if oo.S == tv and rule
              unless RegExp(rule).test value
                throw RangeError pfx + "fails #{rule}"
            return value
          if /^[A-Z]/.test type
            if oo.O == tv
              if eval "value instanceof #{type}" #@todo refactor to avoid `eval()`
                return value

        throw TypeError pfx + "is type #{tv} not #{types}"




#### `oo.vObject()`
- `M <string>`            a method-name prefix to add to exception messages
- `obj <object>`          the object which contains the values to validate
- `<function>`            the validator, which determines a property’s validity
  - `signature <string>`  the value’s name and type
  - `fallback <mixed>`    (optional) a value to use if `opt[key]` is undefined
  - `<mixed>`             returns the valid value

Creates a custom validator. 

    oo.vObject = (M, objName, obj) ->

      if oo.O != oo.type obj
        throw TypeError M + objName + " is type #{oo.type obj} not object"

      (signature, fallback) ->

Get `key`, `types` and `rule` from the signature. 

        matches = signature.match /^([_a-z][_a-z0-9]*)\s+<([|a-z]+)\s*(.*)>$/i
        if ! matches then throw RangeError "/listag/oopish/oo-helpers.litcoffee
          oo.vObject()\n  signature #{signature} is invalid"
        [signature, key, types, rule] = matches

Use the fallback, if needed. 

        value = obj[key]
        tv = oo.type value
        if oo.U == tv
          if 2 == arguments.length then return fallback
          throw TypeError M + objName + '.' + key + " is undefined and has no fallback"

Check the type and rule. 

        for type in types.split '|'
          if (oo.N == type or oo.I == type) and oo.N == tv
            if oo.I == type and value % 1
              throw RangeError M + objName + '.' + key + " is a number but not an integer"
            if rule
              [min, max] = rule.split '-'
              if value < min or value > max
                throw RangeError M + objName + '.' + key + " is #{value} (must be #{rule})"
            return value
          if type == tv
            if oo.S == tv and rule
              unless RegExp(rule).test value
                throw RangeError M + objName + '.' + key + " fails #{rule}"
            return value
          if /^[A-Z]/.test type
            if oo.O == tv
              if eval "value instanceof #{type}" #@todo refactor to avoid `eval()`
                return value

        throw TypeError M + objName + '.' + key + " is type #{tv} not #{types}"




    ;


