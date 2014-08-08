module Node.Events
  ( Emitter()
  , Event(..)
  , EventEff()
  , EventEmitter
  , Variadic
  -- Creating listeners.
  , emitter
  -- Manipulating listeners.
  , addListener
  , listeners
  , on
  , once
  , removeAllListeners
  , removeListener
  , setMaxListeners
  -- Default listeners.
  , newListenerEvent
  , removeListenerEvent
  ) where

  import Control.Monad.Eff (returnE, Eff())

  import Data.Function
    ( Fn0()
    , Fn1()
    , Fn2()
    , Fn3()
    , Fn4()
    , Fn5()
    , Fn6()
    , Fn7()
    , Fn8()
    , Fn9()
    , Fn10()
    )

  foreign import data EventEff :: !

  class EventEmitter e

  instance eventEmitterEmitter :: EventEmitter Emitter

  class Variadic func ret

  instance variadicArr  :: Variadic (a -> b) c
  instance variadicFn0  :: Variadic (Fn0  a) b
  instance variadicFn1  :: Variadic (Fn1  a b) c
  instance variadicFn2  :: Variadic (Fn2  a b c) d
  instance variadicFn3  :: Variadic (Fn3  a b c d) e
  instance variadicFn4  :: Variadic (Fn4  a b c d e) f
  instance variadicFn5  :: Variadic (Fn5  a b c d e f) g
  instance variadicFn6  :: Variadic (Fn6  a b c d e f g) h
  instance variadicFn7  :: Variadic (Fn7  a b c d e f g h) i
  instance variadicFn8  :: Variadic (Fn8  a b c d e f g h i) j
  instance variadicFn9  :: Variadic (Fn9  a b c d e f g h i j) k
  instance variadicFn10 :: Variadic (Fn10 a b c d e f g h i j k) l

  newtype Event = Event String

  newListenerEvent :: Event
  newListenerEvent = Event "newListener"

  removeListenerEvent :: Event
  removeListenerEvent = Event "removeListener"

  foreign import data Emitter :: *

  foreign import emitter
    "function emitter () {\
    \  var EE = require('events').EventEmitter;\
    \  return new EE()\
    \}" :: forall eff. Eff (event :: EventEff | eff) Emitter

  foreign import emitterHelper1
    "function emitterHelper1(__dict) {\
    \  return function(method) {\
    \    return function(event) {\
    \      return function(emitter) {\
    \        return function() {\
    \          return emitter[method](event);\
    \        }\
    \      }\
    \    }\
    \  }\
    \}" :: forall eff e a b
        .  (EventEmitter e)
        => String
        -> a
        -> e
        -> Eff (event :: EventEff | eff) b

  foreign import emitterHelper2
    "function emitterHelper2(__emitter) {\
    \  return function(__variadic) {\
    \    return function(method) {\
    \      return function(event) {\
    \        return function(cb) {\
    \          return function(emitter) {\
    \            return function() {\
    \              return emitter[method](event, function() {\
    \                return cb.apply(this, arguments)();\
    \              }.bind(this));\
    \            }\
    \          }\
    \        }\
    \      }\
    \    }\
    \  }\
    \}" :: forall eff e fn
        .  (EventEmitter e, Variadic fn (Eff eff Unit))
        => String
        -> Event
        -> fn
        -> e
        -> Eff (event :: EventEff | eff) e

  addListener :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit))
              => Event -> fn -> e -> Eff (event :: EventEff | eff) e
  addListener = emitterHelper2 "addListener"

  on :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit))
     => Event -> fn -> e -> Eff (event :: EventEff | eff) e
  on = emitterHelper2 "on"

  once :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit))
       => Event -> fn -> e -> Eff (event :: EventEff | eff) e
  once = emitterHelper2 "once"

  removeListener :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit))
                 => Event -> fn -> e -> Eff (event :: EventEff | eff) e
  removeListener = emitterHelper2 "removeListener"

  removeAllListeners :: forall eff e. (EventEmitter e)
                     => [Event] -> e -> Eff (event :: EventEff | eff) e
  removeAllListeners = emitterHelper1 "removeAllListeners"

  setMaxListeners :: forall eff e. (EventEmitter e)
                  => Number -> e -> Eff (event :: EventEff | eff) e
  setMaxListeners = emitterHelper1 "setMaxListeners"

  listeners :: forall eff e. (EventEmitter e)
            => Event -> e -> Eff (event :: EventEff | eff) [Event]
  listeners = emitterHelper1 "listeners"
