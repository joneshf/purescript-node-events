# Module Documentation

## Module Node.Events

### Types

    data Emitter :: *


### Type Class Instances

    instance eventEmitterEmitter :: EventEmitter Emitter


### Values

    addListener :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit)) => Event -> fn -> e -> Eff (event :: EventEff | eff) e

    emit :: forall eff e arg. (EventEmitter e) => Event -> arg -> e -> Eff (event :: EventEff | eff) Boolean

    emitter :: forall eff. Eff (event :: EventEff | eff) Emitter

    listeners :: forall eff e. (EventEmitter e) => Event -> e -> Eff (event :: EventEff | eff) [Event]

    newListenerEvent :: Event

    on :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit)) => Event -> fn -> e -> Eff (event :: EventEff | eff) e

    once :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit)) => Event -> fn -> e -> Eff (event :: EventEff | eff) e

    removeAllListeners :: forall eff e. (EventEmitter e) => [Event] -> e -> Eff (event :: EventEff | eff) e

    removeListener :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit)) => Event -> fn -> e -> Eff (event :: EventEff | eff) e

    removeListenerEvent :: Event

    setMaxListeners :: forall eff e. (EventEmitter e) => Number -> e -> Eff (event :: EventEff | eff) e



