%%
clf; %clear figures
clc; %clear command windows history;
clear all;

%%
currentFolder = pwd;
main_dir_name = strcat(currentFolder,'\output_figures\');
mkdir(main_dir_name);

%%
video_name = 'video';
file_name = strcat(video_name, 'bitrate_psnr');

%% 

%% 
akiyo_rate = [6.65	14.96	25.04	34.83	45.27	54.57	64.42	74.88	84.14  ];
akiyo_psnr = [33.080	36.648	39.430	40.902	43.355	44.326	44.969	45.931	46.562   ];
h(1) = plot(akiyo_rate, akiyo_psnr, '-ok');
hold on;

% 
carphone_rate = [ 9.30	17.06	25.31	35.61	46.52	54.86	64.77	74.94	85.37  ];
carphone_psnr = [ 29.083	32.250	33.974	35.341	37.159	38.015	38.734	39.428	40.100  ];
h(2) = plot(carphone_rate, carphone_psnr, '-+k');


%% 
clarie_rate = [ 6.35	15.10	25.09	35.18	45.44	55.65	64.97	75.31	85.91  ];
clarie_psnr = [ 34.492	38.599	41.034	42.784	44.625	45.539	46.325	46.897	47.465  ];
h(3) = plot(clarie_rate, clarie_psnr, '-hk');


%% 
coastguard_rate = [ 9.21	17.60	25.71	35.78	46.26	56.08	66.16	76.72	86.62    ];
coastguard_psnr = [   26.461	28.465	29.466	30.302	31.175	31.787	32.299	32.867	33.308  ];
h(4) = plot(coastguard_rate, coastguard_psnr, '-pk');


%% 
container_rate = [ 7.21	15.60	25.14	35.40	45.30	58.69	65.68	75.35	86.05   ];
container_psnr = [ 31.232	34.181		36.067	37.166	39.069	39.672	40.059	40.707	41.280  ];
h(5) =plot(container_rate, container_psnr, '-<k');


%% 
foreman_rate = [ 12.46	18.23	25.82	35.69	46.19	55.49	65.98	75.68	85.66  ];
foreman_psnr = [  27.783	29.779	31.698	33.177	35.184	36.193	37.143	37.779	38.427 ];
h(6) =plot(foreman_rate, foreman_psnr, '->k');


%% 
grandma_rate = [ 6.79	16.24	26.11	35.86	45.58	55.71	65.37	76.03	85.60  ];
grandma_psnr = [ 32.493	35.420	37.558	38.891	41.002	42.159	42.875	43.088	44.089   ];
h(7) =plot(grandma_rate, grandma_psnr, '-vk');
% hold on

legend('akiyo',...
    'carphone',...
    'clarie',...
    'coastguard',...
    'container',...
    'foreman',...
    'grandma',...
    'Location','SouthEast');
xlabel('Bitrates (k/bits)');
ylabel('PSNR(dB)');
axis([0 90 0 50]);
grid on;
h1 = figure(1);

print(h1,'-dtiff','-r600',strcat(main_dir_name,file_name,'.tif'));
print(h1,'-deps',strcat(main_dir_name,file_name,'.eps'));
print(h1,'-dpdf',strcat(main_dir_name,file_name,'.pdf'));
saveTightFigure(h1, strcat(main_dir_name,file_name,'_tight','.pdf'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hold off;
clf;
clc;

%% 
hall_rate = [ 9.93	16.02	25.20	35.33		45.30	55.46	65.22	75.12	85.08  ];
hall_psnr = [  31.809	34.336	36.621	38.170	40.480	40.897	41.063	41.366	41.663 ];
h(8) =plot(hall_rate, hall_psnr, '-^k');
hold on

%% 
miss_america_rate = [ 6.21	15.45	25.17	35.24	45.33	55.31	65.44	75.73	85.23  ];
miss_america_psnr = [ 36.043	39.762	41.621	42.732	43.952	44.427	44.872	45.197	45.463  ];
h(9) =plot(miss_america_rate, miss_america_psnr, '-dk');
% hold on

%%
% mobile_psnr = [ 23.946	23.946	25.346	26.379	26.822	27.893	28.750	29.448	29.825  ];
% mobile_rate = [ 25.55	25.55	34.43	41.41	54.81	62.87	69.64	78.75	85.08  ];
% h(10) = plot(mobile_rate, mobile_psnr, '-sk');
% hold on

%%
mother_daughter_rate = [6.83	16.67	25.96	35.83	 45.83	 55.76	65.20	 75.92	85.16 ];
mother_daughter_psnr = [ 32.825	35.913	38.349	39.689	 41.841	 42.709	 43.455	 44.068	 44.452 ];
h(11) =plot(mother_daughter_rate, mother_daughter_psnr, '-xk');
% % legend('mother-daughter','Location','SouthEast');
% hold on;

%%
news_rate = [ 8.17	17.16	25.14	35.58	45.40	55.61	65.30	75.40	85.42 ];
news_psnr = [ 28.995	31.722	33.351	34.415	37.369	38.500	39.122	40.046	40.409 ];
h(12) = plot(news_rate, news_psnr, '-^k');
% % legend('news','Location','SouthEast');
% hold on;

%%
salesman_rate = [ 6.95	16.53	25.71	35.16	45.51	55.21	65.36	75.57	85.47 ];
salesman_psnr = [ 27.879	31.373	32.990	34.750	37.347	38.136	38.765	39.345	40.804 ];
h(13) =plot(salesman_rate, salesman_psnr, '-*k');
% % legend('salesman','Location','SouthEast');
% hold on;
%%
silent_rate = [ 8.17	17.16	25.14	35.58	45.40	55.61	65.30	75.40	85.42 ];
silent_psnr = [ 28.995	31.722	33.351	34.415	37.369	38.500	39.122	40.046	40.409 ];
h(14) =plot(silent_rate, silent_psnr, '-ok');
% % legend('silent','Location','SouthEast');
% hold on;

%%
suzie_rate = [8.99	17.53	28.45	38.07	47.15	55.92	66.41	75.79	85.49];
suzie_psnr = [31.364	34.112	35.861	36.922	38.327	38.995	39.553	40.084	40.583 ];
h(15) = plot(suzie_rate, suzie_psnr, '-+k');
% % legend('suzie','Location','SouthEast');
% hold on;

%%
  %  'mobile',...        mobile_rate, mobile_psnr, '-sk',...
% hdl = plot(akiyo_rate, akiyo_psnr, '-ok',...
%         carphone_rate, carphone_psnr, '-+k',...
%         clarie_rate, clarie_psnr, '-hk',...
%         coastguard_rate, coastguard_psnr, '-pk',...
%         container_rate, container_psnr, '-<k',...
%         foreman_rate, foreman_psnr, '->k',...
%         grandma_rate, grandma_psnr, '-vk',...
%         hall_rate, hall_psnr, '-^k',...
%         miss_america_rate, miss_america_psnr, '-dk',...
%         mother_daughter_rate, mother_daughter_psnr, '-xk',...
%         news_rate, news_psnr, '-^k',...
%         salesman_rate, salesman_psnr, '-*k',...
%         silent_rate, silent_psnr, '-ok',...
%         suzie_rate, suzie_psnr, '-+k');
legend('hall',...
    'miss-america',...
    'mother-daughter',...
    'news',...
    'salesman',...
    'silent',...
    'suzie',...
    'Location','SouthEast');
xlabel('Bitrates (k/bits)');
ylabel('PSNR(dB)');
axis([0 90 0 50]);
grid on;
h2 = figure(1);
file_name = strcat(file_name, '2');
print(h2,'-dtiff','-r600',strcat(main_dir_name,file_name,'.tif'));
print(h2,'-deps',strcat(main_dir_name,file_name,'.eps'));
print(h2,'-dpdf',strcat(main_dir_name,file_name,'.pdf'));
saveTightFigure(h2, strcat(main_dir_name,file_name,'_tight','.pdf'));

%%display output directory
currentFolder = pwd;
asm = NET.addAssembly('System.Windows.Forms');
import System.Windows.Forms.*;
MessageBox.Show(main_dir_name);

% clf;
% clear all;


% Quality=(1-exp(A(1)*x))/(1-exp(A(1)));
% plot(x,y,'o',x,Quality,'+');
% figure(1);