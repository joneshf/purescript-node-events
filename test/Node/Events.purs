module Test.Node.Events where

  import Prelude
  import Control.Monad.Eff (Eff())

  import Control.Monad.Eff.Console (log, CONSOLE())

  import Control.Events(Event(..), EventEff())
  import Node.Events (emit, emitter, on, newListenerEvent)

  foreign import toString :: forall a. a -> String

  main :: Eff (event :: EventEff, console :: CONSOLE) Boolean
  main = emitter
    >>= on newListenerEvent (\name -> log $ "added a new event: " ++ toString name)
    >>= on (Event "Here's some candy") (\candy -> log $ "Check out this candy: " ++ toString candy)
    >>= emit (Event "Here's some candy") "Skittles"
