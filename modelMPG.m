function cf = modelMPG(carData, CarTruck, CityHighway, CI)
% modelMPG(carData, CARTRUCK, CITYHIGHWAY, CI)
%
%   carData      : car data (table object)
%   CARTRUCK     : 'car' or 'truck' or 'all'
%   CITYHIGHWAY  : 'city' or 'highway' or 'all'
%   CI (optional): Confidence Interval (default: 95)

% Copyright 2015 The MathWorks, Inc.

if nargin == 3 % CI not provided
    CI = 95;
end


%% Filter out data
if strcmpi(CarTruck, 'all')
    idx1 = true(size(carData.MPG));
else
    idx1 = carData.Car_Truck == CarTruck;
end
if strcmpi(CityHighway, 'all')
    idx2 = true(size(carData.MPG));
else
    idx2 = carData.City_Highway == CityHighway;
end
idx = idx1 & idx2;
iData = carData.RatedHP(idx);
dData = carData.MPG(idx);


%% Curve Fitting
%
% Equation:
%    MPG = b1 + b2 * 1/RatedHP

cf = createMPGFit(iData, dData);


%% Plot
hh = plot(cf, 'r', iData, dData, 'predobs', CI*0.01);
hh(2).LineWidth = 2;
for ii = [3 4]
    hh(ii).LineStyle = '-';
    hh(ii).Color = [0 0.5 0];
end
xlabel('Rated Horsepower')
ylabel('MPG')
title([CarTruck ' - ' CityHighway]);

end