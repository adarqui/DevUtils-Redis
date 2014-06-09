{-# LANGUAGE OverloadedStrings #-}
module System.DevUtils.Redis.Types.String (
 rBool,
 rString,
 rInteger,
 rInt,
 rFloat,
 rDouble
) where

rBool :: String -> Bool
rBool "0" = False
rBool "1" = True

rString :: String -> String
rString s = s

rInteger :: String -> Integer
rInteger s = (read s :: Integer)

rInt :: String -> Integer
rInt = rInteger

rDouble :: String -> Double
rDouble s = (read s :: Double)

rFloat :: String -> Double
rFloat = rDouble
