function [response]=modifiedDuoBinaryEncoder(os_factor)
t=-4:1/os_factor:4; %Limiting the response to -4T to 4T
p=zeros(1,length(t));
    for i=1:1:length(t)
        if t(i)==0 
            p(i)= 1-sin(pi*(t(i)-2))./(pi*(t(i)-2));
        elseif t(i)==2 
            p(i)=sin(pi*(t(i)))./(pi*(t(i)))-1;
        else
            p(i) = sin(pi*(t(i)))./(pi*(t(i)))-sin(pi*(t(i)-2))./(pi*(t(i)-2));
        end
    end
response=p;
figure;
plotHandle=stem(t,response); set(plotHandle,'LineWidth',1.5);
hold on; plotHandle=plot(t,response,'r');
set(plotHandle,'LineWidth',1.5);
title('Impulse Response of modified duobinary encoder');
xlabel('Sampling Time');
%ylabel('Amplitude');
end