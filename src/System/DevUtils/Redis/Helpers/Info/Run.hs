{-# LANGUAGE OverloadedStrings #-}
module System.DevUtils.Redis.Helpers.Info.Run (
 run'1
) where

import System.DevUtils.Redis.Helpers.Info.Include
import System.DevUtils.Redis.Helpers.Info.Marshall
import Database.Redis
import Data.Maybe

run'1 :: Connection -> IO (Maybe Info)
run'1 conn = do
 either <- runRedis conn info
 case either of
  (Left err) -> return Nothing
  (Right bs) -> return $ unMarshall'1 bs
