% Units Definitions
%
% Author: Kerry S. Martin, martin@wild-wood.net
%
% This toolbox is freely distributable. Please email me if you find it
% useful as I would like to hear from you.
%
% Invoking units simply adds the directory for that category of units to the
% current path.
%
% Units categories:
%   Time        - Invokes units of time (seconds, Hz, etc)
%   Electrical  - Invokes units of electricity (Volt, kOhm, etc)
%   Mechanical  - Invokes units of mechanics (meter, kg, etc)
%   Temperature - Invokes units of temperature (Kelvin, degC, etc)
%   General     - Invokes general units (percent, ppm, etc)
%
% Importing units:
%   Use the import command to import units. For example:
%     import Units.Electrical.* Units.Time.*
%   Importing Units.Unit.* is optional
%
% Unit conversions:
%   In general, a unit is converted to the base unit of that unit type by
%   multiplying the value by the unit. For instance:
%     10*kOhm
%   creates a value of 10000 Ohm (Ohm is the base class of resistance)
%   Dividing a value by the unit converts the base class value to that
%   unit. For example:
%     (300*Kelvin)/degF
%     300/degF
%   Both of these convert the base class (Kelvin for temperature) to
%   degrees Fahrenheit. The scaling and offset are used in this conversion.
%   Compound units may be defined, but there is no automatic conversion to
%   an equivalent unit, though the scaling will still provide the correct
%   result for the base unit. For instance:
%     Volt/mA will result in a unit of type 'Voltage/Current' with a
%     scaling of 1000. This will not be recognized as equivalent to kOhm
%     ('Resistance' with a scaling of 1000), but when used and converted to
%     kOhm, it will result in the correct value.
%     10*(Volt/mA) => 10000
%     10000/kOhm   => 10
%  Compound units cannot involve units with offsets (for example degF or
%  degC), however the base unit (Kelvin) can be used in a compound unit:
%     ppm/Kelvin
%  Compound units may also be squared or square-rooted:
%     kg*meter/(second^2)  => 'Mass*Length/(Time^2)'
%     Volt/(Hz^0.5)        => 'Voltage/(Frequency^0.5)'