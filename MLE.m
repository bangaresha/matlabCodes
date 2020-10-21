% Maximum likelihood Estimation
d=410; %Number of bits in error
n=90*10; %Total number of bits sent
k=n-d; %Number of Bits NOT in error
q=0:0.002:1; %range of success probability to test likelihood
y=binopdf(k,n,q); % assuming binomial distribution
plot(q,y);
xlabel('Probaility q');
ylabel('Likelihood');
title('Maximum Likelihood Estimation');
[maxY,maxIndex]=max(y); % Finding the Max and its index
fprintf('MLE of q is %f',q(maxIndex)) %print the probability corresponding to the max(y)