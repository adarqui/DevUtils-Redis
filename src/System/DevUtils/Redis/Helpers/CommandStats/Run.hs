{-# LANGUAGE OverloadedStrings #-}
module System.DevUtils.Redis.Helpers.CommandStats.Run (
 run,
 commandStats
) where

import System.DevUtils.Redis.Helpers.CommandStats.Include
import System.DevUtils.Redis.Helpers.CommandStats.Marshall

import qualified Data.ByteString as B

import Database.Redis
import Data.Maybe

instance RedisResult CommandStats where
 decode o@(Bulk r) =
  case r of
   Nothing -> Left o
   (Just r') -> let un = unMarshall'List r' in case un of
    Nothing -> Left o
    (Just commands) -> Right $ CommandStats commands
 decode r = Left r

run :: Redis (Either Reply CommandStats)
run = sendRequest ["INFO", "COMMANDSTATS"]

commandStats = run
