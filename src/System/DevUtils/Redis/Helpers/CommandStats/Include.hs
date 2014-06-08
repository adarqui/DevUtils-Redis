module System.DevUtils.Redis.Helpers.CommandStats.Include (
 CommandStat(..)
) where

data CommandStat = CommandStat {
 _type :: String,
 _numCalls :: Integer,
 _totalCpu :: Integer,
 _avgCpu :: Double
} deriving (Show)
