classdef Force < Units.Unit
    methods
        function obj = Force(scale,name)
            if nargin<1
                scale = 1;
            end
            obj@Units.Unit(scale,0,name);
        end
    end
end
