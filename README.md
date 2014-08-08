# Module Documentation

## Module Node.Events

### Types

    data Emitter :: *

    newtype Event where
      Event :: String -> Event

    data EventEff :: !


### Type Classes

    class EventEmitter e where

    class Variadic func ret where


### Type Class Instances

    instance eventEmitterEmitter :: EventEmitter Emitter

    instance variadicArr :: Variadic (a -> b) c

    instance variadicFn0 :: Variadic (Fn0 a) b

    instance variadicFn1 :: Variadic (Fn1 a b) c

    instance variadicFn10 :: Variadic (Fn10 a b c d e f g h i j k) l

    instance variadicFn2 :: Variadic (Fn2 a b c) d

    instance variadicFn3 :: Variadic (Fn3 a b c d) e

    instance variadicFn4 :: Variadic (Fn4 a b c d e) f

    instance variadicFn5 :: Variadic (Fn5 a b c d e f) g

    instance variadicFn6 :: Variadic (Fn6 a b c d e f g) h

    instance variadicFn7 :: Variadic (Fn7 a b c d e f g h) i

    instance variadicFn8 :: Variadic (Fn8 a b c d e f g h i) j

    instance variadicFn9 :: Variadic (Fn9 a b c d e f g h i j) k


### Values

    addListener :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit)) => Event -> fn -> e -> Eff (event :: EventEff | eff) e

    emitter :: forall eff. Eff (event :: EventEff | eff) Emitter

    listeners :: forall eff e. (EventEmitter e) => Event -> e -> Eff (event :: EventEff | eff) [Event]

    newListenerEvent :: Event

    on :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit)) => Event -> fn -> e -> Eff (event :: EventEff | eff) e

    once :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit)) => Event -> fn -> e -> Eff (event :: EventEff | eff) e

    removeAllListeners :: forall eff e. (EventEmitter e) => [Event] -> e -> Eff (event :: EventEff | eff) e

    removeListener :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit)) => Event -> fn -> e -> Eff (event :: EventEff | eff) e

    removeListenerEvent :: Event

    setMaxListeners :: forall eff e. (EventEmitter e) => Number -> e -> Eff (event :: EventEff | eff) e



