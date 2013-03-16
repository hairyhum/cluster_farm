(function(/*! Brunch !*/) {
  'use strict';

  var globals = typeof window !== 'undefined' ? window : global;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};

  var has = function(object, name) {
    return ({}).hasOwnProperty.call(object, name);
  };

  var expand = function(root, name) {
    var results = [], parts, part;
    if (/^\.\.?(\/|$)/.test(name)) {
      parts = [root, name].join('/').split('/');
    } else {
      parts = name.split('/');
    }
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function(name) {
      var dir = dirname(path);
      var absolute = expand(dir, name);
      return globals.require(absolute);
    };
  };

  var initModule = function(name, definition) {
    var module = {id: name, exports: {}};
    definition(module.exports, localRequire(name), module);
    var exports = cache[name] = module.exports;
    return exports;
  };

  var require = function(name) {
    var path = expand(name, '.');

    if (has(cache, path)) return cache[path];
    if (has(modules, path)) return initModule(path, modules[path]);

    var dirIndex = expand(path, './index');
    if (has(cache, dirIndex)) return cache[dirIndex];
    if (has(modules, dirIndex)) return initModule(dirIndex, modules[dirIndex]);

    throw new Error('Cannot find module "' + name + '"');
  };

  var define = function(bundle, fn) {
    if (typeof bundle === 'object') {
      for (var key in bundle) {
        if (has(bundle, key)) {
          modules[key] = bundle[key];
        }
      }
    } else {
      modules[bundle] = fn;
    }
  };

  globals.require = require;
  globals.require.define = define;
  globals.require.register = define;
  globals.require.brunch = true;
})();

window.require.register("test/Calculator.test", function(exports, require, module) {
  var Calculator;

  Calculator = require('../calculator');

  exports.CalculatorTest = {
    'test can add two positive numbers': function(test) {
      var calculator, result;
      calculator = new Calculator;
      result = calculator.add(2, 3);
      test.equal(result, 5);
      return test.done();
    },
    'test can handle negative number addition': function(test) {
      var calculator, result;
      calculator = new Calculator;
      result = calculator.add(-10, 5);
      test.equal(result, -5);
      return test.done();
    },
    'test can subtract two positive numbers': function(test) {
      var calculator, result;
      calculator = new Calculator;
      result = calculator.subtract(10, 6);
      test.equal(result, 4);
      return test.done();
    },
    'test can handle negative number subtraction': function(test) {
      var calculator, result;
      calculator = new Calculator;
      result = calculator.subtract(4, -6);
      test.equal(result, 10);
      return test.done();
    }
  };
  
});
window.require.register("test/Observer.test", function(exports, require, module) {
  var Events, Observer, _ref;

  _ref = require('../app/Observer'), Observer = _ref.Observer, Events = _ref.Events;

  exports.ObserverTest = {
    setUp: function(callback) {
      this.observer = new Observer();
      return callback();
    },
    'test constructor': function(test) {
      test.ok(this.observer.subscribe !== null);
      return test.done();
    },
    'test subscribe': function(test) {
      this.observer.subscribe(Events.read_request, function() {
        return test.equal(1, 1);
      });
      test.equal(1, 1);
      return test.done();
    }
  };
  
});
window.require.register("test/Request.test", function(exports, require, module) {
  var Events, Request, RequestType, _ref;

  Events = require('../app/Observer').Events;

  _ref = require('../app/Request'), Request = _ref.Request, RequestType = _ref.RequestType;

  exports.RequestTest = {
    setUp: function(callback) {
      this.request = new Request(RequestType.read, 600);
      return callback();
    },
    'test constructor': function(test) {
      test.equal(this.request.type, RequestType.read);
      test.equal(this.request.timeout, 600);
      test.equal(this.request.age, 0);
      return test.done();
    },
    'test isRead true': function(test) {
      test.equal(this.request.isRead(), true);
      return test.done();
    },
    'test isWrite false': function(test) {
      test.equal(this.request.isWrite(), false);
      return test.done();
    },
    'test incAge': function(test) {
      this.request.incAge(100);
      test.equal(this.request.age, 100);
      return test.done();
    },
    'test isFailed false': function(test) {
      this.request.age = 500;
      test.equal(this.request.isFailed(), false);
      return test.done();
    },
    'test isFailed true >': function(test) {
      this.request.incAge(700);
      test.equal(this.request.isFailed(), true);
      return test.done();
    },
    'test isFailed true =': function(test) {
      this.request.age = this.request.timeout;
      test.equal(this.request.isFailed(), true);
      return test.done();
    },
    'test isPassed true <': function(test) {
      this.request.incAge(100);
      test.equal(this.request.isPassed(), true);
      return test.done();
    },
    'test isPassed false =': function(test) {
      this.request.age = this.request.timeout;
      test.equal(this.request.isPassed(), false);
      return test.done();
    },
    'test isPassed false >': function(test) {
      this.request.incAge(600);
      test.equal(this.request.isPassed(), false);
      return test.done();
    },
    'test passingEvent true': function(test) {
      test.equal(this.request.passingEvent(), Events.read_request);
      return test.done();
    },
    'test event_subscribes': function(test) {
      test.equal(this.request.event_subscribers(Events.read_request), this.request.subscribers[Events.read_request]);
      return test.done();
    },
    'test terminate': function(test) {
      var req;
      req = new Request(RequestType.write, 300);
      this.request.subscribe(Events.terminate, function() {
        return test.equal(1, 1);
      });
      this.request.terminate();
      return test.done();
    }
  };
  
});
window.require.register("test/test", function(exports, require, module) {
  var App, DB, Schema, Simulator, Web, app, db, schema, web;

  Simulator = require('./app/Simulator').Simulator;

  App = Simulator.App, Web = Simulator.Web, DB = Simulator.DB, Schema = Simulator.Schema;

  schema = new Schema;

  web = schema.addComponent(new Web);

  app = schema.addComponent(new App);

  db = schema.addComponent(new DB);

  schema.connectComponents(app, db);

  schema.setRoot(web);

  schema.client.run(15, 10, 100, 0.5);

  console.log(schema.client.report());

  schema.setRoot(app);

  schema.client.run(15, 10, 100, 0.5);

  console.log(schema.client.report());
  
});

