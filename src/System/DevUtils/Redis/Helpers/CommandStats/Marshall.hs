{-# LANGUAGE OverloadedStrings #-}
module System.DevUtils.Redis.Helpers.CommandStats.Marshall (
 unMarshall'1,
 unMarshall'List
) where

import System.DevUtils.Redis.Helpers.CommandStats.Include (CommandStat(..))
import System.DevUtils.Redis.Helpers.CommandStats.Default (default')
import System.DevUtils.Redis.Helpers.CommandStats.Parser (runParse'1)
import System.DevUtils.Base.Data.Map (kvListToMap)
import System.DevUtils.Parser.Lines.ByteString (runLines, defaultLines)

import qualified Data.ByteString as B
import Data.Maybe (Maybe(..), catMaybes)

unMarshall'List :: B.ByteString -> Maybe [CommandStat]
unMarshall'List bs =
 case (runLines defaultLines bs) of
  (Left _) -> Nothing
  (Right val) -> unMarshall'List' val

unMarshall'List' :: [B.ByteString] -> Maybe [CommandStat]
unMarshall'List' linelist = Just $ catMaybes $ map unMarshall'1 linelist

unMarshall'1 :: B.ByteString -> Maybe CommandStat
unMarshall'1 bs = runParse'1 bs
