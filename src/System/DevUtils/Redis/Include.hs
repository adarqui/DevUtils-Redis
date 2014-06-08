module System.DevUtils.Redis.Include (
 Status(..),
 RoleType(..),
) where

data Status = OK deriving (Show)
data RoleType = MASTER | SLAVE deriving (Show)
