classdef stars
    %STARS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        starsPos
    end
    
    methods
        function this = stars(coresPos, coresInitVel, coresMass, tMax, numTimePoints , numStarsPerCore, radius)
            %STARS Construct an instance of this class
            %   Detailed explanation goes here
            this.starsPos = zeros(length(coresInitVel(:, 1))*numStarsPerCore ...
            , 3, numTimePoints);
        
            deltaT = tMax/(numTimePoints - 1);
            for coreNum = 1:length(coresInitVel(:, 1))
                for starNum = 1:numStarsPerCore
                    
                    starIdx = numStarsPerCore*(coreNum-1) + starNum;
                    
                    rad = 0.8*radius*rand + 0.2;
                    angle = 2*pi*rand;
                    x = rad*cos(angle);
                    y = rad*sin(angle);
                    this.starsPos(starIdx, 1, 1) = coresPos(coreNum, 1, 1) + x;
                    this.starsPos(starIdx, 2, 1) = coresPos(coreNum, 2, 1) + y;
                    
                    a = accelS(this.starsPos(starIdx, :, 1), coresPos(:, :, 1), coresMass);
                    
                    v = [0; sqrt(norm(a)*norm(coresPos(coreNum, :, 1) - this.starsPos(starIdx, :, 1))); 0];
                    rotMat = [cos(angle), -sin(angle), 0; sin(angle), cos(angle), 0; 0 , 0, 1];
                    v = (rotMat * v)' + coresInitVel(coreNum, :);
                    
                    this.starsPos(starIdx, :, 2) = this.starsPos(starIdx, :, 1) + deltaT * v + ((deltaT^2)/2)*a;
                end
            end

            
            
            for t = 3:numTimePoints
               for starIdx = 1:length(this.starsPos(:, 1, 1))
                  a = accelS(this.starsPos(starIdx, :, t - 1), coresPos(:, :, t - 1), coresMass);
                      this.starsPos(starIdx, :, t) = 2*this.starsPos(starIdx, :, t - 1) - this.starsPos(starIdx, :, t - 2)+ (deltaT^2)*a;
               end
            end
        end
        
    end
end

