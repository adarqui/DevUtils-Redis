{-# LANGUAGE OverloadedStrings, NamedFieldPuns #-}


{-
 - My method for parsing redis's info response is hideous.. need to clean this up eventually.
 -}


module System.DevUtils.Redis.Helpers.Info.Marshall (
 unMarshall'1,
 infoMap,
 infoMapTranslate
) where

import System.DevUtils.Redis.Types.ByteString
import System.DevUtils.Redis.Helpers.Info.Include
import System.DevUtils.Redis.Helpers.Info.Default (defaultInfo)
import System.DevUtils.Base.Data.Map (kvListToMap)
import System.DevUtils.Parser.KV.ByteString (runKV, defaultKV)

import qualified Data.ByteString as B
import qualified Data.Map as M

import Data.Maybe

unMarshall'1 :: B.ByteString -> Maybe Info
unMarshall'1 bs =
 case (runKV defaultKV bs) of
  (Left _) -> Nothing
  (Right kvlist) -> unMarshall'1' kvlist

unMarshall'1' :: [(B.ByteString, B.ByteString)] -> Maybe Info
unMarshall'1' kvlist = Just $ infoMapTranslate defaultInfo kvlist

{-
 - Ok this is going to get extremely ugly
 -}

infoMap :: M.Map B.ByteString (Info -> B.ByteString -> Info)
infoMap = M.fromList [
-- ("redis_version", \r v -> let z = s r in r { _server = z { _redisVersion = rString v }}),
 -- Server
 ("redis_version", \r v -> r { _server = (s r) { _redisVersion = rString v }}),
 ("redis_git_sha1", \r v -> r { _server = (s r) { _redisGitSha1 = rString v } } ),
 ("redis_git_dirty", \r v -> r { _server = (s r) { _redisGitDirty = rInt v } } ),
 ("redis_mode", \r v -> r { _server = (s r) { _redisMode = rString v } } ),
 ("os", \r v -> r { _server = (s r) { _os = rString v } } ),
 ("arch_bits", \r v -> r { _server = (s r) { _archBits = rInt v } } ),
 ("multiplexing_api", \r v -> r { _server = (s r) { _multiplexingApi = rMultiplexer v } } ),
 ("gcc_version", \r v -> r { _server = (s r) { _gccVersion = rString v } } ),
 ("process_id", \r v -> r { _server = (s r) { _processId = rInt v } } ),
 ("run_id", \r v -> r { _server = (s r) { _runId = rString v } } ),
 ("tcp_port", \r v -> r { _server = (s r) { _tcpPort = rInt v } } ),
 ("uptime_in_seconds", \r v -> r { _server = (s r) { _uptimeInSeconds = rInt v } } ),
 ("uptime_in_days", \r v -> r { _server = (s r) { _uptimeInDays = rInt v } } ),
 ("hz", \r v -> r { _server = (s r) { _hz = rInt v } } ),
 -- Clients
 ("connected_clients", \r v -> r { _clients = (c r) { _connectedClients = rInt v } } ),
 ("client_longest_output_list", \r v -> r { _clients = (c r) { _clientLongestOutputList = rInt v } } ),
 ("client_biggest_input_buf", \r v -> r { _clients = (c r) { _clientBiggestInputBuf = rInt v } } ),
 ("blocked_clients", \r v -> r { _clients = (c r) { _blockedClients = rInt v } } ),
 -- Memory
 ("used_memory", \r v -> r { _memory = (m r) { _usedMemory = rMem v } } ),
 ("used_memory_human", \r v -> r { _memory = (m r) { _usedMemoryHuman = rMemHuman v } } ),
 ("used_memory_rss", \r v -> r { _memory = (m r) { _usedMemoryRss = rMem v } } ),
 ("used_memory_peak", \r v -> r { _memory = (m r) { _usedMemoryPeak = rMem v } } ),
 ("used_memory_peak_human", \r v -> r { _memory = (m r) { _usedMemoryPeakHuman = rMemHuman v } } ),
 ("mem_fragmentation_ratio", \r v -> r { _memory = (m r) { _memFragmentationRatio = rDouble v } } ),
 ("mem_allocator", \r v -> r { _memory = (m r) { _memAllocator = rString v } } )
-- ("y", \r v -> r { _memory = (m r) { _x = rString v } } ),

 ]
 where
  s r = _server r
  c r = _clients r
  m r = _memory r
--  q r f v = let z = _server r in r { _server = z { f = v } }

changeField :: Info -> (B.ByteString,B.ByteString) -> Info
changeField info (k,v) = case (isJust cb) of
 True -> (fromJust cb) info v
 False -> info
 where
--  cb = infoMap M.! k
  cb = M.lookup k infoMap

infoMapTranslate :: Info -> [(B.ByteString, B.ByteString)] -> Info
infoMapTranslate info [] = info
infoMapTranslate info (x:xs) = infoMapTranslate (changeField info x) xs
