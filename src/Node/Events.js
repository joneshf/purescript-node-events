"use strict";

// module Node.Events
/* eslint-env node*/

exports.emitter = function emitter () {
  var EE = require("events").EventEmitter;
  return new EE();
};
exports.emitterHelper = function emitterHelper1(__dict) {
  return function(method) {
    return function(event) {
      return function(emitter) {
        return function() {
          return emitter[method](event);
        };
      };
    };
  };
};

exports.emitterHelper2 = function emitterHelper2(__emitter) {
  return function(__variadic) {
    return function(method) {
      return function(event) {
        return function(cb) {
          return function(emitter) {
            return function() {
              return emitter[method](event, function() {
                return cb.apply(this, arguments)();
              }.bind(this));
            };
          };
        };
      };
    };
  };
};

exports.emit = function emit(__dict) {
  return function(event) {
    return function(arg) {
      return function(emitter) {
        return function() {
          return emitter.emit(event, arg);
        };
      };
    };
  };
};
