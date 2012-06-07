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
file_name = 'bayesian_uniform_punish_parameter_vs_contribute_probability';

%% avariable 
NA = 20; %user number
N = NA.' -1;
b = 1;  %benefit if contribution
m = 1:1:9;
c = zeros(length(m),1);   %cost of the contribution
Y =[];
%%
X = 0:0.0001:1;
x = X;
%% 

for k=1:length(m)
    y1 = 1- (1-binocdf(m(k),N,x));
    diff = abs(y1 -x);
    minimum = min(diff);
    index = find(minimum==diff, 1, 'first');
    c(k) = x(index);
end

 x = m;
 y = c;

%% Plot the figure
plot(x,y, '-k',... 
    x,y, 'ko', 'LineWidth',1, 'MarkerSize',6, 'MarkerFace', 'k');
axis([min(x) max(x) 0 1]);
xlabel('Punishment parameter');
ylabel('Probability of contribution');
grid on;
figure(1);

h1 = figure(1);
% print(h1,'-dtiff','-r600',strcat(main_dir_name,file_name,'.tif'));
print(h1,'-deps',strcat(main_dir_name,file_name,'.eps'));
% print(h1,'-dpdf',strcat(main_dir_name,file_name,'.pdf'));
% saveTightFigure(h1, strcat(main_dir_name,file_name,'_tight','.pdf'));
