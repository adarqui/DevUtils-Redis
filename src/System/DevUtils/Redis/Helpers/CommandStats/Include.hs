module System.DevUtils.Redis.Helpers.CommandStats.Include (
 CommandStat(..),
 CommandStats(..)
) where

data CommandStats = CommandStats [CommandStat] deriving (Show, Read, Eq)

data CommandStat = CommandStat {
 _type :: String,
 _numCalls :: Integer,
 _totalCpu :: Integer,
 _avgCpu :: Double
} deriving (Show, Read, Eq)
