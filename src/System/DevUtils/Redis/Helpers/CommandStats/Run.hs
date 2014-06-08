{-# LANGUAGE OverloadedStrings #-}
module System.DevUtils.Redis.Helpers.CommandStats.Run (
 run
) where

import System.DevUtils.Redis.Helpers.CommandStats.Include
import System.DevUtils.Redis.Helpers.CommandStats.Marshall
import Database.Redis
import Data.Maybe
import Data.ByteString

{-
 - (Left r) <- runRedis conn $ sendRequest ["info", "commandstats"]
 - let (Bulk b) = r
 - let m = fromJust b
 - runKV defaultKV m
 -}

commandStats :: Redis (Either Reply Integer)
commandStats = sendRequest ["info", "commandstats"]

run :: Connection -> IO (Maybe [CommandStat])
run conn = do
 (Left reply) <- runRedis conn commandStats
 let (Bulk bulk) = reply
 case (isJust bulk) of
  False -> return Nothing
  True -> return $ unMarshall (fromJust bulk)
