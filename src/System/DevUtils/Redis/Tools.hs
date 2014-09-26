module System.DevUtils.Redis.Tools (
 urlToConnectInfo
) where

import System.DevUtils.Base.Url.Redis
 (Redis(..))

import System.DevUtils.Base.Url.Session
 (Session(..))

import System.DevUtils.Base.Url.Auth
 (Auth(..))

import System.DevUtils.Base.Url.Connection
 (Connection(..), ConnectionType(..))

import Database.Redis
 (ConnectInfo(..), PortID(..))

import Data.Maybe
 (isNothing, fromJust, maybe)

import qualified Data.ByteString.Char8 as C

urlToConnectInfo :: Redis -> ConnectInfo
urlToConnectInfo url = ConnInfo {
  connectHost = tcp,
  connectPort = PortNumber 6379,
-- FIX
--  connectPort = port,
  connectAuth = auth
 }
 where
  db  = _db
  port = _port $ _con $ _ses url
  auth = case (_auth $ _ses url) of
   (Just v) ->  Just $ C.pack $ _user v
   _ -> Nothing
  (tcp,unix) = let (t,d) = (_type $ _con $ _ses url, _dest $ _con $ _ses url) in case t of
   UNIX -> ("", d)
   _ -> (d, "")
