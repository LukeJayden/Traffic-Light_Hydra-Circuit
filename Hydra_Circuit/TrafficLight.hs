module TrafficLight where
import HDL.Hydra.Core.Lib
import HDL.Hydra.Circuits.Combinational
import HDL.Hydra.Circuits.Register

{- Version 1 circuit:
The state machine runs fixed sequence:
green --> green --> green --> amber --> red --> red --> red --> red --> amber
and then it repeats -}

-- As suggested there are one input signal and three output signals
-- We also use some sub-signals such as phase1, delay2 to represent that the circuit is on a certain step during the whole circle and the light will keep shining for a few seconds.
-- This approach is much easiser and more intuitive to write the code

stateMachine1 reset = (green, amber, red)
  where
    phase1 = dff (or2 reset phase4)
    delay1 = dff (and2 reset' phase1)
    delay2 = dff (and2 reset' delay1)
    phase2 = dff (and2 reset' delay2)
    phase3 = dff (and2 reset' phase2)
    delay3 = dff (and2 reset' phase3)
    delay4 = dff (and2 reset' delay3)
    delay5 = dff (and2 reset' delay4)
    phase4 = dff (and2 reset' delay5)
    reset' = inv reset

    green = orw[phase1, delay1, delay2]
    amber = orw[phase2, phase4]
    red = orw[phase3, delay3, delay4, delay5]

{- Version 2 circuit:
The TrafficLight runs fixed sequence:
green --> amber --> red --> amber --> green
The PedestrianLight runs fixed sequence:
wait --> walk --> wait
and then it repeats -}

-- As suggested there are two input signals and six output signals
-- We also use some sub-signals such as TrafficPhase1, delay2 to represent that the circuit is on a certain step during the whole circle and the light will keep shining for a few seconds.
-- This approach is much easiser and more intuitive to write the code

stateMachine2 reset walkRequest = (green, amber, red, wait, walk, walkCount)
  where
    trafficPhase1 = dff (or3 reset trafficPhase4 (and2 trafficPhase1 walkRequest'))

    --make sure that only during the TrafficPhase1(green) is on can walkRequest turn it amber, and then red.
    --make sure that once the walkRequest button is pushed, pushing it more times during the trafficPhas3(red), trafficPhase4(amber) will not have any effects
    --since it is poiontless to push walkRequest button so many times
    --so we set the state transitions from trafficPhase3 to trafficPhase4 so that they will not be disturbed by pushing walkRequest button again

    trafficPhase2 = dff (and2 walkRequest trafficPhase1)
    trafficPhase3 = dff (trafficPhase2)
    delay1 = dff (trafficPhase3)
    delay2 = dff (delay1)
    trafficPhase4 = dff (delay2)

    green = trafficPhase1
    amber = orw[trafficPhase2, trafficPhase4]
    red = orw[trafficPhase3, delay1, delay2]
    wait = orw[green, amber]
    walk = red
    
    walkRequest' = inv walkRequest
    reset' = inv reset
    
    numZero = fanout 16 zero
    numOne = boolword 16 one
    (carryOut, walkCountAddOne) = rippleAdd zero(bitslice2 walkCount numOne)
    walkCountLd = mux2w (walkRequest, reset) walkCount numZero walkCountAddOne numZero
    walkCount = latch 16 walkCountLd