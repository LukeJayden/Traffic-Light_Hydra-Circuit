module Main where
import HDL.Hydra.Core.Lib
import TrafficLight

main :: IO ()
main = do
  runTrafficLight test_data_1
  runCrossing test_data_2

runTrafficLight :: [[Int]] -> IO ()
runTrafficLight input = runAllInput input output
  where
-- Extract input signals from readable input
    reset = getbit input 0

-- Connect the circuit to its inputs and outputs
    (green, amber, red) = stateMachine1 reset

-- Format the signals for output
    output =
      [string "reset = ", bit reset,
       string "  green = ", bit green,
       string "  amber = ", bit amber,
       string "  red = ", bit red]

test_data_1 :: [[Int]]
test_data_1 =
  [[1], [0],  [0],  [0],  [0],  [0],  [0],  [0],  [0],  [0],  [0],
   [0], [0],  [0],  [0],  [1],  [0],  [0],  [0],  [0],  [1],  [0],
   [0], [0],  [0],  [0],  [0],  [0],  [0],  [0],  [0],  [0],  [0],
   [0], [0]]


runCrossing :: [[Int]] -> IO ()
runCrossing input = runAllInput input output2
  where
-- Extract input signals from readable input
    reset = getbit input 0
    walkRequest = getbit input 1

-- Connect the circuit to its inputs and outputs
    (green, amber, red, wait, walk, walkCount) = stateMachine2 reset walkRequest

-- Format the signals for output
    output2 =
      [string "Reset = ", bit reset,
       string "  walkRequest = ", bit walkRequest,
       string "  green = ", bit green,
       string "  amber = ", bit amber,
       string "  red = ", bit red,
       string "  wait = ", bit wait,
       string "  walk = ", bit walk]

test_data_2 :: [[Int]]
test_data_2 =
  [[1,0], [0,0], [0,0], [0,0], [0,0], [0,1], [0,0], [0,0],
   [0,0], [0,0], [0,0], [0,0], [0,1], [0,0], [0,0], [0,0],
   [0,0], [0,0], [0,0], [0,1], [0,0], [0,0], [0,0], [0,0],
   [0,0], [0,0], [0,1], [0,0], [0,0], [0,1], [0,0], [0,0], [0,0], [0,1]]
