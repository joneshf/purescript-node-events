# Module Documentation

## Module Node.Events

### Types

    newtype Event where
      Event :: String -> Event

    data EventEff :: !


### Type Classes

    class EventEmitter e where


### Values

    addListener :: forall eff eff' e a. (EventEmitter e) => Event -> Eff eff a -> e -> Eff (event :: EventEff | eff') e

    listeners :: forall eff eff' e a. (EventEmitter e) => Event -> e -> Eff (event :: EventEff | eff') [Event]

    on :: forall eff eff' e a. (EventEmitter e) => Event -> Eff eff a -> e -> Eff (event :: EventEff | eff') e

    once :: forall eff eff' e a. (EventEmitter e) => Event -> Eff eff a -> e -> Eff (event :: EventEff | eff') e

    removeAllListeners :: forall eff eff' e a. (EventEmitter e) => [Event] -> e -> Eff (event :: EventEff | eff') e

    removeListener :: forall eff eff' e a. (EventEmitter e) => Event -> Eff eff a -> e -> Eff (event :: EventEff | eff') e

    setMaxListeners :: forall eff eff' e a. (EventEmitter e) => Number -> e -> Eff (event :: EventEff | eff') e



