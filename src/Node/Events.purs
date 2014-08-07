module Node.Events
  ( Event(..)
  , EventEff()
  , EventEmitter
  , addListener
  , listeners
  , on
  , once
  , removeAllListeners
  , removeListener
  , setMaxListeners
  ) where

  import Control.Monad.Eff (returnE, Eff())

  foreign import data EventEff :: !

  class EventEmitter e

  newtype Event = Event String

  -- ffi helper
  returnE_ = returnE

  foreign import emitterHelper1
    "function emitterHelper1(__dict) {\
    \  return function(method) {\
    \    return function(event) {\
    \      return function(emitter) {\
    \        return returnE_(emitter[method](event));\
    \      }\
    \    }\
    \  }\
    \}" :: forall eff eff' e a b c
        .  (EventEmitter e)
        => String
        -> b
        -> e
        -> Eff (event :: EventEff | eff') c

  foreign import emitterHelper2
    "function emitterHelper2(__dict) {\
    \  return function(method) {\
    \    return function(event) {\
    \      return function(cb) {\
    \        return function(emitter) {\
    \          return returnE_(emitter[method](event, cb));\
    \        }\
    \      }\
    \    }\
    \  }\
    \}" :: forall eff eff' e a
        .  (EventEmitter e)
        => String
        -> Event
        -> Eff eff a
        -> e
        -> Eff (event :: EventEff | eff') e

  addListener :: forall eff eff' e a. (EventEmitter e)
              => Event -> Eff eff a -> e -> Eff (event :: EventEff | eff') e
  addListener = emitterHelper2 "addListener"

  on :: forall eff eff' e a. (EventEmitter e)
     => Event -> Eff eff a -> e -> Eff (event :: EventEff | eff') e
  on = emitterHelper2 "on"

  once :: forall eff eff' e a. (EventEmitter e)
       => Event -> Eff eff a -> e -> Eff (event :: EventEff | eff') e
  once = emitterHelper2 "once"

  removeListener :: forall eff eff' e a. (EventEmitter e)
                 => Event -> Eff eff a -> e -> Eff (event :: EventEff | eff') e
  removeListener = emitterHelper2 "removeListener"

  removeAllListeners :: forall eff eff' e a.  (EventEmitter e)
                     => [Event] -> e -> Eff (event :: EventEff | eff') e
  removeAllListeners = emitterHelper1 "removeAllListeners"

  setMaxListeners :: forall eff eff' e a.  (EventEmitter e)
                  => Number -> e -> Eff (event :: EventEff | eff') e
  setMaxListeners = emitterHelper1 "setMaxListeners"

  listeners :: forall eff eff' e a.  (EventEmitter e)
            => Event -> e -> Eff (event :: EventEff | eff') [Event]
  listeners = emitterHelper1 "listeners"
