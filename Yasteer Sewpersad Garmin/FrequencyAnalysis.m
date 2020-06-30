classdef FrequencyAnalysis < handle
    % FrequencyAnalysis is responsible for determining which harmonics are
    % present in the audio signal and their power levels. 
    
    properties (Access = private) 
        Fs = 44100 % Default sampling rate. 
        sizeOfA
        sizeOfC
        freqA
        freqC
        
        SignalA
        SignalC
        
        FFT_A % Fast Fourier Transforms
        FFT_B
        FFT_C
        
        PSD_A % Power Spectral Densities
        PSD_B
        PSD_C
        
    end
    
    methods (Access = public)
        function obj = FrequencyAnalysis(ClipA, ClipC) % Constructor.
            ClipA = ClipA';
            %ClipA = ClipA.*hanning(length(ClipA))'; % Could not get
            %windowing method to work, but sources say that it will make
            %results more realistic. 
            ClipA = [ClipA zeros(1,11000)]; % Zero padding to make FFT evaluation more accurate. 

            ClipC = ClipC';
            %ClipC = ClipC.*hanning(length(ClipC))';
            ClipC = [ClipC zeros(1,11000)];
            
            obj.FFT_A = fft(ClipA);
            obj.FFT_A = obj.FFT_A(1:length(ClipA)/2+1);
            obj.sizeOfA = length(ClipA);
            
            obj.FFT_C = fft(ClipC);
            obj.FFT_C = obj.FFT_C(1:length(ClipC)/2+1);
            obj.sizeOfC = length(ClipC);
        end      
        
        function [FFT_A, FFT_C] = getFFT(obj) % Getter-function to retrieve Fast Fourier Transform results.
            FFT_A = obj.FFT_A;
            FFT_C = obj.FFT_C;
        end
              
        function [] = computePSD(obj)
            obj.PSD_A = (1/(obj.Fs*obj.sizeOfA)) * abs(obj.FFT_A).^2;  % Reference: https://www.mathworks.com/help/signal/ug/power-spectral-density-estimates-using-fft.html
            obj.PSD_A(2:end-1) = 2*obj.PSD_A(2:end-1);
            obj.freqA = 0:obj.Fs/obj.sizeOfA:obj.Fs/2;

            obj.PSD_C = (1/(obj.Fs*obj.sizeOfC)) * abs(obj.FFT_C).^2;
            obj.PSD_C(2:end-1) = 2*obj.PSD_C(2:end-1);
            obj.freqC = 0:obj.Fs/obj.sizeOfC:obj.Fs/2;
        end    
        
        function [estimatedFreqA, estimatedFreqC] = retrieveVehicleFrequencies(obj)
            [~, IndexA] = max(obj.PSD_A);
            [~, IndexC] = max(obj.PSD_C);
            
            estimatedFreqA = obj.freqA(IndexA);
            estimatedFreqC = obj.freqC(IndexC);
        end
        
        function [] = plotSpectrum(obj)
            figure(2)
            subplot(2,1,1), plot(obj.freqA, 10*log10(obj.PSD_A)), grid on, title('Periodogram Using FFT_A'), xlabel('Frequency (Hz)'), ylabel('Power/Frequency (dB/Hz)')
            subplot(2,1,2), plot(obj.freqC, 10*log10(obj.PSD_C)), grid on, title('Periodogram Using FFT_C'), xlabel('Frequency (Hz)'), ylabel('Power/Frequency (dB/Hz)')
        end
        
        
    end
end

