module System.DevUtils.Redis.Helpers.CommandStats.Default (
 defaultCommandStats,
 defaultCommandStat
) where

import System.DevUtils.Redis.Helpers.CommandStats.Include
import Data.Maybe

defaultCommandStats :: [CommandStat]
defaultCommandStats = []

defaultCommandStat :: CommandStat
defaultCommandStat = CommandStat {
 _type = "",
 _numCalls = 0,
 _totalCpu = 0.0,
 _avgCpu = 0.0
}
