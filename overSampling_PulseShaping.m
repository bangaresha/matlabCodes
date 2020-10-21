overSampling_Factor=4;
Input_bit = [1 0 1];
Input_bit_os=upsample(Input_bit,overSampling_Factor); %oversampling by 4
%this is equivalent to performing digital to analog conversion in Tx side
%normalizing the pulse shape to have unit energy
pt = [ones(1,overSampling_Factor) 0 0 0 0 0 0]/sqrt(overSampling_Factor);
% impulse response of a rectangular pulse
%convolving the oversampled input with rectangular pulse
%The output of the convolution operation will be in the transmitter side
output_of_rect_filter = conv(Input_bit_os,pt);
stem(output_of_rect_filter);
title('Output of Rectangular Filter at Tx side')
xlabel('Samples')
ylabel('Amplitude')