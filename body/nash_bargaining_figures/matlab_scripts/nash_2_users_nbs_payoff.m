function main_function()
%% Setup
clear all;
clc;

%rate unit = Kbps
B_total = 300;

bargain_power = 0.1:0.2:1.1;
bargain_power = bargain_power';
alpha = [bargain_power,1 - bargain_power];

[m,n] = size(alpha);

b_min_list = [64, 96];
b_min = [ones(m,1).*b_min_list(1), ones(m,1).*b_min_list(2)];
b = b_min + alpha .* ( B_total - sum(b_min_list) );

rho_1 = 4;
rho_2 = 5;
B_req_list = [256, 384];
B_req = [ones(m,1).*B_req_list(1), ones(m,1).*B_req_list(2)];
u_1 = rho_1.*b(:,1)./B_req(1);
u_2 = rho_2.*b(:,2)./B_req(2);

u_1 = ( 1 - exp(-u_1) )/( 1 - exp(-rho_1));
u_2 = ( 1 - exp(-u_2) )/( 1 - exp(-rho_2));

x1 = u_1;
y1 = u_2;

grid on;

hold on;

B_total = 250;

bargain_power = 0.1:0.2:1.1;
bargain_power = bargain_power';
alpha = [bargain_power,1 - bargain_power];

[m,n] = size(alpha);

b_min_list = [64, 96];
b_min = [ones(m,1).*b_min_list(1), ones(m,1).*b_min_list(2)];
b = b_min + alpha .* ( B_total - sum(b_min_list) );

rho_1 = 4;
rho_2 = 5;
B_req_list = [256, 384];
B_req = [ones(m,1).*B_req_list(1), ones(m,1).*B_req_list(2)];
u_1 = rho_1.*b(:,1)./B_req(1);
u_2 = rho_2.*b(:,2)./B_req(2);

u_1 = ( 1 - exp(-u_1) )/( 1 - exp(-rho_1));
u_2 = ( 1 - exp(-u_2) )/( 1 - exp(-rho_2));

x2 = u_1;
y2 = u_2;

plot(x1(1), y1(1),'kv', ...
    x1(2), y1(2),'ks', ...
    x1(3), y1(3),'ko', ...
    x1(4), y1(4),'k*', ...
    x1(5), y1(5),'kd', ...
     x1(6), y1(6),'k^', 'LineWidth',1, 'MarkerSize',6, 'MarkerFace', 'k' );
legend('\alpha_1=0.1', '\alpha_1=0.2', '\alpha_1=0.3',...
        '\alpha_1=0.4', '\alpha_1=0.5', '\alpha_1=0.6',...
        'Location','southwest');
        
plot(x1(1), y1(1),'kv', ...
            x2(1), y2(1), 'kv',  ...
            'LineWidth',1, 'MarkerSize',5, 'MarkerFace', 'k');   
        
plot(x1(2), y1(2),'ks', ...
            x2(2), y2(2), 'ks',  ...
            'LineWidth',1, 'MarkerSize',5, 'MarkerFace', 'k');   
        
plot(x1(3), y1(3),'ko', ...
            x2(3), y2(3), 'ko',  ...
            'LineWidth',1, 'MarkerSize',5, 'MarkerFace', 'k');   
plot(x1(4), y1(4),'k*', ...
            x2(4), y2(4), 'k*',  ...
            'LineWidth',1, 'MarkerSize',5, 'MarkerFace', 'k');   
plot(x1(5), y1(5),'kd', ...
            x2(5), y2(5), 'kd',  ...
            'LineWidth',1, 'MarkerSize',5, 'MarkerFace', 'k');   
plot(x1(6), y1(6),'k^', ...
            x2(6), y2(6), 'k^',  ...
            'LineWidth',1, 'MarkerSize',5, 'MarkerFace', 'k');           
grid off;
xlabel('User1 QoS');
ylabel('User2 QoS');
%axis([0.65 1 0.65 1]);
text(0.81,0.913,'B_{total} = 200Kbps \rightarrow');
text(0.90,0.965,'\leftarrow B_{total} = 300Kbps');
h = plot(x1, y1,':k', ...
            x2, y2, ':k',  ...
            'LineWidth',1, 'MarkerSize',5, 'MarkerFace', 'k');         
h = figure(1);
save_figure(h, 'chap_nash_two_users_nbs_qos');
x = 1;
end


function save_figure(h1,file_name) 

currentFolder = 'E:\yzw_thesis\body';
main_dir_name = strcat(currentFolder,'\nash_bargaining_figures\');
if(1~=isdir(main_dir_name))
    mkdir(main_dir_name);
end
% file_name = 'bayesian_simulation_heavy_load';
% print(h1,'-dtiff','-r600',strcat(main_dir_name,file_name,'.tif'));
print(h1,'-deps',strcat(main_dir_name,file_name,'.eps'));
% print(h1,'-dpdf',strcat(main_dir_name,file_name,'.pdf'));
% saveTightFigure(h1, strcat(main_dir_name,file_name,'_tight','.pdf'));

end
