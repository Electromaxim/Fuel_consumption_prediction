function mpgDistribution(arg_1,arg_2)
%MPGDISTRIBUTION    Create plot of datasets and fits
%   MPGDISTRIBUTION(ARG_1,ARG_2)
%   Creates a plot, similar to the plot in the main distribution fitting
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with dfittool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  2
%   Number of fits:  2

% This function was automatically generated on 20-Mar-2009 17:59:43
 
% Copyright 2015 The MathWorks, Inc.

% Data from table "City":
%    Y = arg_1 (originally data.MPG(cityID))
 
% Data from table "Highway":
%    Y = arg_2 (originally data.MPG(highwayID))
 
% Force all inputs to be column vectors
arg_1 = arg_1(:);
arg_2 = arg_2(:);

% Set up figure to receive datasets and fits
f_ = clf;
figure(f_);
%set(f_,'Units','Pixels','Position',[599 521 648 375.45]);
legh_ = []; legt_ = {};   % handles and text for legend
ax_ = newplot;
set(ax_,'Box','on');
hold on;

% --- Plot data originally in dataset "City"
t_ = ~isnan(arg_1);
Data_ = arg_1(t_);
[F_,X_] = ecdf(Data_,'Function','cdf'...
              );  % compute empirical cdf
Bin_.rule = 3;
Bin_.nbins = 100;
[C_,E_] = dfswitchyard('dfhistbins',Data_,[],[],Bin_,F_,X_);
[N_,C_] = ecdfhist(F_,X_,'edges',E_); % empirical pdf from cdf
h_ = bar(C_,N_,'hist');
set(h_,'FaceColor','none','EdgeColor',[0.333333 0 0.666667],...
       'LineStyle','-', 'LineWidth',1);
xlabel('Data');
ylabel('Density')
legh_(end+1) = h_;
legt_{end+1} = 'City';
% --- Plot data originally in dataset "Highway"
t_ = ~isnan(arg_2);
Data_ = arg_2(t_);
[F_,X_] = ecdf(Data_,'Function','cdf'...
              );  % compute empirical cdf
Bin_.rule = 3;
Bin_.nbins = 100;
[C_,E_] = dfswitchyard('dfhistbins',Data_,[],[],Bin_,F_,X_);
[N_,C_] = ecdfhist(F_,X_,'edges',E_); % empirical pdf from cdf
h_ = bar(C_,N_,'hist');
set(h_,'FaceColor','none','EdgeColor',[0.333333 0.666667 0],...
       'LineStyle','-', 'LineWidth',1);
xlabel('Data');
ylabel('Density')
legh_(end+1) = h_;
legt_{end+1} = 'Highway';

% Nudge axis limits beyond data limits
xlim_ = get(ax_,'XLim');
if all(isfinite(xlim_))
   xlim_ = xlim_ + [-1 1] * 0.01 * diff(xlim_);
   set(ax_,'XLim',xlim_)
end

x_ = linspace(xlim_(1),xlim_(2),100);

% --- Create fit "City Fit"

% Fit this distribution to get parameter values
t_ = ~isnan(arg_1);
Data_ = arg_1(t_);
% To use parameter estimates from the original fit:
%     p_ = [ 21.29888623707, 5.954865967833];
pargs_ = cell(1,2);
[pargs_{:}] = normfit(Data_, 0.05);
p_ = [pargs_{:}];
y_ = normpdf(x_,p_(1), p_(2));
h_ = plot(x_,y_,'Color',[1 0 0],...
          'LineStyle','-', 'LineWidth',2,...
          'Marker','none', 'MarkerSize',6);
legh_(end+1) = h_;
legt_{end+1} = 'City Fit';

% --- Create fit "Highway Fit"

% Fit this distribution to get parameter values
t_ = ~isnan(arg_2);
Data_ = arg_2(t_);
% To use parameter estimates from the original fit:
%     p_ = [ 32.54445337621, 7.589867686265];
pargs_ = cell(1,2);
[pargs_{:}] = normfit(Data_, 0.05);
p_ = [pargs_{:}];
y_ = normpdf(x_,p_(1), p_(2));
h_ = plot(x_,y_,'Color',[0 0 1],...
          'LineStyle','-', 'LineWidth',2,...
          'Marker','none', 'MarkerSize',6);
legh_(end+1) = h_;
legt_{end+1} = 'Highway Fit';

hold off
leginfo_ = {'Orientation', 'vertical', 'Location', 'NorthEast'}; 
h_ = legend(ax_,legh_,legt_,leginfo_{:});  % create legend
set(h_,'Interpreter','none')
