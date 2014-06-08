{-# LANGUAGE OverloadedStrings #-}
module System.DevUtils.Redis.Helpers.CommandStats.Marshall (
 unMarshall
) where

import System.DevUtils.Redis.Helpers.CommandStats.Include (CommandStat(..))
import System.DevUtils.Redis.Helpers.CommandStats.Default (default')
import System.DevUtils.Redis.Helpers.CommandStats.Parser (runParse)
import System.DevUtils.Base.Data.Map (kvListToMap)
import System.DevUtils.Parser.Lines.ByteString (runLines, defaultLines)

import qualified Data.ByteString as B
import Data.Maybe (Maybe(..), catMaybes)

unMarshall :: B.ByteString -> Maybe [CommandStat]
unMarshall bs =
 case (runLines defaultLines bs) of
  (Left _) -> Nothing
  (Right val) -> unMarshall' val

unMarshall' :: [B.ByteString] -> Maybe [CommandStat]
unMarshall' linelist = Just $ catMaybes $ map (\line -> runParse line) linelist
