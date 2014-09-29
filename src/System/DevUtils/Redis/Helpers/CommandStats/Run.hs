{-# LANGUAGE OverloadedStrings, FlexibleInstances #-}
module System.DevUtils.Redis.Helpers.CommandStats.Run (
 run'commandStats,
 run'commandStats'List
) where

import System.DevUtils.Redis.Helpers.CommandStats.Include
import System.DevUtils.Redis.Helpers.CommandStats.Marshall

import qualified Data.ByteString as B

import Database.Redis
import Data.Maybe

instance RedisResult [CommandStat] where
 decode o@(Bulk r) =
  case r of
   Nothing -> Left o
   (Just r') -> let un = unMarshall'List r' in case un of
    Nothing -> Left o
    (Just commands) -> Right commands
 decode r = Left r

run'commandStats :: Redis (Either Reply CommandStats)
run'commandStats = sendRequest ["INFO", "COMMANDSTATS"]

run'commandStats'List :: Connection -> IO (Maybe CommandStats)
run'commandStats'List conn = do
 either <- runRedis conn run'commandStats
 case either of
  (Left err) -> return Nothing
  (Right cs) -> return $ Just cs
