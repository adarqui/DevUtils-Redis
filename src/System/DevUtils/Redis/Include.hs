{-# LANGUAGE DeriveGeneric #-}

module System.DevUtils.Redis.Include (
 Status(..),
 RoleType(..),
) where

import GHC.Generics

data Status = OK deriving (Show, Read, Generic)
data RoleType = MASTER | SLAVE deriving (Show, Read, Generic)
