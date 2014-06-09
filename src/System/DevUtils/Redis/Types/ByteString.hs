{-# LANGUAGE OverloadedStrings #-}
module System.DevUtils.Redis.Types.ByteString (
 rBool,
 rString,
 rInteger,
 rInt,
 rFloat,
 rDouble,
 rMultiplexer,
 rMem,
 rMemHuman
) where

import qualified Data.ByteString.Char8 as B
import qualified System.DevUtils.Sys.Multiplex as Mplx
import qualified System.DevUtils.Sys.Memory as Mem

rBool :: B.ByteString -> Bool
rBool "0" = False
rBool "1" = True

rString :: B.ByteString -> String
rString s = B.unpack s

rInteger :: B.ByteString -> Integer
rInteger s = (read (B.unpack s) :: Integer)

rInt :: B.ByteString -> Integer
rInt = rInteger

rDouble :: B.ByteString -> Double
rDouble s = (read (B.unpack s) :: Double)

rFloat :: B.ByteString -> Double
rFloat = rDouble

-- FIXME
rMultiplexer :: B.ByteString -> Mplx.Multiplexer
rMultiplexer s = case s of
 "epoll" -> Mplx.EPOLL
 "select" -> Mplx.SELECT
 "kqueue" -> Mplx.KQUEUE
 "poll" -> Mplx.POLL
 _ -> Mplx.UNKNOWN

rMemHuman :: B.ByteString -> Mem.Memory Double
rMemHuman s = case (B.last s) of
 'K' -> Mem.K i
 'M' -> Mem.M i
 'G' -> Mem.G i
 'T' -> Mem.T i
 _ -> Mem.B i
 where
  i = read (B.unpack (B.init s)) :: Double

rMem :: B.ByteString -> Mem.Memory Integer
rMem s = case (B.last s) of
 'K' -> Mem.K i
 'M' -> Mem.M i
 'G' -> Mem.G i
 'T' -> Mem.T i
 _ -> Mem.B i
 where
  i = read (B.unpack s) :: Integer
