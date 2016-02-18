// Generated by CoffeeScript 1.9.2
(function(_oG) {
/*! Listag 0.0.10 //// MIT Licence //// http://listag.richplastow.com/ */
var ID_RULE, Listag, Node, TAG_RULE, _o, _oT, _oV;

_oT = 'Listag';

_oV = '0.0.10';

_o = {};

Listag = (function() {
  Listag.prototype.C = 'Listag';

  Listag.prototype.toString = function() {
    return '[object Listag]';
  };

  function Listag(config) {
    var M;
    if (config == null) {
      config = {};
    }
    M = "/listag/src/Listag.litcoffee Listag()\n  ";
    _o.define(this, _o._, {}, 'hid');
    this.total = {};
    this.head = {};
    this.tail = {};
    this[_o._]._nodes = {};
  }

  Listag.prototype.add = function(cargo, id, tags) {
    var M, i, j, k, len, len1, node, tag, tmp;
    if (tags == null) {
      tags = [];
    }
    M = "/listag/src/Listag.litcoffee Listag::add()\n  ";
    id = id || _o.uid();
    _o.validator(M + "argument ", {
      id: id
    })("id <string " + ID_RULE + ">");
    if (!_o.isU(this[_o._]._nodes[id])) {
      throw RangeError(M + ("a node with id '" + id + "' already exists"));
    }
    _o.vArray(M + "argument tags", tags, "<array of string " + TAG_RULE + ">", []);
    tmp = {};
    for (i = j = 0, len = tags.length; j < len; i = ++j) {
      tag = tags[i];
      if ('node' === tag) {
        throw RangeError(M + ("argument tags[" + i + "] is the special tag 'node'"));
      }
      if (!_o.isU(tmp[tag])) {
        throw RangeError(M + ("argument tags[" + i + "] is a duplicate of tags[" + tmp[tag] + "]"));
      }
      tmp[tag] = i;
    }
    tags.push('node');
    node = new Node(cargo);
    for (k = 0, len1 = tags.length; k < len1; k++) {
      tag = tags[k];
      node.previous[tag] = this.total[tag] ? this.tail[tag] : null;
      node.next[tag] = null;
      if (this.total[tag]) {
        this.tail[tag].next[tag] = node;
      } else {
        this.head[tag] = node;
        this.total[tag] = 0;
      }
      this.tail[tag] = node;
      this.total[tag]++;
    }
    this[_o._]._nodes[id] = node;
    return id;
  };

  Listag.prototype.read = function(id) {
    var M, node;
    M = "/listag/src/Listag.litcoffee Listag::read()\n  ";
    node = this[_o._]._nodes[id];
    if (_o.isU(node)) {
      _o.validator(M + "argument ", {
        id: id
      })("id <string " + ID_RULE + ">");
      throw RangeError(M + ("the node with id '" + id + "' does not exist"));
    }
    return node.cargo;
  };

  return Listag;

})();

ID_RULE = '^[a-z]\\w{1,23}$';

TAG_RULE = '^[a-z]\\w{1,23}$';

Node = (function() {
  Node.prototype.C = 'Node';

  Node.prototype.toString = function() {
    return '[object Node]';
  };

  function Node(cargo) {
    var M;
    M = "/listag/src/Node.litcoffee Node()\n  ";
    this.previous = {};
    this.next = {};
    this.cargo = cargo;
  }

  return Node;

})();

if ('undefined' === typeof console || !console.log) {
  _o = function() {};
} else if ('object' === typeof console.log) {
  _o = Function.prototype.bind(console.log, console);
} else {
  _o = console.log.bind(console);
}

_o.A = 'array';

_o.B = 'boolean';

_o.D = 'document';

_o.E = 'error';

_o.F = 'function';

_o.N = 'number';

_o.O = 'object';

_o.R = 'regexp';

_o.S = 'string';

_o.U = 'undefined';

_o.X = 'null';

_o.G = _oG;

_o.T = _oT;

_o.V = _oV;

_o._ = ('' + Math.random()).substr(2);

_o.is = function(c, t, f) {
  if (t == null) {
    t = true;
  }
  if (f == null) {
    f = false;
  }
  if (c) {
    return t;
  } else {
    return f;
  }
};

_o.isU = function(x) {
  return _o.U === typeof x;
};

_o.isX = function(x) {
  return null === x;
};

_o.type = function(a) {
  var ta;
  if (_o.isX(a)) {
    return _o.X;
  }
  ta = typeof a;
  if ({
    undefined: 1,
    string: 1,
    number: 1,
    boolean: 1
  }[ta]) {
    return ta;
  }
  if (!a.nodeName && a.constructor !== Array && /function/i.test('' + a)) {
    return _o.F;
  }
  return {}.toString.call(a).match(/\s([a-z0-9]+)/i)[1].toLowerCase();
};

_o.ex = function(x, a, b) {
  var pos;
  if (-1 === (pos = a.indexOf(x))) {
    return x;
  } else {
    return b.charAt(pos);
  }
};

_o.has = function(h, n, t, f) {
  if (t == null) {
    t = true;
  }
  if (f == null) {
    f = false;
  }
  if (-1 !== h.indexOf(n)) {
    return t;
  } else {
    return f;
  }
};

_o.uid = function(p, l) {
  var c;
  if (p == null) {
    p = 'id';
  }
  if (l == null) {
    l = 8;
  }
  c = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
  return p + '_' + ((function() {
    var results;
    results = [];
    while (l--) {
      results.push(c.charAt(Math.floor(Math.random() * 62)));
    }
    return results;
  })()).join('');
};

_o.insert = function(basis, overlay, offset) {
  return basis.slice(0, offset) + overlay + basis.slice(offset + overlay.length);
};

_o.define = function(obj, name, value, kind) {
  switch (kind) {
    case 'constant':
      return Object.defineProperty(obj, name, {
        value: value,
        enumerable: true
      });
    case 'hid':
      return Object.defineProperty(obj, name, {
        value: value,
        enumerable: false
      });
  }
};

_o.vArray = function(M, arr, signature, fallback) {
  var i, j, k, len, len1, matches, max, min, pass, ref, ref1, results, rule, tv, type, types, value;
  matches = signature.match(/^<array of ([|a-z]+)\s*(.*)>$/i);
  if (!matches) {
    throw RangeError("/listag/src/_o-helpers.litcoffee _o.vArray()\n  signature " + signature + " is invalid");
  }
  signature = matches[0], types = matches[1], rule = matches[2];
  if (!arr) {
    return fallback;
  }
  if (_o.A !== _o.type(arr)) {
    throw RangeError(M + (" is type " + (_o.type(arr)) + " not array"));
  }
  results = [];
  for (i = j = 0, len = arr.length; j < len; i = ++j) {
    value = arr[i];
    tv = _o.type(value);
    pass = false;
    ref = types.split('|');
    for (k = 0, len1 = ref.length; k < len1; k++) {
      type = ref[k];
      if ((_o.N === type || _o.I === type) && _o.N === tv) {
        if (_o.I === type && value % 1) {
          throw RangeError(M + ("[" + i + "] is a number but not an integer"));
        }
        if (rule) {
          ref1 = rule.split('-'), min = ref1[0], max = ref1[1];
          if (value < min || value > max) {
            throw RangeError(M + ("[" + i + "] is " + value + " (must be " + rule + ")"));
          }
        }
        pass = true;
        break;
      }
      if (type === tv) {
        if (_o.S === tv && rule) {
          if (!RegExp(rule).test(value)) {
            throw RangeError(M + ("[" + i + "] fails " + rule));
          }
        }
        pass = true;
        break;
      }
      if (/^[A-Z]/.test(type)) {
        if (_o.O === tv) {
          if (eval("value instanceof " + type)) {
            pass = true;
            break;
          }
        }
      }
    }
    if (pass) {
      continue;
    }
    throw TypeError(M + ("[" + i + "] is type " + tv + " not " + types));
  }
  return results;
};

_o.validator = function(M, obj) {
  return function(signature, fallback) {
    var j, key, len, matches, max, min, ref, ref1, rule, tv, type, types, value;
    matches = signature.match(/^([_a-z][_a-z0-9]*)\s+<([|a-z]+)\s*(.*)>$/i);
    if (!matches) {
      throw RangeError("/listag/src/_o-helpers.litcoffee _o.validator()\n  signature " + signature + " is invalid");
    }
    signature = matches[0], key = matches[1], types = matches[2], rule = matches[3];
    value = obj[key];
    tv = _o.type(value);
    if (_o.U === tv) {
      if (2 === arguments.length) {
        return fallback;
      }
      throw TypeError(M + key + " is undefined and has no fallback");
    }
    ref = types.split('|');
    for (j = 0, len = ref.length; j < len; j++) {
      type = ref[j];
      if ((_o.N === type || _o.I === type) && _o.N === tv) {
        if (_o.I === type && value % 1) {
          throw RangeError(M + key + " is a number but not an integer");
        }
        if (rule) {
          ref1 = rule.split('-'), min = ref1[0], max = ref1[1];
          if (value < min || value > max) {
            throw RangeError(M + key + (" is " + value + " (must be " + rule + ")"));
          }
        }
        return value;
      }
      if (type === tv) {
        if (_o.S === tv && rule) {
          if (!RegExp(rule).test(value)) {
            throw RangeError(M + key + (" fails " + rule));
          }
        }
        return value;
      }
      if (/^[A-Z]/.test(type)) {
        if (_o.O === tv) {
          if (eval("value instanceof " + type)) {
            return value;
          }
        }
      }
    }
    throw TypeError(M + key + (" is type " + tv + " not " + types));
  };
};

if (_o.F === typeof define && define.amd) {
  define(function() {
    return Listag;
  });
} else if (_o.O === typeof module && module && module.exports) {
  module.exports = Listag;
} else {
  _o.G.Listag = Listag;
}
}).call(this,this);
