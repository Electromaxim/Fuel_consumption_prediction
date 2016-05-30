%% Fuel Economy Analysis
% This demo is an example of performing data mining on historical fuel
% economy data. We have data from various cars built from year 2000 up to
% 2012.
%

% Copyright 2015 The MathWorks, Inc.


%% Import Data into Table
% Import from Excel using modified auto-generated function from Import Tool

carData = importYearXLS(2004);


%% Table Summary
% Display basic statistical summary

summary(carData(:,{'RatedHP','MPG', 'CO2'}))


%% Visualize
% Plot MPG versus Rated Horsepower

createMPGFigure(carData.RatedHP, carData.MPG);


%% Examine Grouping Effects of Categorical Data

% Convert Car-Truck and City-Highway to categoricals
carData.Car_Truck = categorical(carData.Car_Truck);
carData.City_Highway = categorical(carData.City_Highway);

% In order to extract all "cars":
carIDs = carData.Car_Truck == 'car';

% In order to extract "city" data for "trucks":
city_truckIDs = (carData.City_Highway == 'city' & carData.Car_Truck == 'truck');

% City versus Highway
cityIDs = carData.City_Highway == 'city';
highwayIDs = carData.City_Highway == 'highway';


%% Distributions
% Examine the distribution of MPG grouped by City or Highway

mpgDistribution(carData.MPG(cityIDs), carData.MPG(highwayIDs))



%% Grouped Visualizations
% Scatter plot by group.

figure
gscatter(carData.RatedHP, carData.MPG, ...
    {carData.Car_Truck, carData.City_Highway}, ...
    '', '.', 10, 'on', 'Rated Horsepower', 'MPG')


%%
% Look at additional data: Engine Compression and CO2.
%
% Then show a matrix of scatter plots by group

figure
gplotmatrix([carData.RatedHP, carData.Comp], [carData.MPG, carData.CO2], ...
    {carData.Car_Truck, carData.City_Highway}, ...
    '', '.', 10, 'on', '', {'Rated Horsepower', 'Compression'}, {'MPG', 'CO2'})


%%  Grouped Statistics
% Perform group statistics based on specified grouping variables.

varfun(@mean, carData,'InputVariables',{'RatedHP', 'MPG'},...
    'GroupingVariables',{'City_Highway', 'Car_Truck'})


%% Analysis of Variance (ANOVA)
% One way, 2-way, and n-way ANOVA are available.

anovan(carData.MPG, {carData.Car_Truck, carData.City_Highway}, ...
    'varnames', {'Veh. Type', 'MPG Type'}, ...
    'model', 'interaction');


%% Boxplots
% Boxplots are integral part of grouped statistics. It provides useful
% visualization for grouping effects.

figure
boxplot(carData.MPG, {carData.Car_Truck, carData.City_Highway}, 'notch','on')


%% Extract Data for Curve Fitting
% Create these variables for Curve Fitting App

RatedHPCity = carData.RatedHP(cityIDs);
MPGCity     = carData.MPG(cityIDs);

% Use the App to develop a curve fit.


%% Curve Fitting
%
% Equation:
%
%   MPG = b1 + b2 * 1/RatedHP
%
% We can solve this using the Curve Fitting Tool
%
%   cftool(carData.RatedHP, carData.MPG)
%
% The following is a modified version of the auto-generated m-file from
% |cftool|.

cf = createMPGFit(carData.RatedHP, carData.MPG);


%% Plot Data and Model
% The result from the Curve Fitting Toolbox has a |plot| method for
% displaying the result graphically. We can choose to display the
% prediction bounds for the fit.

figure
hh = plot(cf, 'r', carData.RatedHP, carData.MPG, 'predobs', 0.95);
hh(2).LineWidth = 2;
for ii = [3 4]
    hh(ii).LineStyle = '-';
    hh(ii).Color = [0 0.5 0];
end


%% Plot of Data and Model (for different groups)
% We will apply the similar modeling technique to the data for different
% combinations of groups (Car-Truck and City-Highway)

% Model different combinations
modelMPG(carData, 'car', 'city')
modelMPG(carData, 'car', 'highway')
modelMPG(carData, 'truck', 'city')
modelMPG(carData, 'truck', 'highway')

