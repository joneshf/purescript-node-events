module Node.Events
  ( Emitter()
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
  -- Emitting events.
  , emit
  -- Default listeners.
  , newListenerEvent
  , removeListenerEvent
  ) where

  import Control.Events (Event(..), EventEff(), EventEmitter, Variadic)
  import Control.Monad.Eff (Eff())
  import Prelude (Unit())

  instance eventEmitterEmitter :: EventEmitter Emitter

  newListenerEvent :: Event
  newListenerEvent = Event "newListener"

  removeListenerEvent :: Event
  removeListenerEvent = Event "removeListener"

  foreign import data Emitter :: *

  foreign import emitter :: forall eff. Eff (event :: EventEff | eff) Emitter

  foreign import emitterHelper1 :: forall eff e a b
        .  (EventEmitter e)
        => String
        -> a
        -> e
        -> Eff (event :: EventEff | eff) b

  foreign import emitterHelper2 :: forall eff e fn
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
                     => Array Event -> e -> Eff (event :: EventEff | eff) e
  removeAllListeners = emitterHelper1 "removeAllListeners"

  setMaxListeners :: forall eff e. (EventEmitter e)
                  => Number -> e -> Eff (event :: EventEff | eff) e
  setMaxListeners = emitterHelper1 "setMaxListeners"

  listeners :: forall eff e. (EventEmitter e)
            => Event -> e -> Eff (event :: EventEff | eff) (Array Event)
  listeners = emitterHelper1 "listeners"

  foreign import emit :: forall eff e arg. (EventEmitter e)
        => Event -> arg -> e -> Eff (event :: EventEff | eff) Boolean
