{-# LANGUAGE OverloadedStrings, RecordWildCards #-}
module System.DevUtils.Redis.Helpers.CommandStats.JSON (
 CommandStat(..),
 CommandStats(..),
 unMarshall'Value
) where

import System.DevUtils.Redis.Helpers.CommandStats.Include (CommandStat(..), CommandStats(..))

import System.DevUtils.Redis.Helpers.CommandStats.Include (CommandStat(..))
import System.DevUtils.Base.Data.Map (kvListToMap)
import System.DevUtils.Parser.Lines.ByteString (runLines, defaultLines)

import Data.Maybe (Maybe(..), catMaybes)

import qualified Data.ByteString as B
import qualified Data.Text as T

import Data.Aeson

instance FromJSON CommandStat
instance ToJSON CommandStat

unMarshall'Value :: [CommandStat] -> Value
unMarshall'Value cs = object $ map (\v -> (T.pack (_type v), cs'to'Value v)) cs

cs'to'Value CommandStat{..} =
 object
  [
   ("_type", toJSON _type),
   ("_numCalls", toJSON _numCalls),
   ("_totalCpu", toJSON _totalCpu),
   ("_avgCpu", toJSON _avgCpu)
  ]
