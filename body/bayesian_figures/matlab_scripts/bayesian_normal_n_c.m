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
N = 5:2:30; %user number
N = N.';
m = 2;  %benefit if contribution

c = zeros(length(N),1);   %cost of the contribution

%%
mu = 0.5;
delta = 0.2;
X = normrnd(mu,delta, 1000,1);
x = sort(X, 'ascend');
x_right = normcdf(x,mu,delta);

%% 
for k=1:length(N)
    y1 = 1- (1-binocdf(m,N(k)-1,x_right));
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
    y1 = 1- (1-binocdf(m,N(k)-1,x_right));
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
    y1 = 1- (1-binocdf(m,N(k)-1,x_right));
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
axis([min(x) max(x)+1 0 1]);
xlabel('Number of players');
ylabel('Cost');
grid on;
figure(1);
hold on;

legend('u=0.5, \delta=0.2, m=2', 'u=0.5, \delta=0.1, m=2 ', 'u=0.5, \delta=0.05,m=2');
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


h1 = figure(1);

file_name = 'bayesian_normal_user_number_vs_contribute_probability';
% print(h1,'-dtiff','-r600',strcat(main_dir_name,file_name,'.tif'));
print(h1,'-deps',strcat(main_dir_name,file_name,'.eps'));
% print(h1,'-dpdf',strcat(main_dir_name,file_name,'.pdf'));
% saveTightFigure(h1, strcat(main_dir_name,file_name,'_tight','.pdf'));
