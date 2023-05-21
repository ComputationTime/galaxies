classdef cores
    %CORES will hold the info about all the cores in the system and time
    %evolve them. Since the system is completely independent from the
    %stars, we don't need to care about them here. We will compute their
    %trajectory later based on the trajectory of the cores.
        % After the thisect is constructed, it will contain the position of
        % the cores at 
    
    properties
        coresPos
        coresMass
        tMax
        numTimePoints
        coresInitVel
    end
    
    methods
        function this = cores(coresInitPos, coresInitVel, coresMass, tMax, numTimePoints)
            %CORES Construct an instance of this class
            %   given all the cores and their positions, mass, and the 
            %   timeStep for the simulation, this class will immediately
            %   compute the cores time evolution, since they don't depend
            %   on the stars. All the units must be given in parsecs,
            %   solar masses and years since the program will do some unit
            %   conversion to speed up calculations.
            
            this.tMax = tMax;
            this.numTimePoints = numTimePoints;
            this.coresMass = coresMass;
            this.coresInitVel = coresInitVel;
            this.coresPos = timeEvolve(this, coresInitPos, coresMass, tMax, numTimePoints);
        end
        
        function cP = timeEvolve(this, coresInitPos, coresMass, tMax, numTimePoints)
            % timeEvolve
            %   This method will evolve the system in time and return an
            %   array with the position of all cores at all points in time
            
            cP = zeros(length(coresInitPos(:, 1)), 3, numTimePoints);
            
            % calculate deltaT and change it to units that make G = 1
            deltaT = tMax / (numTimePoints - 1);
            
            
            %set init condits in evolvedPosArray to be same as the given
            %array of init conditions. Remember to use special units that
            %satisfy 1 length = 5000 pc, mass of first star in parsecs = 1
            %mass, G = 1.
            
            for i = 1:length(coresInitPos(:, 1)) 
                cP(i, :, 1) = coresInitPos(i, :);
            end
            
            %use second order taylor to find next points
            for i = 1:length(coresInitPos(:, 1))
               a0 = accel(this, i, cP, coresMass, 1);
                  cP(i, :, 2) = cP(i, :, 1) + deltaT*this.coresInitVel(i, :) + ((deltaT^2)/2)*a0;
            end
            
            % use FDA to finish calculating the whole path for all cores.
            for n = 3:numTimePoints
                for i = 1:length(coresInitPos(:, 1))
                    a = accel(this, i, cP, coresMass, n - 1);
                    cP(i, :, n) = 2*cP(i, :, n - 1) - cP(i, :, n - 2)+ (deltaT^2)*a;
                end
            end
            
            
        end
        
        function a = accel(this, index, coresPos, coresMass, time) 
           a = zeros(1, 3);
           for j = 1:length(coresPos(:, 1, 1))
               if (j == index)
                   continue
               end
               a = a + (coresPos(j, : , time) - coresPos(index, :, time))*coresMass(j) / ((norm(coresPos(j, :, time) -coresPos(index, :, time))^3));
           end
        end
        
        
        
    end
end

