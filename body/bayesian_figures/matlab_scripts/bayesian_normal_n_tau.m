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
N = 5:2:30; %user number
N = N.';
c = zeros(length(N),1);   %cost of the contribution

%%
mu = 0.5;
delta = 0.1;
X = normrnd(mu,delta, 1000,1);
x = sort(X, 'ascend');
x_right = normcdf(x,mu,delta);

m = 1;
%% 
for k=1:length(N)
    y1 = 1- (1-binocdf(m,N(k)-1,x_right));
    diff = abs(y1 -x);
    minimum = min(diff);
    index = find(minimum==diff, 1, 'first');
    c(k) = x(index);
end
%%
A = c';

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
m = 2;
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
A = [A;c'];

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
m = 4;
%% 
for k=1:length(N)
    y1 = 1- (1-binocdf(m,N(k)-1,x_right));
    diff = abs(y1 -x);
    minimum = min(diff);
    index = find(minimum==diff, 1, 'first');
    c(k) = x(index);
end
%%
A = [A;c'];

%% Plot the figure
x = N;
plot(x,A(1,:), '-ko',...
    x,A(2,:), '-ks', ...
    x,A(3,:), '-kv', 'LineWidth',1, 'MarkerSize',6, 'MarkerFace', 'b'...
    );
%axis([min(x) max(x)+1 0 1]);
xlabel('Number of players');
ylabel('Cost');
grid on;
figure(1);
hold on;

legend('u=0.5, \delta=0.1, m=1', 'u=0.5, \delta=0.1, m=2 ', 'u=0.5, \delta=0.1, m=4');
h1 = figure(1);
% print(h1,'-dtiff','-r600',strcat(main_dir_name,file_name,'.tif'));
print(h1,'-deps',strcat(main_dir_name,file_name,'.eps'));
% print(h1,'-dpdf',strcat(main_dir_name,file_name,'.pdf'));
% saveTightFigure(h1, strcat(main_dir_name,file_name,'_tight','.pdf'));
