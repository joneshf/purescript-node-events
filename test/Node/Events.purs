module Test.Node.Events where

  import Control.Monad.Eff (Eff())

  import Debug.Trace (print, Trace())

  import Node.Events (Event(..), EventEff(), emit, emitter, on, newListenerEvent)

  foreign import toString
    "function toString(x) {\
    \  return x.toString();\
    \};" :: forall a. a -> String

  main :: Eff (event :: EventEff, trace :: Trace) Boolean
  main = emitter
    >>= on newListenerEvent (\name -> print $ "added a new event: " ++ toString name)
    >>= on (Event "Here's some candy") (\candy -> print $ "Check out this candy: " ++ toString candy)
    >>= emit (Event "Here's some candy") "Skittles"
