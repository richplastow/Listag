Oopish Constants
================

#### Define the core Oopish constants

Oopish’s constants are visible to all code defined in ‘src/’ and ‘test/’, but 
hidden from code defined elsewhere in the app. 




Define the Oopish container
---------------------------

Rather than just a generic object, the Oopish container can also be used as a 
handy shortcut for `console.log()` Note [`bind()`](http://goo.gl/66ffgl), and
[unusual IE8/9 behaviour](http://goo.gl/ZmG9Xs). 

    if 'undefined' == typeof console or ! console.log
      _o = -> # no-op
    else if 'object' == typeof console.log # eg IE8/9
      _o = Function::bind console.log, console
    else
      _o = console.log.bind console




Constants which help minification
---------------------------------

These strings can make `*.min.js` a little shorter and easier to read, and also 
make the source code less verbose: `_o.O == typeof x` vs `'object' == typeof x`.

    _o.A = 'array'
    _o.B = 'boolean'
    #       class, not used to avoid confusion with a class’s `C` property
    _o.D = 'document'
    _o.E = 'error'
    _o.F = 'function'
    #       global, see build-constants, below
    #       method, not used to avoid confusion with a method’s `M` variable
    _o.N = 'number'
    _o.O = 'object'
    _o.R = 'regexp'
    _o.S = 'string'
    #       title, see build-constants, below
    _o.U = 'undefined'
    #       version, see build-constants, below
    _o.X = 'null'




Build Constants
---------------

Generated during the build-process and injected into app-scope. 

    _o.G = _oG # global scope, passed into the closure as an argument
    _o.T = _oT # project title, converted from package.json's name
    _o.V = _oV # project version, from package.json



    ;

