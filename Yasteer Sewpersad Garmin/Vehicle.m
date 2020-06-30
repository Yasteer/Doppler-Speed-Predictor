classdef Vehicle
    %This class is responsible for calculating the speed of the car. 
    
    properties (Access = private)
        Vs
        ambientTemperature
        maxSpeed
        minSpeed
    end
    
    methods (Access = public)
        function obj = Vehicle() % Constructer of this class
            obj.Vs = 343; % Speed of sound.
            obj.ambientTemperature = 20;
            obj.maxSpeed = 300; % Assume race car / F1 car. 
            obj.minSpeed = 0;
        end
            
        function [Speed] = DopplerSpeed(obj,freq1, freq2)
           Speed = obj.Vs*(freq1-freq2)/(freq1+freq2);
           Speed = Speed * 3.6; % Convert m/s to km/h
     
           if (Speed >= obj.maxSpeed || Speed < obj.minSpeed)
               Speed = 0;
               disp 'Error encountered in calculating the speed.'
           end
        end
        
        
       
    end
end

