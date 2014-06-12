module System.DevUtils.Redis.Helpers.CommandStats.JSON (
) where

import System.DevUtils.Redis.Helpers.CommandStats.Include (CommandStat(..), CommandStats(..))

import qualified Data.ByteString as B
import Data.Aeson (FromJSON, ToJSON, decode, encode)

instance FromJSON CommandStat
instance ToJSON CommandStat

instance FromJSON CommandStats
instance ToJSON CommandStats
