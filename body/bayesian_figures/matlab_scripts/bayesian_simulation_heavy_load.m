%%
function main_function()
    NormalResult =[];
    for i=1:1:7
        BW = i*10*10^6;
        [AvgSucc, AvgUsern, AvgCostp, AvgBenefit, AvgWithdrwBW] = Run_Different_BW(BW, 1);
        NormalResult = [NormalResult;AvgSucc, AvgUsern, AvgCostp, AvgBenefit, AvgWithdrwBW ];
    end
    
    UniformResult =[];
    for i=1:1:7
        BW = i*10*10^6;
        [AvgSucc, AvgUsern, AvgCostp, AvgBenefit, AvgWithdrwBW] = Run_Different_BW(BW, 0);
        UniformResult = [UniformResult;AvgSucc, AvgUsern, AvgCostp, AvgBenefit, AvgWithdrwBW ];
    end   
    
    NormalResult
    UniformResult
    
    x = 10:10:70;
    plot(x, UniformResult(:,1), '-kv',...
        x, NormalResult(:,1),...
        '-ko', 'LineWidth',1, 'MarkerSize',5, 'MarkerFace', 'b'...
        );
    xlabel('Total Bandwidth (Mbps)');
    ylabel('Probability of Game Success');
    legend('Uniform Distribution', 'Normal Distribution', 4);
    grid on;
    h = figure(1);
    save_figure(h,'bayesian_normal_bandwidth_vs_success_probability');   
    
%     x = 10:10:50;
    plot(x, UniformResult(:,2), '-kv',...
        x, NormalResult(:,2),...
        '-ko', 'LineWidth',1, 'MarkerSize',5, 'MarkerFace', 'b'...
        );
    xlabel('Total Bandwidth (Mbps)');
    ylabel('Ongoing User Number');
    legend('Uniform Distribution', 'Normal Distribution', 4);
    grid on;
    h = figure(1);
    save_figure(h,'bayesian_normal_bandwidth_vs_user_number');  
    
%     x = 10:10:50;
    plot(x, UniformResult(:,3), '-kv',...
        x, NormalResult(:,3),...
        '-ko', 'LineWidth',1, 'MarkerSize',5, 'MarkerFace', 'b'...
        );
    xlabel('Total Bandwidth (Mbps)');
    ylabel('Probability of Generosity Decision');
    legend('Uniform Distribution', 'Normal Distribution', 1);    
    grid on;
    h = figure(1);
    save_figure(h,'bayesian_normal_bandwidth_vs_generosity');     

%     x = 10:10:50;
    plot(x, UniformResult(:,4), '-kv',...
        x, NormalResult(:,4),...
        '-ko', 'LineWidth',1, 'MarkerSize',5, 'MarkerFace', 'b'...
        );
    xlabel('Total Bandwidth (Mbps)');
    ylabel('Average Benefit of Users');
    legend('Uniform Distribution', 'Normal Distribution', 4);    
    grid on;
    h = figure(1);
    save_figure(h,'bayesian_normal_bandwidth_vs_avg_benefit');     
    
    
%     x = 10:10:50;
    plot(x, UniformResult(:,5), '-kv',...
        x, NormalResult(:,5),...
        '-ko', 'LineWidth',1, 'MarkerSize',5, 'MarkerFace', 'b'...
        );
    xlabel('Total Bandwidth (Mbps)');
    ylabel('Ratio');
    legend('Uniform Distribution', 'Normal Distribution', 4);    
    grid on;
    h = figure(1);
    save_figure(h,'bayesian_normal_bandwidth_vs_withdraw_bw');      
end


function [AvgSucc, AvgUsern, AvgCostp, AvgBenefit, AvgWithdrwBW]=Run_Different_BW(BW, distribution)
    % run 300 times
    N = 300;
    at_least_m = 4;
    succ = 0;
    usen = 0;
    costp = 0;
    benefit = 0;
    withdraw_bw = 0;
 
    % run N game times
    for k=1:N
    OngoingUsers = [];
    OngoingUsers = Generate_Users(BW, distribution);
    [c, decision] = Do_Game(OngoingUsers, at_least_m, distribution);
    OngoingUsers = [OngoingUsers,decision];
    costp = costp + c;
    
    % Structures of OngoingUsers: c_i, bw, bottom_bw, decision
    if sum( OngoingUsers(:,4) )>=at_least_m
%         fprintf(1,'%.2f\n', sum( OngoingUsers(:,4) ));
        succ = succ + 1;
        benefit = benefit + sum(1-  OngoingUsers(:,1).* OngoingUsers(:,4))/length( OngoingUsers(:,4) );
        withdraw_bw = withdraw_bw + sum( (OngoingUsers(:,2)-OngoingUsers(:,3)) .* OngoingUsers(:,4) );
    end
    usen = usen + length( OngoingUsers(:,4) );
%     fprintf(1, '%d ', k);
    end
    fprintf(1,'\nsucc=%.4f, usern= %.4f, costp=%.4f, benefit=%.4f\n', ...
        succ/N, ...
        usen/N, ...
        costp/N,...
        benefit/N);
    AvgSucc = succ/N;
    AvgUsern = usen/N;
    AvgCostp = costp/N;
    AvgBenefit = benefit/N;
    AvgWithdrwBW = withdraw_bw/BW/N;
end

function users=Generate_Users(BW, distribution)
TotalBW = BW;
UserQueue = [];
AllocBW = 0;
while AllocBW < TotalBW
    % bandwidth 64Kbps-4Mbps
    b_i = unifrnd(64*10^3,4*10^6,1,1);
    AllocBW = AllocBW + b_i;
    % cost 
    if 1==distribution
        % T_ means Theory,
        T_mu = 0.5;
        T_delta = 0.1;
        c_i = normrnd(T_mu,T_delta, 1, 1);
    else
        c_i = unifrnd(0,1, 1,1);
    end
    % insert into queue
    bottom_b_i = (1-c_i)*b_i;
    UserQueue =[UserQueue;c_i,b_i,bottom_b_i];
end
users = UserQueue;
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [c, decision]=Do_Game(UserQueue, at_least_m, distribution)

U_C = UserQueue(:,1);
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
%%
% if sum(decision) >= at_least_m
%     benefit = sum(1- U_C.*decision)/N;
% else
%     benefit = sum(decision - U_C.*decision)/N;
% end
% AvgBenefit = benefit;


% plot(UserNumber, AvgBenefit, '-ko');


% file_name = 'bayesian_simulation_heavy_load';
% print(h1,'-dtiff','-r600',strcat(main_dir_name,file_name,'.tif'));
% print(h1,'-deps',strcat(main_dir_name,file_name,'.eps'));
% print(h1,'-dpdf',strcat(main_dir_name,file_name,'.pdf'));
% saveTightFigure(h1, strcat(main_dir_name,file_name,'_tight','.pdf'));