module Main where

import Block
import Helpers
import MerkleTree

blocktest :: IO ()
blocktest = do
    blk <- getGenesisBlock
    putStrLn "Genesis Block: "
    putStrLn  $ show blk
    tstamp <- getTimestampMilli
    block <- generateNewBlock blk "New block 1"
    putStrLn "First Block: "
    putStrLn $ show block
    putStr "Validity of block 1: "
    isvalid <- isValidBlock block blk
    putStrLn $ show isvalid

merkletest :: IO ()
merkletest = do
    print $ constructMTree ["b","i"]


main = merkletest
