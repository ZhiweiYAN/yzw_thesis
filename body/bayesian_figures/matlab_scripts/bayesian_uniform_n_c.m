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
NA = 5:2:30; %user number
N = NA.' -1;
b = 1;  %benefit if contribution

c = zeros(length(N),1);   %cost of the contribution
Y =[];
%%
X = 0:0.0001:1;
x = X;
%% 
m = 1;
for k=1:length(N)
    y1 = 1- (1-binocdf(m,N(k)-1,x));
    diff = abs(y1 -x);
    minimum = min(diff);
    index = find(minimum==diff, 1, 'first');
    c(k) = x(index);
 end

%%
%% the number of players and cost
Y = [Y;c'];

m = 2;
for k=1:length(N)
    y1 = binocdf(m,N(k),x);
    diff = abs(y1 -x);
    minimum = min(diff);
    index = find(minimum==diff, 1, 'first');
    c(k) = x(index);
 end

%%
%% the number of players and cost
Y = [Y;c'];

m = 4;
for k=1:length(N)
    y1 = binocdf(m,N(k)-1,x);
    diff = abs(y1 -x);
    minimum = min(diff);
    index = find(minimum==diff, 1, 'first');
    c(k) = x(index);
 end

%%
%% the number of players and cost
Y = [Y;c'];


x = NA;
%% Plot the figure
plot(x,Y(1,:), '-ko',...
    x,Y(2,:), '-ks', ...
    x,Y(3,:), '-kv', 'LineWidth',1, 'MarkerSize',6, 'MarkerFace', 'b'...
    );
% axis([min(x) max(x) 0.4 0.6]);
legend('m=1', 'm=2', 'm=4');
xlabel('Number of players');
ylabel('Cost');
grid on;
figure(1);

h1 = figure(1);
% print(h1,'-dtiff','-r600',strcat(main_dir_name,file_name,'.tif'));
print(h1,'-deps',strcat(main_dir_name,file_name,'.eps'));
% print(h1,'-dpdf',strcat(main_dir_name,file_name,'.pdf'));
% saveTightFigure(h1, strcat(main_dir_name,file_name,'_tight','.pdf'));
