module System.DevUtils.Redis.Helpers.Info.Include (
 Info(..),
 Server(..),
 Clients(..),
 Memory(..),
 Persistence(..),
 AOF(..),
 Stats(..),
 Role(..),
 CPU(..),
 Keyspace(..),
 Cluster(..),
 CommandStat(..)
) where

import System.DevUtils.Redis.Include (RoleType(..), Status(..))

import System.DevUtils.Sys.Multiplex
import qualified System.DevUtils.Sys.Memory as Mem

data Info = Info {
 _server :: Server,
 _clients :: Clients,
 _memory :: Memory,
 _persistence :: Persistence,
 _role :: Role,
 _cpu :: CPU,
 _keyspace :: Keyspace,
 _cluster :: Cluster
} deriving (Show)

data Server = Server {
 _redisVersion :: String,
 _redisGitSha1 :: String,
 _redisGitDirty :: Integer,
 _os :: String,
 _archBits :: Integer,
 _multiplexingApi :: Multiplexer,
 _gccVersion :: String,
 _processId :: Integer,
 _runId :: String,
 _tcpPort :: Integer,
 _uptimeInSeconds :: Integer,
 _uptimeInDays :: Integer,
 _hz :: Integer
} deriving (Show)

data Clients = Clients {
 _connectedClients :: Integer,
 _clientLongestOutputList :: Integer,
 _clientBBiggestInputBuf :: Integer,
 _blockedClients :: Integer
} deriving (Show)

data Memory = Memory {
 _usedMemory :: Mem.Memory Integer,
 _usedMemoryHuman :: Mem.Memory Integer,
 _usedMemoryRss :: Mem.Memory Integer,
 _usedMemoryPeak :: Mem.Memory Integer,
 _usedMemoryPeakHuman :: Mem.Memory Integer,
 _memFragmentationRatio :: Float,
 _memAllocator :: String
} deriving (Show)

data Persistence = Persistence {
 _rdbChangesSinceLastSave :: Integer,
 _rdbBgSaveInProgress :: Bool,
 _rdbLastSaveTime :: String, -- fix
 _rdbLastBgSaveStatus :: Status,
 _rdbCurrentBgSaveTimeSec :: Maybe Integer,
 _aofEnabled :: Bool,
 _aofRewriteInProgress :: Bool,
 _aofLastRewriteTimeSec :: Maybe Integer,
 _aofCurrentRewriteTimeSec :: Maybe Integer,
 _aofLastBgrewriteStatus :: Status,
 _aof :: Maybe AOF
} deriving (Show)

{- Maybe aof -}
{-
 - aof_current_size: AOF current file size
 - aof_base_size: AOF file size on latest startup or rewrite
 - aof_pending_rewrite: Flag indicating an AOF rewrite operation will be scheduled once the on-going RDB save is complete.
 - aof_buffer_length: Size of the AOF buffer
 - aof_rewrite_buffer_length: Size of the AOF rewrite buffer
 - aof_pending_bio_fsync: Number of fsync pending jobs in background I/O queue
 - aof_delayed_fsync: Delayed fsync counter
 - -}
data AOF = AOF {
 _aofCurrentSize :: Integer,
 _aofBaseSize :: Integer,
 _aofPendingRewrite :: Bool,
 _aofBufferLength :: Integer,
 _aofRewriteBufferLength :: Integer,
 _aofPendingBioFsync :: Integer,
 _aofDelayedFsync :: Integer
} deriving (Show)

data Stats = Stats {
 _totalConnectionsReceived :: Integer,
 _totalCommandsProcessed :: Integer,
 _instantaneousOpsPerSec :: Integer,
 _rejectedConnections :: Integer,
 _expiredKeys :: Integer,
 _evictedKeys :: Integer,
 _keyspaceHits :: Integer,
 _keyspaceMisses :: Integer,
 _pubsubChannels :: Integer,
 _pubsubPatterns :: Integer,
 _latestForkUsec :: Integer
} deriving (Show)

data Role = Role {
 _roleType :: RoleType,
 _connectedSlaves :: Integer
} deriving (Show)

{-
 - If the instance is a slave, these additional fields are provided:
 - master_host: Host or IP address of the master
 - master_port: Master listening TCP port
 - master_link_status: Status of the link (up/down)
 - master_last_io_seconds_ago: Number of seconds since the last interaction with master
 - master_sync_in_progress: Indicate the master is SYNCing to the slave
 - If a SYNC operation is on-going, these additional fields are provided:
 - master_sync_left_bytes: Number of bytes left before SYNCing is complete
 - master_sync_last_io_seconds_ago: Number of seconds since last transfer I/O during a SYNC operation
 - If the link between master and slave is down, an additional field is provided:
 - master_link_down_since_seconds: Number of seconds since the link is down
 - The following field is always provided:
 - connected_slaves: Number of connected slaves
 - For each slave, the following line is added:
 - slaveXXX: id, ip address, port, state
 -}

data CPU = CPU {
 _usedCpuSys :: Float,
 _usedCpuUser :: Float,
 _usedCpuSysChildren :: Float,
 _usedCpuUserChildren :: Float
} deriving (Show)

data Keyspace = Keyspace {
 _databases :: [String]
} deriving (Show)

data Cluster = Cluster {
 _clusterEnabled :: Bool
} deriving (Show)

data CommandStat = CommandStat {
 _type :: String,
 _numCalls :: Integer,
 _totalCpu :: Float,
 _avgCpu :: Float
} deriving (Show)