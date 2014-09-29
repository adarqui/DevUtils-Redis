{-# LANGUAGE OverloadedStrings #-}
module System.DevUtils.Redis.Helpers.Info.Parser (
 runParse'Keyspace
) where

import System.DevUtils.Redis.Helpers.Info.Include
import System.DevUtils.Redis.Helpers.Info.Default

import System.DevUtils.Parser.Lang.Haskell.ByteString (float)

import Text.Parsec
import Text.Parsec.ByteString
import Data.ByteString

-- db2:keys=2,expires=0,avg_ttl=0

runParse'Keyspace' :: Parser Keyspace
runParse'Keyspace' = do
 _ <- string "db"
 db <- many1 digit
 string ":"
 _ <- string "keys="
 keys <- many1 digit
 string ","
 _ <- string "expires="
 expires <- many1 digit
-- string ","
-- _ <- string "avg_ttl="
-- avgTtl <- many1 digit
 return $ Keyspace {
  _db = (read db :: Int),
  _keys = (read keys :: Int),
  _expires = (read expires :: Int),
  _avgTtl = Nothing
--  _avgTtl = (read expires :: Int)
 }

runParse'Keyspace :: ByteString -> Maybe Keyspace
runParse'Keyspace bs = do
 case (runParser runParse'Keyspace' () "Keyspace" bs) of
  (Left err) -> Nothing
  (Right val) -> Just val
