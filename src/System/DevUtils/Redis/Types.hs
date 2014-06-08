module System.DevUtils.Redis.Types (
 rBool,
 rString,
 rInteger,
 rFloat
) where

rBool :: String -> Bool
rBool "0" = False
rBool "1" = True

rString :: String -> String
rString s = s

rInteger :: String -> Integer
rInteger s = (read s :: Integer)

rFloat :: String -> Float
rFloat s = (read s :: Float)
