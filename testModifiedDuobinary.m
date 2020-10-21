%Simulation of Duobinary Signaling
clc;clear;close all;
overSampling_Factor=4;
an= [1 0 1 1 0 0 1 1 1 1] %Input binary bits
ak=precoderD2(an) %Precoder
bn=2*ak-1% Level converter
%Duobinary Encoder
Input_bit_os=upsample(bn,overSampling_Factor); %oversampling
pt = modifiedDuoBinaryEncoder(overSampling_Factor); % impulse response duobinary encoder
output_of_duoB_filter = conv(Input_bit_os,pt); %convolving bn with duobinary response
L=length(output_of_duoB_filter);
t=-4:1/overSampling_Factor:(-4+(L-1)*1/overSampling_Factor); %defining the response from -4T to 4T
figure;
subplot(2,1,1);
plotHandle=stem(t,output_of_duoB_filter);
set(plotHandle,'LineWidth',1.5);
title('Response of modified duoBinary Filter at Tx side')
xlabel('Samples')
ylabel('Amplitude')
%Simplified algorithm to decoder duobinary signaling
yn=output_of_duoB_filter
midSample=length(-4:1/overSampling_Factor:4)/2;
yn_truncated=yn(midSample+3+overSampling_Factor:end); %Remove unwanted portions(first few
%samples till the peak value)
%Now the first sample contains the peak value of the response. From here the samples are extracted
%depending on the oversampling factor
yk = downsample(yn_truncated,overSampling_Factor,1); %here offset=1 means starting from 1st sample
yk=yk(1:length(an));% length output samples must be equal to length of an. Discard the remaining
%The above mentioned process is equivalent to sampling from the time instant nT=T (i.e. n=1)
subplot(2,1,2);
plotHandle=stem(yk);
set(plotHandle,'LineWidth',1.5);
title('Downsampled output (ADC conversion and Sampling)')
xlabel('Samples')
ylabel('Amplitude');
anEstimated = modifiedDuoBinaryDecoder(yk);
disp('Input Symbols to the system : ');disp(an);
disp('Decoded Symbols :');disp(anEstimated);