{-# LANGUAGE OverloadedStrings #-}
module System.DevUtils.Redis.Helpers.CommandStats.Parser (
 runParse'CommandStat
) where

import System.DevUtils.Redis.Helpers.CommandStats.Include
import System.DevUtils.Redis.Helpers.CommandStats.Default

import System.DevUtils.Parser.Lang.Haskell.ByteString (float)

import Text.Parsec
import Text.Parsec.ByteString
import Data.ByteString

runParse'CommandStat' :: Parser CommandStat
runParse'CommandStat' = do
 _ <- string "cmdstat_"
 cmd <- many1 alphaNum
 string ":"
 _ <- string "calls="
 calls <- many1 digit
 string ","
 _ <- string "usec="
 usec <- many1 digit
 string ","
 _ <- string "usec_per_call="
 usec_per_call <- try float
 return $ default' {
  _type = cmd,
  _numCalls = (read calls :: Integer),
  _totalCpu = (read usec :: Integer),
  _avgCpu = usec_per_call
 }

runParse'CommandStat :: ByteString -> Maybe CommandStat
runParse'CommandStat bs = do
 case (runParser runParse'CommandStat' () "CommandStat" bs) of
  (Left err) -> Nothing
  (Right val) -> Just val
