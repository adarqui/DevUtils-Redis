{-# LANGUAGE OverloadedStrings #-}
module System.DevUtils.Redis.Helpers.CommandStats.Marshall (
 unmarshallCommandStats
) where

import System.DevUtils.Redis.Helpers.CommandStats.Include (CommandStat(..))
import System.DevUtils.Redis.Helpers.CommandStats.Default (defaultCommandStat)
import System.DevUtils.Base.Data.Map (kvListToMap)
import System.DevUtils.Parser.KV.ByteString (runKV, defaultKV)

import qualified Data.ByteString as B

unmarshallCommandStats :: B.ByteString -> Maybe [CommandStat]
unmarshallCommandStats bs =
 case (runKV defaultKV bs) of
  (Left _) -> Nothing
  (Right val) -> unmarshallCommandStats' val

unmarshallCommandStats' :: [(a,b)] -> Maybe [CommandStat]
unmarshallCommandStats' _ = Nothing
