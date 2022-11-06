classdef Unit
    properties (SetAccess = protected)
        name = ''
        scale = 1
        offset = 0
        type = ''
    end
    methods
        function obj = Unit(scale, offset, name)
            if nargin<3
                name = '';
            end
            if nargin<2
                offset = 0;
            end
            if nargin<1
                scale = 1;
            end
            obj.name = name;
            obj.scale = scale;
            obj.offset = offset;
            obj.type = class(obj);
        end
        function type = GetCompoundType(obj, nomult)
            narginchk(1,2)
            if nargin<2
                nomult = false;
            end
            % get the type and extract off everything before the last '.'
            % to remove 'Units.Category.'
            type = obj.type;
            idx = strfind(type, '.');
            if ~isempty(idx)
                idx = idx(end);
                type = type((idx+1):end);
            end
            if contains(type,'/') || contains(type,'^') || (~nomult && contains(type,'*'))
                type = [ '(' type ')' ];
            end
        end
        function obj = MultUnits(obj1, obj2)
            if obj1.offset==0 && obj2.offset==0
                obj = Units.Unit(obj1.scale*obj2.scale,0);
                type1 = GetCompoundType(obj1,true);
                type2 = GetCompoundType(obj2,true);
                obj.type = [ type1 '*' type2 ];
                if isempty(obj1.name)
                    if isempty(obj2.name)
                        obj.name = '';
                    else
                        obj.name = obj2.name;
                    end
                elseif isempty(obj2.name)
                    obj.name = obj1.name;
                else
                    obj.name = [ obj1.name '*' obj2.name ];
                end
            else
                error('Multiplied units must both have 0 offset')
            end
        end
        function obj = DivideUnits(obj1, obj2)
            if obj1.offset==0 && obj2.offset==0
                obj = Units.Unit(obj1.scale/obj2.scale,0);
                type1 = GetCompoundType(obj1,true);
                type2 = GetCompoundType(obj2);
                if strcmp(type1, type2)
                    obj.type = 'Unitless';
                else
                    obj.type = [ type1 '/' type2 ];
                end
                if isempty(obj1.name)
                    if isempty(obj2.name)
                        obj.name = '';
                    else
                        obj.name = [ '1/' obj2.name];
                    end
                elseif isempty(obj2.name)
                    obj.name = obj1.name;
                else
                    obj.name = [ obj1.name '/' obj2.name ];
                end
            else
                error('Divided units must both have 0 offset')
            end
        end
        function obj = mpower(obj1, p)
            if isa(obj1,'Units.Unit')
                if obj1.offset~=0
                    error('Power units must have 0 offset')
                end
                type1 = GetCompoundType(obj1);
                if p==2
                    obj = Units.Unit(obj1.scale.^2);
                    obj.type = [ type1 '^2' ];
                elseif p==0.5
                    obj = Units.Unit(sqrt(obj1.scale));
                    obj.type = [ type1 '^0.5' ];
                else
                    error('Power only valid for square or square root')
                end
                if isempty(obj1.name)
                    obj.name = '';
                else
                    obj.name = [ '(' obj.name ')^' num2str(p)];
                end
            else
                error('Power only valid for forming units')
            end
        end
        function r = mtimes(val, obj)
            if isa(val,'Units.Unit') && isa(obj,'Units.Unit')
                r = MultUnits(val, obj);
            elseif isa(obj,'Units.Unit')
                r = val * obj.scale + obj.offset;
            else
                r = obj * val.scale + val.offset;
            end
        end
        function r = mrdivide(val, obj)
            if isa(val,'Units.Unit') && isa(obj,'Units.Unit')
                r = DivideUnits(val, obj);
            elseif isa(obj,'Units.Unit')
                r = (val-obj.offset)/obj.scale;
            else
                r = (obj-val.offset)/val.scale;
            end
        end
    end
end