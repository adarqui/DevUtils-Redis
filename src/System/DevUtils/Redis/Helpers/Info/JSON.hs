module System.DevUtils.Redis.Helpers.Info.JSON (
) where

import System.DevUtils.Redis.Helpers.Info.Include
import System.DevUtils.Redis.JSON

import qualified Data.ByteString as B
import Data.Aeson (FromJSON, ToJSON, decode, encode)

{-
instance FromJSON Info
instance ToJSON Info

instance FromJSON Server
instance ToJSON Server

instance FromJSON Clients
instance ToJSON Clients

instance FromJSON Memory
instance ToJSON Memory

instance FromJSON Persistence
instance ToJSON Persistence

instance FromJSON AOF
instance ToJSON AOF

instance FromJSON Stats
instance ToJSON Stats

instance FromJSON Role
instance ToJSON Role

instance FromJSON CPU
instance ToJSON CPU

instance FromJSON Keyspace
instance ToJSON Keyspace

instance FromJSON Cluster
instance ToJSON Cluster
-}
