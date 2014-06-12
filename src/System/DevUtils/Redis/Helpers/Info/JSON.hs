module System.DevUtils.Redis.Helpers.Info.JSON (
) where

import System.DevUtils.Redis.Helpers.Info.Include (Info(..))

import qualified Data.ByteString as B
import Data.Aeson (FromJSON, ToJSON, decode, encode)

instance FromJSON Info
instance ToJSON Info
