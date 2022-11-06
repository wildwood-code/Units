classdef Capacitance < Units.Unit
    methods
        function obj = Capacitance(scale,name)
            if nargin<1
                scale = 1;
            end
            obj@Units.Unit(scale,0,name);
        end
    end
end
