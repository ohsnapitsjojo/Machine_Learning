%% Load Data and preprocessing
clear all;
load('dataGMM.mat');

k = 4;
min_ = -0.1;
step = .005;
max_ = 0.1;

priors = ones(k,1);
covariance = cell(k,1);
cluster = cell(k,1);
g = cell(k,1);
gPlot = cell(k,1);
N = size(Data, 2);
nK = zeros(4,1);

x = min_:step:max_;
y = min_:step:max_;
[X Y] = meshgrid(x,y);

ccD = 0;
mmD = 0;
ppD = 0;
delta = 0;
llAlt = 0;
ppAlt = 0;
mmAlt = 0;
ccAlt = 0;

%% initialize the GMMs
[label,mean] = kmeans(Data', k);


for i=1:k
    cluster{i} = Data(:,find(label == i));
    covariance{i} = cov(cluster{i}');
    g{i} = mvnpdf(Data', mean(i,:),covariance{i});
    nK(i) = size(cluster{i}, 2);
    priors(i) = nK(i)/N ;
end


%%

i=0;


plotAll( X, Y, step, cluster, covariance, k, mean, Data, 'Before EM.' );
lll = zeros(10000,1);
d = zeros(10000,1);
mm = zeros(10000,1);
pp = zeros(10000,1);
cc = zeros(10000,1);

while (ccD > 1e-5)  || (mmD > 1e-2) || (i < 10) || (ppD > 1e-5)
    i = i + 1;
    [ mean, covariance, priors, g, ll, cluster ] = updateGMM( g, priors, Data');
    delta = abs(llAlt-ll);

    
    cc(i) = sum(sum(covariance{1})) + sum(sum(covariance{2})) + sum(sum(covariance{3})) + sum(sum(covariance{4}));
    mm(i) = sum(sum(mean));
    pp(i) = max(priors);
    lll(i) = ll;
    d(i) = delta;
    mmD = abs(mmAlt-mm(i));
    ppD = abs(max(ppAlt-pp(i)));
    ccD = abs(ccAlt-cc(i));

    llAlt = ll;
    mmAlt = mm(i);
    ppAlt = priors;
    ccAlt = sum(sum(covariance{1})) + sum(sum(covariance{2})) + sum(sum(covariance{3})) + sum(sum(covariance{4}));

end


plotAll( X, Y, step, cluster, covariance, k, mean, Data, 'After convergence.' );



