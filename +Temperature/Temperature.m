classdef Temperature < Units.Unit
    methods
        function obj = Temperature(scale, offset,name)
            if nargin<2
                offset = 0;
            end
            if nargin<1
                scale = 1;
            end
            obj@Units.Unit(scale,offset,name);
        end
    end
end
