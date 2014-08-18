module System.DevUtils.Redis.JSON (
) where

import System.DevUtils.Redis.Include

import Data.Aeson (FromJSON, ToJSON, decode, encode)

instance FromJSON Status
instance ToJSON Status

instance FromJSON RoleType
instance ToJSON RoleType
