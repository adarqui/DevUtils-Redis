{-# LANGUAGE OverloadedStrings #-}
module System.DevUtils.Redis.Helpers.Info.Marshall (
 unmarshallInfo
) where

import System.DevUtils.Redis.Helpers.Info.Include
import System.DevUtils.Redis.Helpers.Info.Default (defaultInfo)
import System.DevUtils.Base.Data.Map (kvListToMap)
import System.DevUtils.Parser.KV.ByteString (runKV, defaultKV)

import qualified Data.ByteString as B

unmarshallInfo :: B.ByteString -> Maybe Info
unmarshallInfo bs =
 case (runKV defaultKV bs) of
  (Left _) -> Nothing
  (Right _) -> Just defaultInfo
