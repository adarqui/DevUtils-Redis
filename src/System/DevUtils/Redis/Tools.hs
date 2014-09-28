module System.DevUtils.Redis.Tools (
 urlToConnectInfo
) where

import System.DevUtils.Base

import qualified System.DevUtils.Base.Url.Redis as R
 (Redis(..))

import Database.Redis
 (ConnectInfo(..), PortID(..))

import Data.Maybe
 (isNothing, fromJust, maybe)

import qualified Data.ByteString.Char8 as C

urlToConnectInfo :: R.Redis -> ConnectInfo
urlToConnectInfo url = ConnInfo {
  connectHost = tcp,
  connectPort = portFromWord port,
  connectAuth = auth,
-- FIX
  connectMaxConnections = 1,
  connectMaxIdleTime = 30.0,
  connectDatabase = db
 }
 where
  db  = R._db url
  port = _port $ _con $ R._ses url
  auth = case (_auth $ R._ses url) of
   (Just v) ->  Just $ C.pack $ _user v
   _ -> Nothing
  (tcp,unix) = let (t,d) = (_type $ _con $ R._ses url, _dest $ _con $ R._ses url) in case t of
   UNIX -> ("", d)
   _ -> (d, "")
