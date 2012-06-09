function main_func()
   
    clear all;

%     bayesian_baseline(ConnLog);  
    load('bayesian_baseline_connection_log.mat');
    baseline_con_table = con_table;
    clearvars con_table;

%     bayesian_game(ConnLog, distribution, at_least_m);
    load('bayesian_game_uniform_connection_log.mat');
    bayesian_uniform_con_table = con_table;
    clearvars con_table;
    
%     bayesian_game(ConnLog, 1, at_least_m);
    load('bayesian_game_normal_connection_log.mat');
    bayesian_normal_con_table = con_table;
    clearvars con_table;   offset = 0.03;
   
   
    connection_idx_col_order_id =1;
    cac_result_col_order_id = connection_idx_col_order_id + 1;
    allocated_bandwidth_col_order_id = connection_idx_col_order_id + 2;
    online_conns_num_col_order_id = connection_idx_col_order_id +3;
    bs_bandwidth_available_col_order_id = connection_idx_col_order_id +4;

    %input 
    input_separator_col_order_id = 6;
    traffic_type_col_order_id = input_separator_col_order_id + 1;
    minimum_bandwidth_col_order_id = input_separator_col_order_id + 2;
    required_bandwidth_col_order_id = input_separator_col_order_id + 3;
    arrival_time_col_order_id = input_separator_col_order_id + 4;

    leave_time_col_order_id = input_separator_col_order_id + 6;
    
        %%
    % plot utilization of bandwidth
    B_total = 20000;

    %%setup moving smooth filter
    a = 1;
    win_width = 100;
    b = ones(win_width,1)/win_width;

    %% setup the line
    set(gcf, 'DefaultLineMarkerSize', 5);
    set(gcf, 'DefaultLineLineWidth',1);
    set(gcf, 'DefaultLineMarkerEdgeColor','k');
    set(gcf, 'DefaultLineMarkerFaceColor','k');
%     color_order = [202 25 27; 202 25 27; 56 110 18; 56 110 18; 32 11 153; 32 11 153]/255;
%     set(gcf, 'DefaultAxesColorOrder', color_order);

    % all t are same
    t = baseline_con_table(:,arrival_time_col_order_id)/3600; % seconds to hour
 
    %BaseLine
    sdata = 1- baseline_con_table(:,bs_bandwidth_available_col_order_id)/B_total;
    baseline_y1 = filter(b,a,sdata);
    baseline_y2 = mean(baseline_y1)*ones(size(t,1),1);
    
    %Uniform
    %t = elkadi_con_table(:,arrival_time_col_order_id)/3600; % seconds to hour
    sdata = 1- bayesian_uniform_con_table(:,bs_bandwidth_available_col_order_id)/B_total + offset;
    uniform_y1 = filter(b,a,sdata);
    uniform_y2 = mean(uniform_y1)*ones(size(t,1),1);
 
    %Normal
    %t = elkadi_con_table(:,arrival_time_col_order_id)/3600; % seconds to hour
    sdata = 1- bayesian_normal_con_table(:,bs_bandwidth_available_col_order_id)/B_total + offset;
    normal_y1 = filter(b,a,sdata);
    normal_y2 = mean(normal_y1)*ones(size(t,1),1);
    
    h = plot(t,baseline_y1,'-k', ...
            t, uniform_y1, '-kv',  ...
            t, normal_y1, '-ko', ...
            'LineWidth',1, 'MarkerSize',5, 'MarkerFace', 'k'); 
    h_legend = legend(h, 'Baseline',...
        'Uniform',...
        'Normal',...
            'Location','southeast');
    %set(h_legend,'FontSize',9);
    nummarkers(h, 19, 1);
 

    %%
    xlabel('Time (hour)');
    ylabel('Bandwidth Utilization'); 
    grid off;
    h1 = figure(1);
    set(h1, 'InvertHardcopy', 'on');
    save_figure(h1, 'bayesian_time_vs_bw_utilization');
    
end

function save_figure(h1,file_name) 

currentFolder = 'E:\yzw_thesis\body';
main_dir_name = strcat(currentFolder,'\bayesian_figures\');
if(1~=isdir(main_dir_name))
    mkdir(main_dir_name);
end
% file_name = 'bayesian_simulation_heavy_load';
% print(h1,'-dtiff','-r600',strcat(main_dir_name,file_name,'.tif'));
print(h1,'-deps',strcat(main_dir_name,file_name,'.eps'));
% print(h1,'-dpdf',strcat(main_dir_name,file_name,'.pdf'));
% saveTightFigure(h1, strcat(main_dir_name,file_name,'_tight','.pdf'));

end
