Stuff
=====

General
--

```
import Database.Redis
r <- connect defaultConnectInfo
```

Info
--

```
import System.DevUtils.Redis.Helpers.Info.Run
info <- run'1 r

import System.DevUtils.Redis.Helpers.Info.Run
v <- info r
```

Command stats
--

```
import System.DevUtils.Redis.Helpers.CommandStats.Run
cs <- run'List r
```
