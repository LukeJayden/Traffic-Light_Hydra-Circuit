# Traffic-Light_Hydra-Circuit
A circuit simulates the function of a Traffic Light

About the file:
TrafficLight.hs is the code of the Circuit in Hydra Language which is a unique hardware description language.
TrafficLightRun.hs is the simulation driver without which you can not actually run the TrafficLight.hs code. 
StatusReport is the detail of the design and implementation of the TrafficLight.

How to run it?
You need to have both Hydra(functional hardware description language) and Sigma16(assembler and emulator)

Install Hydra:
Download the source file and put it in your workspace.You can unpack it:
Linux:  tar -xzf Hydra-1.2.9.tgz
Windows: use 7zip. If this gives a folder containing a tar file, you'll need to unpack that too. You need an actual folder named Hydra-i.j.k.
Visit the user manual in your browser; it's in index.html in the installation folder.
To install:
On Windows, open a Command prompt, or a cygwin shell, cd to the Hydra directory, and enter cabal install.
On Linux, enter the Hydra-*.*.* directory and enter make install.
The User Guide explains how to run a simulation.
Try the example circuits in the examples directory.

Install Sigma16:
Unzip the zip file it and launch by going into the directory and clicking Sigma16.exe (the file type is Application).  
It's convenient to right click it, create a shortcut, then cut the shortcut and paste it someplace convenient.
