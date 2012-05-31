%% clear
clear all;

%% path
currentFolder = 'E:\yzw_thesis\body';
main_dir_name = strcat(currentFolder,'\bayesian_figures\');
if(1~=isdir(main_dir_name))
    mkdir(main_dir_name);
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% data
x = 0:0.01:1;
y = ones(length(x),1);

%% density of probability
box off
area(x,y);
h = gcf;

%% label
xlabel('Value of Random Variable (cost)');
ylabel('Probability Density');
axis([0 2 0 2]);

%% save
%% filename
file_name = 'bayesian_uniform_density_scheme';
exportfig(h, strcat(main_dir_name,file_name,'.eps'), 'Format','eps', 'LockAxes', 1, 'Color', 'rgb');
%exportfig(h, strcat(main_dir_name,file_name,'.tif'), 'Format','tiff', 'Resolution', 600, 'Color', 'rgb');
%exportfig(h, strcat(main_dir_name,file_name,'.pdf'), 'Format', 'pdf', 'Color', 'rgb');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% data
x = 0:0.01:1;
y = cdf('unif',x, 0, 1);
%% plot
plot(x,y, 'k');
h = gcf;
%% label
xlabel('Value of Random Variable (cost)');
ylabel('Probability');

%% save
file_name = 'bayesian_uniform_cdf_scheme';
exportfig(h, strcat(main_dir_name,file_name,'.eps'), 'Format','eps', 'LockAxes', 1, 'Color', 'rgb');
%exportfig(h, strcat(main_dir_name,file_name,'.tif'), 'Format','tiff', 'Resolution', 600, 'Color', 'rgb');
%exportfig(h, strcat(main_dir_name,file_name,'.pdf'), 'Format', 'pdf', 'Color', 'rgb');


%% clear
clf;
clear all;