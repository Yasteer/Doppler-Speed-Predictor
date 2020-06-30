% Yasteer Sewpersad Garmin Graduate Challenge 2020

%% Proposed Algorithm Description
%1. Read in audio file
%2. Split audio file into 3 sections corresponding to the position of the
%   car(before observer, inline with observer & past the observer). 
%3. Pass each section through a window to prevent spectral leakage issues.
%4. Perform a spectral analysis.
%5. Select frequencies of the car before and after the observer.
%6. Calculate speed of vehicle from the Doppler Effect.

%% Source Code
clear all
clc

% Read in audio and verify data is loaded:
[y,Fs] = audioread('challenge_2020.wav');

% Split audio sections:
filename = 'handel.flac';
audiowrite(filename,y,Fs);
sampleA = [4*Fs,7.6*Fs]; % Define section of original audio clip.
[A,Fs] = audioread(filename,sampleA);

filename = 'handel.flac';
audiowrite(filename,y,Fs);
sampleB = [7.6*Fs,7.9*Fs];
[B,Fs] = audioread(filename,sampleB);

filename = 'handel.flac';
audiowrite(filename,y,Fs);
sampleC = [7.9*Fs,10*Fs];
[C,Fs] = audioread(filename,sampleC);

figure(1)
subplot(4,1,1), plot(y), title('Original Signal'), subplot(4,1,2), plot(A), title('Vehicle Approaching Observer'), subplot(4,1,3), plot(B), title('Vehicle Near Observer'), subplot(4,1,4), plot(C), title('Vehicle Passing Observer');

% Fast Fourier Transform (FFT) to identify the frequency components of the signal:
FFT_Analysis = FrequencyAnalysis(A,C);
FFT_Analysis.computePSD();

FFT_Analysis.plotSpectrum() % Power Spectral Density 
[f1, f2] = FFT_Analysis.retrieveVehicleFrequencies();

% Evaluate Doppler Effect Equation:
newVehicle = Vehicle();
Vehicle_Speed = newVehicle.DopplerSpeed(f1, f2)

%% Assumptions
% I assumed that the noise created from the rolling resistance of the tyres 
% is neglible but this may not be the case. This is seen in the low frequency 
% components of the power spectral density figure. I suspect that some form
% of FIR filter may be required to eliminate this noise. 

% I also used the PSD as opposed to just using the FFT for identifying
% harmonics due to the random nature of the signal. Some sources say this
% may not be the best method, so a better pitch detection algorithm may be
% required.