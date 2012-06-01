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
file_name = 'bayesian_normal_punish_parameter_vs_contribute_probability';

%% avariable 
N = 4; %user number
b = 1;  %benefit if contribution
tau = 0.1:0.1:0.9; %punishment parameter
tau = tau.'

c = zeros(length(tau),1);   %cost of the contribution

%%
%%
mu = 0.5;
delta = 0.2;
X = normrnd(mu,delta, 1000,1);
x = sort(X, 'ascend');
y = normcdf(x,mu,delta);

%% 
for k=1:length(tau)
    y1 = b -tau(k) + ( (1 - y).^(N-1) )*tau(k);
    diff = abs(y1 -x);
    minimum = min(diff);
    index = find(minimum==diff, 1, 'first');
    c(k) = x(index);
end
%%
%% the punishment parameter and cost
A = c';

%%
mu = 0.5;
delta = 0.1;
X = normrnd(mu,delta, 1000,1);
x = sort(X, 'ascend');
y = normcdf(x,mu,delta);

%% 
for k=1:length(tau)
    y1 = b -tau(k) + ( (1 - y).^(N-1) )*tau(k);
    diff = abs(y1 -x);
    minimum = min(diff);
    index = find(minimum==diff, 1, 'first');
    c(k) = x(index);
end
%%
%% the punishment parameter and cost
A = [A;c'];

%%
mu = 0.5;
delta = 0.05;
X = normrnd(mu,delta, 1000,1);
x = sort(X, 'ascend');
y = normcdf(x,mu,delta);

%% 
for k=1:length(tau)
    y1 = b -tau(k) + ( (1 - y).^(N-1) )*tau(k);
    diff = abs(y1 -x);
    minimum = min(diff);
    index = find(minimum==diff, 1, 'first');
    c(k) = x(index);
end
%%
%% the punishment parameter and cost
A = [A;c'];

%% Plot the figure
x = tau;
plot(x,A(1,:), '-ko',...
    x,A(2,:), '-ks', ...
    x,A(3,:), '-kv', 'LineWidth',1, 'MarkerSize',6, 'MarkerFace', 'b'...
    );
% axis([min(x) max(x) 0.4 0.6]);
xlabel('Number of players');
xlabel('Punishment parameter');
ylabel('Cost');
grid on;
legend('\mu=0.5, \delta=0.2', '\mu=0.5, \delta=0.1', '\mu=0.5, \delta=0.05');
figure(1);

h1 = figure(1);
% print(h1,'-dtiff','-r600',strcat(main_dir_name,file_name,'.tif'));
print(h1,'-deps',strcat(main_dir_name,file_name,'.eps'));
% print(h1,'-dpdf',strcat(main_dir_name,file_name,'.pdf'));
% saveTightFigure(h1, strcat(main_dir_name,file_name,'_tight','.pdf'));
