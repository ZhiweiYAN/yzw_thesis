function main_func()
   
    clear all;
    distribution = 0;
    at_least_m = 4;
    ConnLog=Generate_Users_Log(...
        7200, distribution, ...
        64, 4000, ...
        300, 120);

    bayesian_baseline(ConnLog);  
    load('bayesian_baseline_connection_log.mat');
    baseline_con_table = con_table;
    clearvars con_table;

    bayesian_game(ConnLog, 0, at_least_m);
    load('bayesian_game_uniform_connection_log.mat');
    bayesian_uniform_con_table = con_table;
    clearvars con_table;
    
    bayesian_game(ConnLog, 1, at_least_m);
    load('bayesian_game_normal_connection_log.mat');
    bayesian_normal_con_table = con_table;
    clearvars con_table;   
   
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
    sdata = baseline_con_table(:,online_conns_num_col_order_id);
    baseline_y1 = filter(b,a,sdata);
    baseline_y2 = mean(baseline_y1)*ones(size(t,1),1);
    
    %Uniform
    %t = elkadi_con_table(:,arrival_time_col_order_id)/3600; % seconds to hour
    sdata = bayesian_uniform_con_table(:,online_conns_num_col_order_id);
    uniform_y1 = filter(b,a,sdata);
    uniform_y2 = mean(uniform_y1)*ones(size(t,1),1);
 
    %Normal
    %t = elkadi_con_table(:,arrival_time_col_order_id)/3600; % seconds to hour
    sdata = bayesian_normal_con_table(:,online_conns_num_col_order_id);
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
    ylabel('Ongoing Users Capacity'); 
    grid off;
    h1 = figure(1);
    set(h1, 'InvertHardcopy', 'on');
    save_figure(h1, 'bayesian_time_vs_ongoing_user_number');
    
end

function bayesian_game(ConnLog, distribution, at_least_m)

    con_table = ConnLog;
    [log_row, log_col] = size(con_table);
    
   %output
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
    
    cac_accept_flag = 1;
    cac_block_flag = 0;


    B_total = 20000;
    ongoing_cons_table = zeros(1, log_col);
    block_num = 0;
    for i = 1:1:log_row
        if mod(i,1000)==0
        fprintf(1, 'idx : %d\r', i);
        end
        % take a connection K from the log file of connections.
        con_K = con_table(i,:);

        % take the arrive time t_K^{arrival} from the information of the connection K.
        con_K_arrival_time = con_K(:,arrival_time_col_order_id);

        % compare the time t_K^{arrival} with all leave time t_i^{leave} in the the
        % ongoing connections table, and delete the leave time less than
        % t_K^{arrival}. 
        delete_flag = 1;
        while delete_flag == 1
            [ongoing_row, ongoing_col] = size(ongoing_cons_table);
            for j = 1:1:ongoing_row
                con_j = ongoing_cons_table(j,:);
                con_j_leave_time = con_j(:,leave_time_col_order_id);

                if (con_K_arrival_time > con_j_leave_time) && (con_j_leave_time > 1)
                    ongoing_cons_table(j,:)=[];
                    break;
                end
            end
            if j>=ongoing_row
                delete_flag = 0;
                break;
            end
        end
       % compute QoS level for every ongoing connection
       [ongoing_row, ongoing_col] = size(ongoing_cons_table);

        % sum the allocated bandwidth in the ongoing table, and get the availble
        % bandwidth B_{available} = B_{total} - {\sum b_{allocated}
        B_allocated = sum(ongoing_cons_table(:, allocated_bandwidth_col_order_id));
        B_ava = B_total - B_allocated;
        con_K(:,bs_bandwidth_available_col_order_id) = B_ava;

        % if the b_K^{required} <= B_{available}, insert the connection into the
        % onging table; if not, reject the connection and set block flag.
        % if ( B_ava >= con_K(:,minimum_bandwidth_col_order_id) )
        
        
        if ( B_ava >= con_K(:,required_bandwidth_col_order_id) )
            con_K(:,allocated_bandwidth_col_order_id) = ...
                    con_K(:,required_bandwidth_col_order_id);
            con_K(:,cac_result_col_order_id) = cac_accept_flag;
            con_K(:,online_conns_num_col_order_id) = size(ongoing_cons_table,1);
            ongoing_cons_table = [ongoing_cons_table;con_K];
            con_table(i,:) = con_K;
        else
            
            %do game
            [c, decision] = Do_Game(ongoing_cons_table(:,traffic_type_col_order_id), at_least_m, distribution);
            free_res_array = ( ongoing_cons_table(:, allocated_bandwidth_col_order_id)...
                    - ongoing_cons_table(:,minimum_bandwidth_col_order_id) )...
                    .* decision ;           
            if ( sum(decision)>=at_least_m && sum(free_res_array) + B_ava > con_K(:,required_bandwidth_col_order_id))
                ongoing_cons_table(:, allocated_bandwidth_col_order_id)...
                    = ongoing_cons_table(:, allocated_bandwidth_col_order_id) ...
                      - free_res_array;
                con_K(:,allocated_bandwidth_col_order_id) = ...
                        con_K(:,required_bandwidth_col_order_id);
                con_K(:,cac_result_col_order_id) = cac_accept_flag;
                con_K(:,online_conns_num_col_order_id) = size(ongoing_cons_table,1);
                ongoing_cons_table = [ongoing_cons_table;con_K];
                con_table(i,:) = con_K;                         
            else
            
            block_num = block_num + 1;
            fprintf ('Block %d connections, [ idx:  %d ].\n', block_num, con_K(:,connection_idx_col_order_id));
            con_K(:,allocated_bandwidth_col_order_id) = 0;        
            con_table(i,cac_result_col_order_id) = cac_block_flag;
            con_K(:,cac_result_col_order_id) = cac_block_flag;
            con_K(:,online_conns_num_col_order_id) = size(ongoing_cons_table,1)-1;
            con_table(i,:) = con_K;
            end
        end
    end   
    if(1==distribution)
         save('bayesian_game_normal_connection_log.mat', 'con_table');
    else
        save('bayesian_game_uniform_connection_log.mat', 'con_table');        
    end
    clearvars -except con_table;
    fprintf('End.\n');      

end

function bayesian_baseline(ConnLog)

    con_table = ConnLog;
    [log_row, log_col] = size(con_table);
    
   %output
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
    
    cac_accept_flag = 1;
    cac_block_flag = 0;


    B_total = 20000;
    ongoing_cons_table = zeros(1, log_col);
    block_num = 0;
    for i = 1:1:log_row
        if mod(i,1000)==0
        fprintf(1, 'idx : %d\r', i);
        end
        % take a connection K from the log file of connections.
        con_K = con_table(i,:);

        % take the arrive time t_K^{arrival} from the information of the connection K.
        con_K_arrival_time = con_K(:,arrival_time_col_order_id);

        % compare the time t_K^{arrival} with all leave time t_i^{leave} in the the
        % ongoing connections table, and delete the leave time less than
        % t_K^{arrival}. 
        delete_flag = 1;
        while delete_flag == 1
            [ongoing_row, ongoing_col] = size(ongoing_cons_table);
            for j = 1:1:ongoing_row
                con_j = ongoing_cons_table(j,:);
                con_j_leave_time = con_j(:,leave_time_col_order_id);

                if (con_K_arrival_time > con_j_leave_time) && (con_j_leave_time > 1)
                    ongoing_cons_table(j,:)=[];
                    break;
                end
            end
            if j>=ongoing_row
                delete_flag = 0;
                break;
            end
        end
       % compute QoS level for every ongoing connection
       [ongoing_row, ongoing_col] = size(ongoing_cons_table);

        % sum the allocated bandwidth in the ongoing table, and get the availble
        % bandwidth B_{available} = B_{total} - {\sum b_{allocated}
        B_allocated = sum(ongoing_cons_table(:, allocated_bandwidth_col_order_id));
        B_ava = B_total - B_allocated;
        con_K(:,bs_bandwidth_available_col_order_id) = B_ava;

        % if the b_K^{required} <= B_{available}, insert the connection into the
        % onging table; if not, reject the connection and set block flag.
        % if ( B_ava >= con_K(:,minimum_bandwidth_col_order_id) )
        if ( B_ava >= con_K(:,required_bandwidth_col_order_id) )
            con_K(:,allocated_bandwidth_col_order_id) = ...
                    con_K(:,required_bandwidth_col_order_id);
            con_K(:,cac_result_col_order_id) = cac_accept_flag;
            con_K(:,online_conns_num_col_order_id) = size(ongoing_cons_table,1);
            ongoing_cons_table = [ongoing_cons_table;con_K];
            con_table(i,:) = con_K;
        else
            block_num = block_num + 1;
            fprintf ('Block %d connections, [ idx:  %d ].\n', block_num, con_K(:,connection_idx_col_order_id));
            con_K(:,allocated_bandwidth_col_order_id) = 0;        
            con_table(i,cac_result_col_order_id) = cac_block_flag;
            con_K(:,cac_result_col_order_id) = cac_block_flag;
            con_K(:,online_conns_num_col_order_id) = size(ongoing_cons_table,1)-1;
            con_table(i,:) = con_K;
        end
    end   
    save('bayesian_baseline_connection_log.mat', 'con_table');
    clearvars -except con_table;
    fprintf('End.\n');    
end
function [connections]=Generate_Users_Log(...
    simulation_time, distribution, ...
    minimum_bw, maximum_bw, ...
    arrival_rate, service_time)
    %start time and end time of the simulation
    start_time = 0; %time unit : seconds
    end_time = simulation_time;
    
    SAMPLE_TIME_DURATION = 3600; % 3600 senconds = 1 hour
    
    %how many connections
    conn_number = (end_time - start_time)/SAMPLE_TIME_DURATION * arrival_rate;

    %required bandwidth
    req_bw = randi([minimum_bw, maximum_bw], conn_number, 1); 
    
    %traffic_type_id
    % cost 
    if 1==distribution
        % T_ means Theory,
        T_mu = 0.5;
        T_delta = 0.1;
        c_i = normrnd(T_mu,T_delta, conn_number, 1);
    else
        c_i = unifrnd(0,1, conn_number,1);
    end
    traf_type = c_i;

    %minimum bandwidth
    min_bw = (1-c_i) .* req_bw;

    %allocated bandwidth
    alct_bw = zeros(conn_number, 1);
    
    %arrival_time of connections
    arri_interval_time = exprnd(SAMPLE_TIME_DURATION/arrival_rate, [conn_number,1]);
    arri_time = cumsum(arri_interval_time);

    %stay_time_in_system
    stay_time = exprnd(service_time, [conn_number,1]);

    %leave time of connections
    leav_time = arri_time + stay_time;

    %CAC flags 1:accept(default), 0:block
    cac_flag = ones(conn_number, 1);

    %input_seperator, default = 121121
    input_seperator = ones(conn_number, 1) * 121121;

    %online_conns, default = 0
    online_conns_num = zeros(conn_number, 1);

    %available bandwidth, default = 0
    bs_bw_ava = zeros(conn_number, 1);

    %for saving temperary variable, default = 0
    tmp_value = zeros(conn_number, 1);
    idx = cumsum(cac_flag);
    connections = [idx, cac_flag, alct_bw, online_conns_num, ...
    bs_bw_ava, ...
    input_seperator, ...
    traf_type, min_bw, req_bw, ...
    arri_time, stay_time, leav_time , tmp_value];
end

function [c, decision]=Do_Game(UserQueue, at_least_m, distribution)

U_C = UserQueue;
N = length(U_C);

%% P_ means practical
P_mu = mean(U_C);
P_delta = var(U_C);

%% c^*
if (1 == distribution)
    X = normrnd(P_mu,P_delta, 1000,1);
    x = sort(X, 'ascend');
    x_right = normcdf(x,P_mu,P_delta);
else
    X = unifrnd(0,1, 1000,1);
    x = sort(X, 'ascend');
    x_right = x;
end
    y1 = 1- (1-binocdf(at_least_m,N-1,x_right));
    diff = abs(y1 -x);
    minimum = min(diff);
    index = find(minimum==diff, 1, 'first');
    c = x(index);
%     fprintf(1,'C = %.2f\n', c);

%% Decision
decision = zeros(N,1); 
for i=1:N
    di = unifrnd(0,1,1,1);
    if di < c
        decision(i) = 1;
    else
        decision(i) = 0;
    end
end

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