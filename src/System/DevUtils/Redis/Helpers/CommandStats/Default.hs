module System.DevUtils.Redis.Helpers.CommandStats.Default (
 default'List,
 default'
) where

import System.DevUtils.Redis.Helpers.CommandStats.Include
import Data.Maybe

default'List :: [CommandStat]
default'List = []

default' :: CommandStat
default' = CommandStat {
 _type = "",
 _numCalls = 0,
 _totalCpu = 0,
 _avgCpu = 0.0
}
