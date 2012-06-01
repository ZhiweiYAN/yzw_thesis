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

%% avariable 
N = 2:2:16; %user number
N = N.';
b = 1;  %benefit if contribution
tau = 0.5; %punishment parameter

c = zeros(length(N),1);   %cost of the contribution

%%
mu = 0.5;
delta = 0.2;
X = normrnd(mu,delta, 1000,1);
x = sort(X, 'ascend');
y = normcdf(x,mu,delta);

%% 
for k=1:length(N)
    y1 = b -tau + ( (1 - y).^(N(k)-1) )*tau;
    diff = abs(y1 -x);
    minimum = min(diff);
    index = find(minimum==diff, 1, 'first');
    c(k) = x(index);
end
%%
%% the number of players and cost
x = N;
A = c';

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
mu = 0.5;
delta = 0.1;
X = normrnd(mu,delta, 1000,1);
x = sort(X, 'ascend');
y = normcdf(x,mu,delta);

%% 
for k=1:length(N)
    y1 = b -tau + ( (1 - y).^(N(k)-1) )*tau;
    diff = abs(y1 -x);
    minimum = min(diff);
    index = find(minimum==diff, 1, 'first');
    c(k) = x(index);
end
%%
%% the number of players and cost
x = N;
A = [A;c'];

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
mu = 0.5;
delta = 0.01;
X = normrnd(mu,delta, 1000,1);
x = sort(X, 'ascend');
y = normcdf(x,mu,delta);

%% 
for k=1:length(N)
    y1 = b -tau + ( (1 - y).^(N(k)-1) )*tau;
    diff = abs(y1 -x);
    minimum = min(diff);
    index = find(minimum==diff, 1, 'first');
    c(k) = x(index);
end
%%
%% the number of players and cost
x = N;
A = [A;c'];

%% Plot the figure
plot(x,A(1,:), '-ko',...
    x,A(2,:), '-ks', ...
    x,A(3,:), '-kv', 'LineWidth',1, 'MarkerSize',6, 'MarkerFace', 'b'...
    );
% axis([min(x) max(x) 0.4 0.6]);
xlabel('Number of players');
ylabel('Cost');
grid on;
figure(1);
hold on;

axis([min(x) max(x) 0.4 0.7]);
legend('\mu=0.5, \delta=0.2', '\mu=0.5, \delta=0.1', '\mu=0.5, \delta=0.05');
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


h1 = figure(1);

file_name = 'bayesian_normal_user_number_vs_contribute_probability';
% print(h1,'-dtiff','-r600',strcat(main_dir_name,file_name,'.tif'));
print(h1,'-deps',strcat(main_dir_name,file_name,'.eps'));
% print(h1,'-dpdf',strcat(main_dir_name,file_name,'.pdf'));
% saveTightFigure(h1, strcat(main_dir_name,file_name,'_tight','.pdf'));
