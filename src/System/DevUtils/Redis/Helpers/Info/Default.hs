module System.DevUtils.Redis.Helpers.Info.Default (
 defaultInfo,
 defaultInfoServer,
 defaultInfoClients,
 defaultInfoMemory,
 defaultInfoPersistence,
 defaultInfoAOF,
 defaultInfoStats,
 defaultInfoRole,
 defaultInfoCPU,
 defaultInfoKeyspace,
 defaultInfoCluster
) where

import System.DevUtils.Redis.Include (RoleType(..), Status(..))
import System.DevUtils.Redis.Helpers.Info.Include

import qualified System.DevUtils.Sys.Multiplex as Mplx
import qualified System.DevUtils.Sys.Memory as Mem
import Data.Maybe (Maybe(..))

defaultInfo :: Info
defaultInfo = Info {
 _server = defaultInfoServer,
 _clients = defaultInfoClients,
 _memory = defaultInfoMemory,
 _persistence = defaultInfoPersistence,
 _stats = defaultInfoStats,
 _role = defaultInfoRole,
 _cpu = defaultInfoCPU,
 _keyspace = defaultInfoKeyspace,
 _cluster = defaultInfoCluster
}

defaultInfoServer :: Server
defaultInfoServer = Server {
 _redisVersion = "",
 _redisGitSha1 = "",
 _redisGitDirty = 0,
 _redisMode = "",
 _os = "",
 _archBits = 0,
 _multiplexingApi = Mplx.UNKNOWN,
 _gccVersion = "",
 _processId = 0,
 _runId = "",
 _tcpPort = 0,
 _uptimeInSeconds = 0,
 _uptimeInDays = 0,
 _hz = 0
}

defaultInfoClients :: Clients
defaultInfoClients = Clients {
 _connectedClients = 0,
 _clientLongestOutputList = 0,
 _clientBiggestInputBuf = 0,
 _blockedClients = 0
}

defaultInfoMemory :: Memory
defaultInfoMemory = Memory {
 _usedMemory = Mem.B 0,
 _usedMemoryHuman = Mem.B 0.0,
 _usedMemoryRss = Mem.B 0,
 _usedMemoryPeak = Mem.B 0,
 _usedMemoryPeakHuman = Mem.B 0.0,
 _memFragmentationRatio = 0.0,
 _memAllocator = ""
}

defaultInfoPersistence :: Persistence
defaultInfoPersistence = Persistence {
 _rdbChangesSinceLastSave = 0,
 _rdbBgSaveInProgress = False,
 _rdbLastSaveTime = "",
 _rdbLastBgSaveStatus = OK,
 _rdbCurrentBgSaveTimeSec = Nothing,
 _aofEnabled = False,
 _aofRewriteInProgress = False,
 _aofLastRewriteTimeSec = Nothing,
 _aofCurrentRewriteTimeSec = Nothing,
 _aofLastBgrewriteStatus = OK,
 _aof = Nothing
}

defaultInfoStats :: Stats
defaultInfoStats = Stats {
 _totalConnectionsReceived = 0,
 _totalCommandsProcessed = 0,
 _instantaneousOpsPerSec = 0,
 _rejectedConnections = 0,
 _expiredKeys = 0,
 _evictedKeys = 0,
 _keyspaceHits = 0,
 _keyspaceMisses = 0,
 _pubsubChannels = 0,
 _pubsubPatterns = 0,
 _latestForkUsec = 0
}

{- Nothing aof -}
{-
 - aof_current_size: AOF current file size
 - aof_base_size: AOF file size on latest startup or rewrite
 - aof_pending_rewrite: Flag indicating an AOF rewrite operation will be scheduled once the on-going RDB save is complete.
 - aof_buffer_length: Size of the AOF buffer
 - aof_rewrite_buffer_length: Size of the AOF rewrite buffer
 - aof_pending_bio_fsync: Number of fsync pending jobs in background I/O queue
 - aof_delayed_fsync: Delayed fsync counter
 - -}

defaultInfoAOF :: AOF
defaultInfoAOF = AOF {
 _aofCurrentSize = 0,
 _aofBaseSize = 0,
 _aofPendingRewrite = False,
 _aofBufferLength = 0,
 _aofRewriteBufferLength = 0,
 _aofPendingBioFsync = 0,
 _aofDelayedFsync = 0
}

defaultInfoRole :: Role
defaultInfoRole = Role {
 _roleType = MASTER,
 _connectedSlaves = 0
}

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

defaultInfoCPU :: CPU
defaultInfoCPU = CPU {
 _usedCpuSys = 0.0,
 _usedCpuUser = 0.0,
 _usedCpuSysChildren = 0.0,
 _usedCpuUserChildren = 0.0
}

defaultInfoKeyspace :: Keyspace
defaultInfoKeyspace = Keyspace {
 _databases = []
}

defaultInfoCluster :: Cluster
defaultInfoCluster = Cluster {
 _clusterEnabled = False
}
