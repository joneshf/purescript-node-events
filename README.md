# Module Documentation

## Module Node.Events

### Types

    newtype Event where
      Event :: String -> Event

    data EventEff :: !


### Type Classes

    class EventEmitter e where

    class Variadic func ret where


### Type Class Instances

    instance variadicFn0 :: Variadic (Fn0 a) a

    instance variadicFn1 :: Variadic (Fn1 a b) b

    instance variadicFn10 :: Variadic (Fn10 a b c d e f g h i j k) k

    instance variadicFn2 :: Variadic (Fn2 a b c) c

    instance variadicFn3 :: Variadic (Fn3 a b c d) d

    instance variadicFn4 :: Variadic (Fn4 a b c d e) e

    instance variadicFn5 :: Variadic (Fn5 a b c d e f) f

    instance variadicFn6 :: Variadic (Fn6 a b c d e f g) g

    instance variadicFn7 :: Variadic (Fn7 a b c d e f g h) h

    instance variadicFn8 :: Variadic (Fn8 a b c d e f g h i) i

    instance variadicFn9 :: Variadic (Fn9 a b c d e f g h i j) j


### Values

    addListener :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit)) => Event -> fn -> e -> Eff (event :: EventEff | eff) e

    emitterHelper1 :: forall eff e a b. (EventEmitter e) => String -> a -> e -> Eff (event :: EventEff | eff) b

    emitterHelper2 :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit)) => String -> Event -> fn -> e -> Eff (event :: EventEff | eff) e

    listeners :: forall eff e. (EventEmitter e) => Event -> e -> Eff (event :: EventEff | eff) [Event]

    on :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit)) => Event -> fn -> e -> Eff (event :: EventEff | eff) e

    once :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit)) => Event -> fn -> e -> Eff (event :: EventEff | eff) e

    removeAllListeners :: forall eff e. (EventEmitter e) => [Event] -> e -> Eff (event :: EventEff | eff) e

    removeListener :: forall eff e fn. (EventEmitter e, Variadic fn (Eff eff Unit)) => Event -> fn -> e -> Eff (event :: EventEff | eff) e

    setMaxListeners :: forall eff e. (EventEmitter e) => Number -> e -> Eff (event :: EventEff | eff) e



