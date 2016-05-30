%% Import Data

% Copyright 2015 The MathWorks, Inc.


carData = importfile('\dataXLS\2007dat.xlsx');
carData.Car_Truck = categorical(carData.Car_Truck);
carData.City_Highway = categorical(carData.City_Highway);

%% Visualize
% Summary Stats
summary(carData(:,{'RatedHP','MPG'}))

% Use our custom figure
createfigure(carData.RatedHP,carData.MPG,12,carData.MPG)

%% 