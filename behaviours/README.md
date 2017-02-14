# Behaviours

Test to check how behaviours work
Only seems to check for definition of each function with proper arity
Does not perform any kind of type checking
If you start up with `iex -S mix`
Should see warning about `unknown` module does not define behavior function `talk/1`
But you do not see any warning about `robot` module which returns the wrong type
