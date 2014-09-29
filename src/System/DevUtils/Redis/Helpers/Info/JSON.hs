{-# LANGUAGE FlexibleInstances, RecordWildCards #-}
module System.DevUtils.Redis.Helpers.Info.JSON (
 Info(..),
 keyspaces'toJSON
) where

import System.DevUtils.Redis.Helpers.Info.Include
import System.DevUtils.Redis.JSON

import qualified Data.ByteString as B
import qualified Data.Text as T
import Data.Aeson

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

instance FromJSON Keyspaces
instance ToJSON Keyspaces

instance FromJSON Keyspace
instance ToJSON Keyspace

instance FromJSON Cluster
instance ToJSON Cluster

keyspaces'toJSON :: [Keyspace] -> Value
keyspaces'toJSON cs = object $ map (\v -> (T.pack (show (_db v)), keyspace'to'Value v)) cs

keyspace'to'Value Keyspace{..} =
 object
  [
   ("_db", toJSON _db),
   ("_keys", toJSON _keys),
   ("_expires", toJSON _expires),
   ("_avgTtl", toJSON _avgTtl)
  ]
