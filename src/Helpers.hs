{-# LANGUAGE FlexibleInstances #-}

module Helpers where

import Data.Time.Clock.POSIX

-- get timestamp in seconds multiplied by factor
-- previously, Int was passed instead of POSIXTime, but cmpiler threw error
--  however using integer value in place of 'n' worked as compiler inferred that
--  value as POSIXTime
--  now again, Int is being passed and used fromIntegral below, because
--   fromIntegral converts to Num which poses no problem
-- getTimestampX :: POSIXTime -> IO Int
getTimestampX :: Int -> IO Int
getTimestampX n = fmap (round . (* fromIntegral n)) getPOSIXTime

-- get timestamp in milliseconds
getTimestampMilli :: IO Int
getTimestampMilli = getTimestampX 1000

-- get timestamp in microseconds
getTimestampMicro :: IO Int
getTimestampMicro = getTimestampX 1000000

-- concatenating/hashing for merkle tree
merkleHashChildren :: String -> String -> String
merkleHashChildren s1 s2 = merkleHash $ s1++s2

-- hashing data for merkle tree
merkleHash :: String -> String
merkleHash x = "#" ++ x ++ "#"

indexIn :: (Eq a) => a -> [a] -> Int
indexIn = find 0
    where find _ e [] = -1
          find n e ls | head ls == e = n
                      | otherwise =  find (n+1) e (tail ls)

-- Apply a function n times to a value and return list
applyFunctionNTimes :: (a -> a) -> a -> Int -> [a]
applyFunctionNTimes f val 0 = []
applyFunctionNTimes f val n = val : applyFunctionNTimes f (f val) (n-1)

-- Apply a function to a value until a condition is met
-- First Param: Function to be applied
-- Second Param: Value
-- Third Param: Applying condition
applyFunctionTillCondition :: (a-> a) -> a -> (a -> Bool) -> [a]
applyFunctionTillCondition f n cond
        | cond n = n : applyFunctionTillCondition f (f n) cond
        | otherwise = []

binTreeHeight :: Int -> Int
binTreeHeight len = 1 + ceiling (logBase 2 (fromIntegral len)) :: Int
