// Generated by CoffeeScript 1.9.2
(function(global) {
/*! Listag 0.0.14 //// MIT Licence //// http://listag.richplastow.com/ */
var ID_RULE, Listag, Node, TAG_RULE, oo;

if ('undefined' === typeof console || !console.log) {
  oo = function() {};
} else if ('object' === typeof console.log) {
  oo = Function.prototype.bind(console.log, console);
} else {
  oo = console.log.bind(console);
}

oo.G = global;

oo.T = 'Listag';

oo.V = '0.0.14';

oo.A = 'array';

oo.B = 'boolean';

oo.D = 'document';

oo.E = 'error';

oo.F = 'function';

oo.I = 'integer';

oo.N = 'number';

oo.O = 'object';

oo.R = 'regexp';

oo.S = 'string';

oo.U = 'undefined';

oo.X = 'null';

oo._ = (Math.random().toString(36) + '00000000').substr(2, 8);

oo.is = function(c, t, f) {
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

oo.isU = function(x) {
  return oo.U === typeof x;
};

oo.isX = function(x) {
  return null === x;
};

oo.type = function(a) {
  var ta;
  if (oo.isX(a)) {
    return oo.X;
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
    return oo.F;
  }
  return {}.toString.call(a).match(/\s([a-z0-9]+)/i)[1].toLowerCase();
};

oo.ex = function(x, a, b) {
  var pos;
  if (-1 === (pos = a.indexOf(x))) {
    return x;
  } else {
    return b.charAt(pos);
  }
};

oo.has = function(h, n, t, f) {
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

oo.uid = function(p) {
  if (p == null) {
    p = 'id';
  }
  return p + '_' + (Math.random().toString(36) + '00000000').substr(2, 8);
};

oo.uid62 = function(p, l) {
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

oo.pad = function(s, l, c) {
  if (c == null) {
    c = ' ';
  }
  return s + Array(l - s.length + 1).join(c);
};

oo.insert = function(basis, overlay, offset) {
  return basis.slice(0, offset) + overlay + basis.slice(offset + overlay.length);
};

oo.define = function(obj, name, value, kind) {
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

oo.lock = function(obj) {
  var j, key, len, ref;
  ref = Object.keys(obj);
  for (j = 0, len = ref.length; j < len; j++) {
    key = ref[j];
    Object.defineProperty(obj, key, {
      writable: false,
      configurable: false
    });
  }
  Object.preventExtensions(obj);
  if (obj.prototype && obj !== obj.prototype) {
    return oo.lock(obj.prototype);
  }
};

oo.vArray = function(M, arr, signature, fallback) {
  var i, j, k, len, len1, matches, max, min, pass, ref, ref1, results, rule, tv, type, types, value;
  matches = signature.match(/^<array of ([|a-z]+)\s*(.*)>$/i);
  if (!matches) {
    throw RangeError("/listag/oopish/oo-helpers.litcoffee oo.vArray()\n  signature " + signature + " is invalid");
  }
  signature = matches[0], types = matches[1], rule = matches[2];
  if (!arr) {
    return fallback;
  }
  if (oo.A !== oo.type(arr)) {
    throw RangeError(M + (" is type " + (oo.type(arr)) + " not array"));
  }
  results = [];
  for (i = j = 0, len = arr.length; j < len; i = ++j) {
    value = arr[i];
    tv = oo.type(value);
    pass = false;
    ref = types.split('|');
    for (k = 0, len1 = ref.length; k < len1; k++) {
      type = ref[k];
      if ((oo.N === type || oo.I === type) && oo.N === tv) {
        if (oo.I === type && value % 1) {
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
        if (oo.S === tv && rule) {
          if (!RegExp(rule).test(value)) {
            throw RangeError(M + ("[" + i + "] fails " + rule));
          }
        }
        pass = true;
        break;
      }
      if (/^[A-Z]/.test(type)) {
        if (oo.O === tv) {
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

oo.vArg = function(M, value, signature, fallback) {
  var j, key, len, matches, max, min, pfx, ref, ref1, rule, tv, type, types;
  matches = signature.match(/^([_a-z][_a-z0-9]*)\s+<([|a-z]+)\s*(.*)>$/i);
  if (!matches) {
    throw RangeError("/listag/oopish/oo-helpers.litcoffee oo.vArg()\n  signature " + signature + " is invalid");
  }
  signature = matches[0], key = matches[1], types = matches[2], rule = matches[3];
  pfx = M + ("argument " + key + " ");
  tv = oo.type(value);
  if (oo.U === tv) {
    if (4 === arguments.length) {
      return fallback;
    }
    throw TypeError(pfx + "is undefined and has no fallback");
  }
  ref = types.split('|');
  for (j = 0, len = ref.length; j < len; j++) {
    type = ref[j];
    if ((oo.N === type || oo.I === type) && oo.N === tv) {
      if (oo.I === type && value % 1) {
        throw RangeError(pfx + "is a number but not an integer");
      }
      if (rule) {
        ref1 = rule.split('-'), min = ref1[0], max = ref1[1];
        if (value < min || value > max) {
          throw RangeError(pfx + ("is " + value + " (must be " + rule + ")"));
        }
      }
      return value;
    }
    if (type === tv) {
      if (oo.S === tv && rule) {
        if (!RegExp(rule).test(value)) {
          throw RangeError(pfx + ("fails " + rule));
        }
      }
      return value;
    }
    if (/^[A-Z]/.test(type)) {
      if (oo.O === tv) {
        if (eval("value instanceof " + type)) {
          return value;
        }
      }
    }
  }
  throw TypeError(pfx + ("is type " + tv + " not " + types));
};

oo.vObject = function(M, objName, obj) {
  if (oo.O !== oo.type(obj)) {
    throw TypeError(M + objName + (" is type " + (oo.type(obj)) + " not object"));
  }
  return function(signature, fallback) {
    var j, key, len, matches, max, min, ref, ref1, rule, tv, type, types, value;
    matches = signature.match(/^([_a-z][_a-z0-9]*)\s+<([|a-z]+)\s*(.*)>$/i);
    if (!matches) {
      throw RangeError("/listag/oopish/oo-helpers.litcoffee oo.vObject()\n  signature " + signature + " is invalid");
    }
    signature = matches[0], key = matches[1], types = matches[2], rule = matches[3];
    value = obj[key];
    tv = oo.type(value);
    if (oo.U === tv) {
      if (2 === arguments.length) {
        return fallback;
      }
      throw TypeError(M + objName + '.' + key + " is undefined and has no fallback");
    }
    ref = types.split('|');
    for (j = 0, len = ref.length; j < len; j++) {
      type = ref[j];
      if ((oo.N === type || oo.I === type) && oo.N === tv) {
        if (oo.I === type && value % 1) {
          throw RangeError(M + objName + '.' + key + " is a number but not an integer");
        }
        if (rule) {
          ref1 = rule.split('-'), min = ref1[0], max = ref1[1];
          if (value < min || value > max) {
            throw RangeError(M + objName + '.' + key + (" is " + value + " (must be " + rule + ")"));
          }
        }
        return value;
      }
      if (type === tv) {
        if (oo.S === tv && rule) {
          if (!RegExp(rule).test(value)) {
            throw RangeError(M + objName + '.' + key + (" fails " + rule));
          }
        }
        return value;
      }
      if (/^[A-Z]/.test(type)) {
        if (oo.O === tv) {
          if (eval("value instanceof " + type)) {
            return value;
          }
        }
      }
    }
    throw TypeError(M + objName + '.' + key + (" is type " + tv + " not " + types));
  };
};

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
    oo.define(this, oo._, {}, 'hid');
    this.total = {};
    this.head = {};
    this.tail = {};
    this[oo._]._nodes = {};
    if ('Listag' === this.C) {
      oo.lock(this);
    }
  }

  Listag.prototype.browse = function(config) {
    var M, j, k, len, len1, len2, m, maxId, maxType, meta, node, out, ref, ref1, row, t, tag, tags, type, v;
    if (config == null) {
      config = {};
    }
    M = "/listag/src/Listag.litcoffee Listag::browse()\n  ";
    v = oo.vObject(M, 'config', config);
    v('format <string ^text|array$>', 'text');
    if (!this.total.node) {
      if ('array' === config.format) {
        return [];
      } else {
        return '[empty]';
      }
    }
    maxId = 0;
    maxType = 0;
    meta = [];
    node = this.head.node;
    while (node) {
      tags = {};
      for (tag in node.next) {
        tags[tag] = 'x';
      }
      type = oo.type(node.cargo);
      meta.push({
        id: node.id,
        tags: tags,
        type: type
      });
      maxId = node.id.length > maxId ? node.id.length : maxId;
      maxType = type.length > maxType ? type.length : maxType;
      node = node.next.node;
    }
    if ('array' === config.format) {
      return meta;
    }
    row = oo.pad('', maxId + maxType + 2, '.');
    ref = Object.keys(this.total);
    for (j = 0, len = ref.length; j < len; j++) {
      t = ref[j];
      if ('node' !== t) {
        row += '..' + t;
      }
    }
    out = [row];
    for (k = 0, len1 = meta.length; k < len1; k++) {
      node = meta[k];
      row = oo.pad(node.id, maxId) + '  ' + oo.pad(node.type, maxType);
      ref1 = Object.keys(this.total);
      for (m = 0, len2 = ref1.length; m < len2; m++) {
        t = ref1[m];
        if ('node' !== t) {
          row += '  ' + oo.pad(node.tags[t] || ' ', t.length);
        }
      }
      out.push(row);
    }
    return out.join('\n');
  };

  Listag.prototype.read = function(id) {
    var M, node;
    M = "/listag/src/Listag.litcoffee Listag::read()\n  ";
    node = this[oo._]._nodes[id];
    if (oo.isU(node)) {
      oo.vArg(M, id, "id <string " + ID_RULE + ">");
      throw RangeError(M + ("the node with id '" + id + "' does not exist"));
    }
    return node.cargo;
  };

  Listag.prototype.add = function(cargo, id, tags) {
    var M, i, j, k, len, len1, node, tag, tmp;
    if (tags == null) {
      tags = [];
    }
    M = "/listag/src/Listag.litcoffee Listag::add()\n  ";
    id = id || oo.uid();
    oo.vArg(M, id, "id <string " + ID_RULE + ">");
    if (this[oo._]._nodes[id]) {
      throw RangeError(M + ("a node with id '" + id + "' already exists"));
    }
    oo.vArray(M + "argument tags", tags, "<array of string " + TAG_RULE + ">");
    tmp = {};
    for (i = j = 0, len = tags.length; j < len; i = ++j) {
      tag = tags[i];
      if ('node' === tag) {
        throw RangeError(M + ("argument tags[" + i + "] is the special tag 'node'"));
      }
      if (!oo.isU(tmp[tag])) {
        throw RangeError(M + ("argument tags[" + i + "] is a duplicate of tags[" + tmp[tag] + "]"));
      }
      tmp[tag] = i;
    }
    tags.push('node');
    node = new Node(cargo);
    node.id = id;
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
    this[oo._]._nodes[id] = node;
    return id;
  };

  Listag.prototype["delete"] = function(id) {
    var M, j, len, node, ref, tag;
    M = "/listag/src/Listag.litcoffee Listag::delete()\n  ";
    node = this[oo._]._nodes[id];
    if (oo.isU(node)) {
      oo.vArg(M, id, "id <string " + ID_RULE + ">");
      throw RangeError(M + ("the node with id '" + id + "' does not exist"));
    }
    ref = Object.keys(node.next);
    for (j = 0, len = ref.length; j < len; j++) {
      tag = ref[j];
      if (node.previous[tag]) {
        node.previous[tag].next[tag] = node.next[tag];
      }
      if (node.next[tag]) {
        node.next[tag].previous[tag] = node.previous[tag];
      }
      if (--this.total[tag]) {
        if (!node.previous[tag]) {
          this.head[tag] = node.next[tag];
        }
        if (!node.next[tag]) {
          this.tail[tag] = node.previous[tag];
        }
      } else {
        delete this.total[tag];
        delete this.head[tag];
        delete this.tail[tag];
      }
      delete this[oo._]._nodes[id];
    }
    return void 0;
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

oo.lock(Listag);

if (oo.F === typeof define && define.amd) {
  define(function() {
    return Listag;
  });
} else if (oo.O === typeof module && module && module.exports) {
  module.exports = Listag;
} else {
  oo.G.Listag = Listag;
}
}).call(this,this);
