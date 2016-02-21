Oopish Helpers
==============

#### Define the core Oopish helper functions

Oopish’s helper functions are visible to all code defined in ‘src/’ and ‘test/’ 
but are hidden from code defined elsewhere in the runtime environment. 

- Helpers are ‘pure’ (they return the same output for a given set of arguments)
- They have no side-effects, other than throwing exceptions
- They run identically in all modern environments (browser, server, desktop, …)
- The Oopish helpers minify to xxx bytes @todo how big? and zipped?




#### `_o.is()`
Useful for reducing CoffeeScript’s verbose conditional syntax, eg:  
`if condition then 123 else 456` becomes `_o.is condition, 123, 456`. 

    _o.is = (c, t=true, f=false) ->
      if c then t else f




#### `_o.isU()`
@todo description

    _o.isU = (x) ->
      _o.U == typeof x




#### `_o.isX()`
@todo description

    _o.isX = (x) ->
      null == x




#### `_o.type()`
To detect the difference between 'null', 'array', 'regexp' and 'object' types, 
we use [Angus Croll’s one-liner](http://goo.gl/WlpBEx). This can be used in 
place of JavaScript’s familiar `typeof` operator, with one important exception: 
when the variable being tested does not exist, `typeof foobar` will return 
`undefined`, whereas `_o.type(foobar)` will throw an error. 

    _o.type = (a) ->
      return _o.X if _o.isX a # prevent `domwindow` in some UAs
      ta = typeof a
      return ta if { undefined:1, string:1, number:1, boolean:1 }[ta]
      if ! a.nodeName and a.constructor != Array and /function/i.test(''+a)
        return _o.F # IE<=8 http://goo.gl/bTbbov
      ({}).toString.call(a).match(/\s([a-z0-9]+)/i)[1].toLowerCase()




#### `_o.ex()`
Exchanges a character from one set for its equivalent in another. To decompose 
an accent, use `_o.ex(c, 'àáäâèéëêìíïîòóöôùúüûñç', 'aaaaeeeeiiiioooouuuunc')`

    _o.ex = (x, a, b) ->
      if -1 == pos = a.indexOf x then x else b.charAt pos




#### `_o.has()`
Determines whether haystack contains a given needle. @todo arrays and objects

    _o.has = (h, n, t=true, f=false) ->
      if -1 != h.indexOf n then t else f




#### `_o.uid()`
Xx optional prefix. @todo description

    _o.uid = (p='id', l=8) ->
      c = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
      p + '_' + ( c.charAt(Math.floor(Math.random()*62)) while l-- ).join('')




#### `_o.insert()`
Xx. @todo description

    _o.insert = (basis, overlay, offset) ->
      basis.slice(0, offset) + overlay + basis.slice(offset+overlay.length)




#### `_o.define()`
- `'constant'` Enumerable but immutable

Convert a property to one of XX kinds:

    _o.define = (obj, name, value, kind) ->
      switch kind
        when 'constant'
          Object.defineProperty obj, name, { value:value, enumerable:true }
        when 'hid'
          Object.defineProperty obj, name, { value:value, enumerable:false }




#### `_o.lock()`

@todo describe

    _o.lock = (obj) ->
      for key in Object.keys obj
        Object.defineProperty obj, key, { writable:false, configurable:false }
      Object.preventExtensions obj
      if obj.prototype and obj != obj.prototype then _o.lock obj.prototype




#### `_o.vArray()`
- `M <string>`            a method-name prefix to add to exception messages
- `arr <array>`           the array which contains the values to validate
- `signature <string>`    type and rules for elements
- `fallback <array>`      (optional) a value to use if the array is empty
- `<array>`               returns the valid array

Validates an array. 

    _o.vArray = (M, arr, signature, fallback) ->

Get `types` and `rule` from the signature. 

        matches = signature.match /^<array of ([|a-z]+)\s*(.*)>$/i
        if ! matches then throw RangeError "/listag/src/_o-helpers.litcoffee
          _o.vArray()\n  signature #{signature} is invalid"
        [signature, types, rule] = matches

Use the fallback, if needed. 

        if ! arr then return fallback

Step through each element in `arr`, and get its value’s type. 

        if _o.A != _o.type arr then throw RangeError M +
          " is type #{_o.type arr} not array"

        for value,i in arr
          tv = _o.type value

Check the type and rule. 

          pass = false
          for type in types.split '|'
            if (_o.N == type or _o.I == type) and _o.N == tv
              if _o.I == type and value % 1
                throw RangeError M + "[#{i}] is a number but not an integer"
              if rule
                [min, max] = rule.split '-'
                if value < min or value > max
                  throw RangeError M + "[#{i}] is #{value} (must be #{rule})"
              pass = true
              break
            if type == tv
              if _o.S == tv and rule
                unless RegExp(rule).test value
                  throw RangeError M + "[#{i}] fails #{rule}"
              pass = true
              break
            if /^[A-Z]/.test type
              if _o.O == tv
                if eval "value instanceof #{type}" #@todo refactor to avoid `eval()`
                  pass = true
                  break

          if pass then continue
          throw TypeError M + "[#{i}] is type #{tv} not #{types}"




#### `_o.validator()`
- `M <string>`            a method-name prefix to add to exception messages
- `obj <object>`          the object which contains the values to validate
- `<function>`            the validator, which determines a property’s validity
  - `signature <string>`  the value’s name and type
  - `fallback <mixed>`    (optional) a value to use if `opt[key]` is undefined
  - `<mixed>`             returns the valid value

Creates a custom validator. 

    _o.validator = (M, obj) ->

      (signature, fallback) ->

Get `key`, `types` and `rule` from the signature. 

        matches = signature.match /^([_a-z][_a-z0-9]*)\s+<([|a-z]+)\s*(.*)>$/i
        if ! matches then throw RangeError "/listag/src/_o-helpers.litcoffee
          _o.validator()\n  signature #{signature} is invalid"
        [signature, key, types, rule] = matches

Use the fallback, if needed. 

        value = obj[key]
        tv = _o.type value
        if _o.U == tv
          if 2 == arguments.length then return fallback
          throw TypeError M + key + " is undefined and has no fallback"

Check the type and rule. 

        for type in types.split '|'
          if (_o.N == type or _o.I == type) and _o.N == tv
            if _o.I == type and value % 1
              throw RangeError M + key + " is a number but not an integer"
            if rule
              [min, max] = rule.split '-'
              if value < min or value > max
                throw RangeError M + key + " is #{value} (must be #{rule})"
            return value
          if type == tv
            if _o.S == tv and rule
              unless RegExp(rule).test value
                throw RangeError M + key + " fails #{rule}"
            return value
          if /^[A-Z]/.test type
            if _o.O == tv
              if eval "value instanceof #{type}" #@todo refactor to avoid `eval()`
                return value

        throw TypeError M + key + " is type #{tv} not #{types}"




    ;


