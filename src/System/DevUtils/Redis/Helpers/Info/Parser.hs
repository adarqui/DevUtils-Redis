{-# LANGUAGE OverloadedStrings #-}
module System.DevUtils.Redis.Helpers.Info.Parser (
 runParse'1
) where

import System.DevUtils.Redis.Helpers.Info.Include
import System.DevUtils.Redis.Helpers.Info.Default

import System.DevUtils.Parser.Lang.Haskell.ByteString (float)

import Text.Parsec
import Text.Parsec.ByteString
import Data.ByteString

-- db2:keys=2,expires=0,avg_ttl=0

runParse'1' :: Parser Keyspace
runParse'1' = do
 _ <- string "db"
 db <- many1 digit
 string ":"
 _ <- string "keys="
 keys <- many1 digit
 string ","
 _ <- string "expires="
 expires <- many1 digit
 string ","
 _ <- string "avg_ttll="
 avgTtl <- many1 digit
 return $ Keyspace {
  _db = (read db :: Int),
  _keys = (read keys :: Int),
  _expires = (read expires :: Int),
  _avgTtl = (read expires :: Int)
 }

runParse'1 :: ByteString -> Maybe Keyspace
runParse'1 bs = do
 case (runParser runParse'1' () "Keyspace" bs) of
  (Left err) -> Nothing
  (Right val) -> Just val
