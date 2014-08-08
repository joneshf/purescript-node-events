module Test.Node.Events where

  import Debug.Trace (print)

  import Node.Events (Event(..), emitter, on, newListenerEvent)

  foreign import toString
    "function toString(x) {\
    \  return x.toString();\
    \};" :: forall a. a -> String

  main = emitter
    >>= on newListenerEvent (\name -> print $ "added a new event: " ++ toString name)
    >>= on newListenerEvent (toString >>> print)
    >>= on (Event "wat")    (\_ -> print "someone emitted 'wat'!!")
