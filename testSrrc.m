% Define oversampling factor (to simulated digital to analog conversion in the transmitter), input bits to
% be transmitted and the impulse response of the desired SRRC filter (as shown in the equation/function
% above).
% The SRRC filter’s impulse response is computed for t=-4T to 4T duration. This duration can be
% changed to any appropriate desired value.
clc;clear;close all;
overSampling_Factor=8;
%Input_bit = 1; %Bits to be transmitted
Input_bit = [1 -1 1 -1 1 1 -1 -1 -1 1 -1 1 1 1];
Input_bit_os=upsample(Input_bit,overSampling_Factor); %oversampling
alpha=0.1; % roll-off factor of Root Raised Cosine Filter
pt = srrc(overSampling_Factor,alpha); % impulse response of SRRC filter
% Convolve the impulse response of the root raised cosine filter with the oversampled version of input
% bits and plot the resulting response. This is the response of the filter for the input bits at the
% transmitter side.
output_of_srrc_filter = conv(Input_bit_os,pt);
figure;
stem(output_of_srrc_filter);
title('Response of SRRC Filter at Tx side')
xlabel('Samples')
ylabel('Amplitude')
%Receiver side; using a matched filter (that is matched to the SRRC pulse in the transmitter)
y = conv(output_of_srrc_filter,pt);
figure;
stem(y);
title('Matched filter (SRRC) response at Rx side');
xlabel('Samples');
ylabel('Amplitude');
midSample=length(-4:1/overSampling_Factor:4);
y_truncated=y(midSample-1:end); %Remove unwanted portions(first few samples till the peak value)
%Now the first sample contains the peak value of the response. From here the samples are extracted
% depending on the oversampling factor
y_down = downsample(y_truncated,overSampling_Factor,1); %here offset=1 means starting from 1st sample %retain every 8th sample
figure;
stem(y_down);
title('Down sampled output (ADC conversion and Sampling)');
xlabel('Samples');
ylabel('Amplitude');