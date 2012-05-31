%% ????
clear all;

%% ???
currentFolder = 'E:\yzw_thesis\body';
main_dir_name = strcat(currentFolder,'\bayesian_figures\');
if(1~=isdir(main_dir_name))
    mkdir(main_dir_name);
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ????
range = [0, 1];
mu = 0.5;
delta = 0.1;

%% ???????
[p_h,f_h]= normspec(range, mu, delta);
h = gcf;

%% ????
xlabel('Value of Random Variable (cost)');
ylabel('Probability Density');

%% ????
%%???
file_name = 'bayesian_normal_density_scheme';
exportfig(h, strcat(main_dir_name,file_name,'.eps'), 'Format','eps', 'LockAxes', 1, 'Color', 'rgb');
%exportfig(h, strcat(main_dir_name,file_name,'.tif'), 'Format','tiff', 'Resolution', 600, 'Color', 'rgb');
%exportfig(h, strcat(main_dir_name,file_name,'.pdf'), 'Format', 'pdf', 'Color', 'rgb');

clf;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ????
mu = 0.5;
delta = 0.1;
X = normrnd(mu,delta, 1000,1);
%% ???????
x = sort(X, 'ascend');
y = normcdf(x,mu,delta);
plot(x,y, 'b');
h = gcf;
%% ????
xlabel('Value of Random Variable (cost)');
ylabel('Probability');

%% ????
%%???
file_name = 'bayesian_normal_cdf_scheme';
exportfig(h, strcat(main_dir_name,file_name,'.eps'), 'Format','eps', 'LockAxes', 1, 'Color', 'rgb');
%exportfig(h, strcat(main_dir_name,file_name,'.tif'), 'Format','tiff', 'Resolution', 600, 'Color', 'rgb');
%exportfig(h, strcat(main_dir_name,file_name,'.pdf'), 'Format', 'pdf', 'Color', 'rgb');


%% ????
clf;
clear all;