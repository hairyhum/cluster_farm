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
window.require.register("test/Component.test", function(exports, require, module) {
  var Component;

  Component = require('../app/Component').Component;

  exports.ComponentTest = {
    'test constructor': function(test) {
      var component;
      component = new Component();
      test.ok(component.id !== null);
      return test.done();
    }
  };
  
});
window.require.register("test/Constructor", function(exports, require, module) {
  var App, Component, Constructor, DB, Events, Request, RequestType, Schema, Simulator, Web;

  Simulator = require('../app/Simulator').Simulator;

  Web = Simulator.Web, Schema = Simulator.Schema, Request = Simulator.Request, RequestType = Simulator.RequestType, Events = Simulator.Events, Component = Simulator.Component, Constructor = Simulator.Constructor, DB = Simulator.DB, App = Simulator.App;

  exports.constrTest = {
    'test addElement': function(test) {
      this.constr = new Constructor();
      this.constr.addElement(Web);
      test.equal(2, this.constr.schema.components.length);
      this.constr.addElement(Web);
      test.equal(3, this.constr.schema.components.length);
      return test.done();
    },
    'test deleteElement': function(test) {
      var id;
      this.constr = new Constructor();
      this.constr.addElement(Web);
      test.equal(2, this.constr.schema.components.length);
      id = this.constr.addElement(DB);
      test.equal(3, this.constr.schema.components.length);
      this.constr.deleteElement(id);
      test.equal(2, this.constr.schema.components.length);
      return test.done();
    },
    'test connectElement': function(test) {
      var first, second;
      this.constr = new Constructor();
      first = this.constr.addElement(Web);
      test.equal(2, this.constr.schema.components.length);
      second = this.constr.addElement(DB);
      test.equal(3, this.constr.schema.components.length);
      this.constr.connectElement(first, second);
      test.ok(this.constr.validate);
      return test.done();
    },
    'test disconnectElement': function(test) {
      var first, second;
      this.constr = new Constructor();
      first = this.constr.addElement(Web);
      test.equal(2, this.constr.schema.components.length);
      second = this.constr.addElement(DB);
      test.equal(3, this.constr.schema.components.length);
      this.constr.connectElement(first, second);
      test.ok(this.constr.validate);
      this.constr.disconnectElement(first, second);
      test.ok(this.constr.validate);
      return test.done();
    },
    'test disconnectElement': function(test) {
      var id;
      this.constr = new Constructor();
      id = this.constr.addElement(App);
      test.equal(2, this.constr.schema.components.length);
      this.constr.setRoot(id);
      test.ok(this.constr.validate);
      this.constr.disconnectElement(id, this.constr.schema.client.id);
      test.equal(2, this.constr.schema.components.length);
      test.ok(this.constr.validate);
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
window.require.register("test/Schema", function(exports, require, module) {
  var Component, Events, Request, RequestType, Schema, Simulator, Web;

  Simulator = require('../app/Simulator').Simulator;

  Web = Simulator.Web, Schema = Simulator.Schema, Request = Simulator.Request, RequestType = Simulator.RequestType, Events = Simulator.Events, Component = Simulator.Component;

  exports.ObserverTest = {
    setUp: function(callback) {
      return callback();
    },
    'test Schema': function(test) {
      var root, schema, testRequest;
      schema = new Schema;
      root = schema.addComponent(new Web);
      schema.setRoot(root);
      testRequest = new Request(RequestType.read, 600);
      console.log(schema.client.reset());
      console.log(schema.client.run(15, 10, 100, 0.5));
      console.log(schema.client.onRequestTerminated(testRequest));
      console.log(schema.client.generate_requests(10, 100, 0.5));
      console.log('sleep');
      setTimeout((function() {
        console.log(schema.client.subscribers[Events.read_request]);
        console.log(schema.client.subscribers[Events.write_request]);
        return console.log(schema.client.destinations[0].component);
      }), 2000);
      console.log("root");
      console.log(root.reserveRead());
      console.log(root.reserveWrite());
      console.log(root.process(testRequest));
      console.log(root.requestReserves(testRequest));
      console.log(root.latency());
      console.log(root.exp_base());
      console.log(root.min_latency());
      console.log(root.max_latency());
      console.log(root.destination());
      test.equal(1, 1);
      return test.done();
    },
    'test get element by id': function(test) {
      var c1, c2, schema;
      schema = new Schema;
      c1 = schema.addComponent(new Web);
      schema.setRoot(c1);
      console.log(c1.id);
      c2 = schema.addComponent(new Component);
      test.equal(c2.id, schema.getElementById(c2.id).id);
      return test.done();
    }
  };
  
});

