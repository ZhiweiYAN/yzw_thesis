%%
clf; %clear figures
clc; %clear command windows history;
clear all;

%% 
currentFolder = 'E:\yzw_thesis\body';
main_dir_name = strcat(currentFolder,'\bayesian_figures\');
if(1~=isdir(main_dir_name))
    mkdir(main_dir_name);
end

file_name = 'bayesian_uniform_user_number_vs_contribute_probability';

%% avariable 
N = 2:2:16; %user number
N = N.';
b = 1;  %benefit if contribution
tau = 0.5; %punishment parameter

c = zeros(length(N),1);   %cost of the contribution

%%
%% 
for k=1:length(N)
    eqn_str = sprintf('x = %3.2g - %3.2g + (1-x)^%d * %3.2g',...
        b, tau, N(k), tau);
    syms x;   
    s = double(solve(eqn_str, 'Real', true));
    index = find( s<=1 & s>=0, 1, 'first');
    c(k) = s(index);
end

%%
mu = 0.5;
delta = 0.2;
X = normrnd(mu,delta, 1000,1);
x = sort(X, 'ascend');
y = normcdf(x,mu,delta);

%%
%% the number of players and cost
x = N;
y = c;
A = [x,y]

%% Plot the figure
plot(x,y, 'k',... 
    x,y, 'ko', 'LineWidth',1, 'MarkerSize',6, 'MarkerFace', 'k');
axis([min(x) max(x) 0.4 0.6]);
xlabel('Number of players');
ylabel('Cost');
grid on;
figure(1);

h1 = figure(1);
% print(h1,'-dtiff','-r600',strcat(main_dir_name,file_name,'.tif'));
print(h1,'-deps',strcat(main_dir_name,file_name,'.eps'));
% print(h1,'-dpdf',strcat(main_dir_name,file_name,'.pdf'));
% saveTightFigure(h1, strcat(main_dir_name,file_name,'_tight','.pdf'));
