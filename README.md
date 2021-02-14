# Doppler-Speed-Predictor
## Introduction
Program to predict car speed from audio file. Frequency analysis is performed on the audio file to determine the detected frequency when the car is approaching and when the car has passed. This information can then be fed into the Doppler equation to determine the speed of the car during the pass by using the ratio of the incoming and outgoing frequencies. 

## Audio Samples
### Original Audio
<img src="Images/Audio_Sample.PNG" width = 400> 

### Peak Frequency -> Oncoming
<img src="Images/Oncoming.PNG" width = 400>
Peak frequency approximately 365Hz.

### Peak Frequency -> Outgoing
<img src="Images/Outgoing.PNG" width = 400>
Peak frequency approximately 328Hz.

## Doppler Equation
<img src="Images/Doppler_Equation.PNG" width = 400>

* Vs = 343 m/s
* fin = 365 Hz
* fout = 328 Hz
