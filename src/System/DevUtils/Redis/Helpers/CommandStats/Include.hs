{-# LANGUAGE DeriveGeneric #-}
module System.DevUtils.Redis.Helpers.CommandStats.Include (
 CommandStat(..),
 CommandStats(..)
) where

import GHC.Generics (Generic)

--data CommandStats = CommandStats [CommandStat] deriving (Show, Read, Eq, Generic)
type CommandStats = [CommandStat]

data CommandStat = CommandStat {
 _type :: String,
 _numCalls :: Integer,
 _totalCpu :: Integer,
 _avgCpu :: Double
} deriving (Show, Read, Eq, Generic)
