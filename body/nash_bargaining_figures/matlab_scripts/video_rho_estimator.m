%%
clf; %clear figures
clc; %clear command windows history;
clear all;

row = 15;
col = 1;
video_lambda = zeros( row, col );
video_b_min = zeros( row, col );
video_b_req = zeros( row, col );

%%
akiyo_rate = [0 6.65	14.96	25.04	34.83	45.27	54.57	64.42	74.88	84.14  ];
akiyo_psnr = [0 33.080	36.648	39.430	40.902	43.355	44.326	44.969	45.931	46.562   ];

x = akiyo_rate/max(akiyo_rate);
y = akiyo_psnr/max(akiyo_psnr);

myfun=inline('(A(2)-exp(A(1)*x))/(A(2)-exp(A(1)))','A','x');
A = nlinfit(x,y,myfun,[-3, 1]);
a = A(2);
lambda = -A(1);
x1 = 0:0.1:1;
y1 = (a-exp(-lambda*x1))./(a-exp(-lambda));
plot(x,y,'-o',x1,y1,'-s');
hold on;
fprintf(1, 'akiyo lambad = %.2f\n', lambda);
video_lambda(1) = lambda;
video_b_min(1) = 6.65;
video_b_req(1) = 14.96;
video_name = ['Akiyo'];



%%
carphone_rate = [ 0 9.30	17.06	25.31	35.61	46.52	54.86	64.77	74.94	85.37  ];
carphone_psnr = [ 0 29.083	32.250	33.974	35.341	37.159	38.015	38.734	39.428	40.100  ];

x = carphone_rate/max(carphone_rate);
y = carphone_psnr/max(carphone_psnr);

myfun=inline('(A(2)-exp(A(1)*x))/(A(2)-exp(A(1)))','A','x');
A = nlinfit(x,y,myfun,[-3, 1]);
a = A(2);
lambda = -A(1);
x1 = 0:0.1:1;
y1 = (a-exp(-lambda*x1))./(a-exp(-lambda));
plot(x,y,'-o',x1,y1,'-s');
fprintf(1, 'carphone lambda = %.2f\n', lambda);
video_lambda(2) = lambda;
video_b_min(2) = 9.30;
video_b_req(2) = 35.61;
video_name = strvcat(video_name, 'Carphone');

%%
clarie_rate = [0 6.35	15.10	25.09	35.18	45.44	55.65	64.97	75.31	85.91  ];
clarie_psnr = [0 34.492	38.599	41.034	42.784	44.625	45.539	46.325	46.897	47.465  ];

x = clarie_rate/max(clarie_rate);
y = clarie_psnr/max(clarie_psnr);

myfun=inline('(A(2)-exp(A(1)*x))/(A(2)-exp(A(1)))','A','x');
A = nlinfit(x,y,myfun,[-3, 1]);
a = A(2);
lambda = -A(1);
x1 = 0:0.1:1;
y1 = (a-exp(-lambda*x1))./(a-exp(-lambda));
plot(x,y,'-o',x1,y1,'-s');
fprintf(1, 'clarie lambda = %.2f\n', lambda);
video_lambda(3) = lambda;
video_b_min(3) = 6.35;
video_b_req(3) = 15.10;
video_name = strvcat(video_name, 'Clarie');

%%
coastguard_rate = [ 0 9.21	17.60	25.71	35.78	46.26	56.08	66.16	76.72	86.62    ];
coastguard_psnr = [  0  26.461	28.465	29.466	30.302	31.175	31.787	32.299	32.867	33.308  ];

x = coastguard_rate/max(coastguard_rate);
y = coastguard_psnr/max(coastguard_psnr);

myfun=inline('(A(2)-exp(A(1)*x))/(A(2)-exp(A(1)))','A','x');
A = nlinfit(x,y,myfun,[-3, 1]);
a = A(2);
lambda = -A(1);
x1 = 0:0.1:1;
y1 = (a-exp(-lambda*x1))./(a-exp(-lambda));
plot(x,y,'-o',x1,y1,'-s');
fprintf(1, 'coastguard lambda = %.2f\n', lambda);
video_lambda(4) = lambda;
video_b_min(4) = 35.78;
video_b_req(4) = 86.62;
video_name = strvcat(video_name, 'Coastguard');

%%
container_rate = [ 0 7.21	15.60	25.14	35.40	45.30	58.69	65.68	75.35	86.05   ];
container_psnr = [ 0 31.232	34.181		36.067	37.166	39.069	39.672	40.059	40.707	41.280  ];

x = container_rate/max(container_rate);
y = container_psnr/max(container_psnr);

myfun=inline('(A(2)-exp(A(1)*x))/(A(2)-exp(A(1)))','A','x');
A = nlinfit(x,y,myfun,[-3, 1]);
a = A(2);
lambda = -A(1);
x1 = 0:0.1:1;
y1 = (a-exp(-lambda*x1))./(a-exp(-lambda));
plot(x,y,'-o',x1,y1,'-s');
fprintf(1, 'container lambda = %.2f\n', lambda);
video_lambda(5) = lambda;
video_b_min(5) = 7.21;
video_b_req(5) = 25.14;
video_name = strvcat(video_name, 'Container');

%%
foreman_rate = [ 0 12.46	18.23	25.82	35.69	46.19	55.49	65.98	75.68	85.66  ];
foreman_psnr = [  0 27.783	29.779	31.698	33.177	35.184	36.193	37.143	37.779	38.427 ];
x = foreman_rate/max(foreman_rate);
y = foreman_psnr/max(foreman_psnr);

myfun=inline('(A(2)-exp(A(1)*x))/(A(2)-exp(A(1)))','A','x');
A = nlinfit(x,y,myfun,[-3, 1]);
a = A(2);
lambda = -A(1);
x1 = 0:0.1:1;
y1 = (a-exp(-lambda*x1))./(a-exp(-lambda));
plot(x,y,'-o',x1,y1,'-s');
fprintf(1, 'forman lambda = %.2f\n', lambda);
video_lambda(6) = lambda;
video_b_min(6) = 18.23;
video_b_req(6) = 46.19;
video_name = strvcat(video_name, 'Foreman');

%%
grandma_rate = [ 0 6.79	16.24	26.11	35.86	45.58	55.71	65.37	76.03	85.60  ];
grandma_psnr = [ 0 32.493	35.420	37.558	38.891	41.002	42.159	42.875	43.088	44.089   ];

x = grandma_rate/max(grandma_rate);
y = grandma_psnr/max(grandma_psnr);

myfun=inline('(A(2)-exp(A(1)*x))/(A(2)-exp(A(1)))','A','x');
A = nlinfit(x,y,myfun,[-3, 1]);
a = A(2);
lambda = -A(1);
x1 = 0:0.1:1;
y1 = (a-exp(-lambda*x1))./(a-exp(-lambda));
plot(x,y,'-o',x1,y1,'-s');
fprintf(1, 'grandma lambda = %.2f\n', lambda);
video_lambda(7) = lambda;
video_b_min(7) = 6.79;
video_b_req(7) = 16.24;
video_name = strvcat(video_name, 'Grandma');

%%
hall_rate = [ 0 9.93	16.02	25.20	35.33		45.30	55.46	65.22	75.12	85.08  ];
hall_psnr = [ 0 31.809	34.336	36.621	38.170	40.480	40.897	41.063	41.366	41.663 ];

x = hall_rate/max(hall_rate);
y = hall_psnr/max(hall_psnr);

myfun=inline('(A(2)-exp(A(1)*x))/(A(2)-exp(A(1)))','A','x');
A = nlinfit(x,y,myfun,[-3, 1]);
a = A(2);
lambda = -A(1);
x1 = 0:0.1:1;
y1 = (a-exp(-lambda*x1))./(a-exp(-lambda));
plot(x,y,'-o',x1,y1,'-s');
fprintf(1, 'hall lambda = %.2f\n', lambda);
video_lambda(8) = lambda;
video_b_min(8) = 9.93;
video_b_req(8) = 25.20;
video_name = strvcat(video_name, 'Hall');

%%
miss_america_rate = [ 0 6.21	15.45	25.17	35.24	45.33	55.31	65.44	75.73	85.23  ];
miss_america_psnr = [0  36.043	39.762	41.621	42.732	43.952	44.427	44.872	45.197	45.463  ];

x = miss_america_rate/max(miss_america_rate);
y = miss_america_psnr/max(miss_america_psnr);

myfun=inline('(A(2)-exp(A(1)*x))/(A(2)-exp(A(1)))','A','x');
A = nlinfit(x,y,myfun,[-3, 1]);
a = A(2);
lambda = -A(1);
x1 = 0:0.1:1;
y1 = (a-exp(-lambda*x1))./(a-exp(-lambda));
plot(x,y,'-o',x1,y1,'-s');
fprintf(1, 'Miss America lambda = %.2f\n', lambda);
video_lambda(9) = lambda;
video_b_min(9) = 6.21;
video_b_req(9) = 15.45; 
video_name = strvcat(video_name, 'Miss America');

%%
mobile_rate = [0 25.55	25.55	34.43	41.41	54.81	62.87	69.64	78.75	85.08  ];
mobile_psnr = [0 23.946	23.946	25.346	26.379	26.822	27.893	28.750	29.448	29.825  ];

x = mobile_rate/max(mobile_rate);
y = mobile_psnr/max(mobile_psnr);

myfun=inline('(A(2)-exp(A(1)*x))/(A(2)-exp(A(1)))','A','x');
A = nlinfit(x,y,myfun,[-3, 1]);
a = A(2);
lambda = -A(1);
x1 = 0:0.1:1;
y1 = (a-exp(-lambda*x1))./(a-exp(-lambda));
plot(x,y,'-o',x1,y1,'-s');
fprintf(1, 'Mobile lambda = %.2f\n', lambda);
video_lambda(10) = lambda;
video_b_min(10) = 85.08;
video_b_req(10) = 85.08 * 1.5; %%need to confirm
video_name = strvcat(video_name, 'Mobile');

%%
mother_daughter_rate = [0 6.83	16.67	25.96	35.83	 45.83	 55.76	65.20	 75.92	85.16 ];
mother_daughter_psnr = [0 32.825	35.913	38.349	39.689	 41.841	 42.709	 43.455	 44.068	 44.452 ];

x = mother_daughter_rate/max(mother_daughter_rate);
y = mother_daughter_psnr/max(mother_daughter_psnr);

myfun=inline('(A(2)-exp(A(1)*x))/(A(2)-exp(A(1)))','A','x');
A = nlinfit(x,y,myfun,[-3, 1]);
a = A(2);
lambda = -A(1);
x1 = 0:0.1:1;
y1 = (a-exp(-lambda*x1))./(a-exp(-lambda));
plot(x,y,'-o',x1,y1,'-s');
fprintf(1, 'Mother and Daughter = %.2f\n', lambda);
video_lambda(11) = lambda;
video_b_min(11) = 6.83;
video_b_req(11) = 16.67;
video_name = strvcat(video_name, 'Mother\&daughter');

%%
news_rate = [ 0 8.17	17.16	25.14	35.58	45.40	55.61	65.30	75.40	85.42 ];
news_psnr = [ 0 28.995	31.722	33.351	34.415	37.369	38.500	39.122	40.046	40.409 ];

x = news_rate/max(news_rate);
y = news_psnr/max(news_psnr);

myfun=inline('(A(2)-exp(A(1)*x))/(A(2)-exp(A(1)))','A','x');
A = nlinfit(x,y,myfun,[-3, 1]);
a = A(2);
lambda = -A(1);
x1 = 0:0.1:1;
y1 = (a-exp(-lambda*x1))./(a-exp(-lambda));
plot(x,y,'-o',x1,y1,'-s');
fprintf(1, 'News lambda = %.2f\n', lambda);
video_lambda(12) = lambda;
video_b_min(12) = 17.16;
video_b_req(12) = 45.40;
video_name = strvcat(video_name, 'News');

%%
salesman_rate = [ 0 6.95	16.53	25.71	35.16	45.51	55.21	65.36	75.57	85.47 ];
salesman_psnr = [ 0 27.879	31.373	32.990	34.750	37.347	38.136	38.765	39.345	40.804 ];

x = salesman_rate/max(salesman_rate);
y = salesman_psnr/max(salesman_psnr);

myfun=inline('(A(2)-exp(A(1)*x))/(A(2)-exp(A(1)))','A','x');
A = nlinfit(x,y,myfun,[-3, 1]);
a = A(2);
lambda = -A(1);
x1 = 0:0.1:1;
y1 = (a-exp(-lambda*x1))./(a-exp(-lambda));
plot(x,y,'-o',x1,y1,'-s');
fprintf(1, 'Salesman lambda = %.2f\n', lambda);
video_lambda(13) = lambda;
video_b_min(13) = 16.53;
video_b_req(13) =  35.16;
video_name = strvcat(video_name, 'Salesman');

%%
silent_rate = [0 8.17	17.16	25.14	35.58	45.40	55.61	65.30	75.40	85.42 ];
silent_psnr = [0 28.995	31.722	33.351	34.415	37.369	38.500	39.122	40.046	40.409 ];

x = silent_rate/max(silent_rate);
y = silent_psnr/max(silent_psnr);

myfun=inline('(A(2)-exp(A(1)*x))/(A(2)-exp(A(1)))','A','x');
A = nlinfit(x,y,myfun,[-3, 1]);
a = A(2);
lambda = -A(1);
x1 = 0:0.1:1;
y1 = (a-exp(-lambda*x1))./(a-exp(-lambda));
plot(x,y,'-o',x1,y1,'-s');
fprintf(1, 'Silent lambda = %.2f\n', lambda);
video_lambda(14) = lambda;
video_b_min(14) = 17.16;
video_b_req(14) = 35.58;
video_name = strvcat(video_name, 'Silent');

%%
suzie_rate = [0 8.99	17.53	28.45	38.07	47.15	55.92	66.41	75.79	85.49];
suzie_psnr = [0 31.364	34.112	35.861	36.922	38.327	38.995	39.553	40.084	40.583 ];

x = suzie_rate/max(suzie_rate);
y = suzie_psnr/max(suzie_psnr);

myfun=inline('(A(2)-exp(A(1)*x))/(A(2)-exp(A(1)))','A','x');
A = nlinfit(x,y,myfun,[-3, 1]);
a = A(2);
lambda = -A(1);
x1 = 0:0.1:1;
y1 = (a-exp(-lambda*x1))./(a-exp(-lambda));
plot(x,y,'-o',x1,y1,'-s');
fprintf(1, 'Suzie lambda = %.2f\n', lambda);
video_lambda(15) = lambda;
video_b_min(15) = 8.99;
video_b_req(15) = 28.45;
video_name = strvcat(video_name, 'Suzie');

%% power of nash bargaining game

video_power = (1 ./ video_lambda)/ sum (1 ./ video_lambda);

sum_b_min = sum(video_b_min);
B_total = 1.1 * sum_b_min;
video_b = video_b_min + video_power *(B_total-sum_b_min);

qos = (1 - exp(-lambda.*(video_b./video_b_req)) ) ./ ( 1 -exp(-lambda) );

[m,n] = size(video_lambda);
for i=1:m
    fprintf(1, '%s\t power= %.4f,\t B_min=%.2f\n', video_name(i,:), video_power(i), ...
        video_b_min(i) );
end

% for i=1:m
%     fprintf(1, '%s\t & %.4f & %.4f & %.2f & %.2f & %.2f &%.4f\\\\ \n', video_name(i,:), video_lambda(i),  video_power(i), ...
%         video_b_min(i), video_b_req(i), video_b(i), qos(i));
% end


for i=1:m
    fprintf(1, '%s\t & %.4f & %.4f & %.2f & %.2f  \\\\ \n', video_name(i,:), video_lambda(i),  video_power(i), ...
        video_b_min(i), video_b_req(i));
end

%%Equal rate
m = 15;
B_total = 1.1 * sum_b_min;
video_ear_b = B_total/15 * ones(1, m);
video_nbs_b = video_b_min + video_power *(B_total-sum_b_min);
video_ksbs_b = video_b_min + 1/m *(B_total-sum_b_min);
fprintf(1, '\n -------------------------\n');
for i=1:m
    fprintf(1, '%s\t & %.2f & %.2f & %.2f \\\\ \n', video_name(i,:), video_ear_b(i),  video_ksbs_b(i), ...
        video_nbs_b(i));
end
fprintf(1, '\n -------------------------\n');
for i=1:m
    fprintf(1, '%d  ', uint32(video_ksbs_b(i)*1000) );
end

fprintf(1, '\n -------------------------\n');
for i=1:m
    fprintf(1, '%d  ', uint32(video_nbs_b(i)*1000) );
end

