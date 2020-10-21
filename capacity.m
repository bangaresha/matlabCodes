% Calculates the Discrete-input Continuous-output Memoryless Channel (DCMC) capacity of AWGN and uncorrelated Rayleigh fading channels for BPSK, QPSK, 8PSK and 16QAM.
% Rob Maunder 08/08/2008

% Copyright © 2008 Robert G. Maunder. This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.


% +---------------------------------------------+
% | Choose the SNR, modulation and channel here |
% +---------------------------------------------+

% Affects the accuracy and duration of the simulation
symbol_count = 1000000;

% Channel SNR
% snr = 7; % dB
snr = -10:5:30; % dB

% Modulation scheme
% -----------------

% 2PSK
%modulation = [+1, -1];

% 4PSK
%modulation = [+1, +i, -1, -i];

% 8PSK
%modulation = [+1, sqrt(1/2)*(+1+i), +i, sqrt(1/2)*(-1+i), -1, sqrt(1/2)*(-1-i), -i, sqrt(1/2)*(+1-i)];

% 16QAM
modulation = sqrt(1/10)*[-3+3*1i, -1+3*1i, +1+3*1i, +3+3*1i, -3+1*1i, -1+1*1i, +1+1*1i, +3+1*1i, -3-1*1i, -1-1*1i, +1-1*1i, +3-1*1i, -3-3*1i, -1-3*1i, +1-3*1i, +3-3*1i];

% If you add more modulation schemes here, make sure their average transmit power is normalised to unity
% Channel
% -------
channel = sqrt(1/2)*(randn(1,symbol_count)+1i*randn(1,symbol_count));   % Uncorrelated Rayleigh fading channel % AWGN channel
%channel = ones(1,symbol_count);

% +------------------------+
% | Simulation starts here |
% +------------------------+
symbols = ceil(length(modulation)*rand(1,symbol_count));    % Generate some random symbols
tx = modulation(symbols);       % Generate the transmitted signal
channel_capacity=[];
channel_capacity=0;
channel_capacity2=0;
for snrTemp = 1:1:length(snr)
    for itr=1:1:10
        N0 = 1/(10^(snr(snrTemp)/10));       % Generate some noise
        noise = sqrt(N0/2)*(randn(1,symbol_count)+1i*randn(1,symbol_count));
        rx = tx.*channel+noise;         % Generate the received signal
        probabilities = max(exp(-(abs(ones(length(modulation),1)*rx - modulation.'*channel).^2)/N0),realmin);       % Calculate the symbol probabilities
        probabilities = probabilities ./ (ones(length(modulation),1)*sum(probabilities));       % Normalise the symbol probabilities
        channel_capacity2 = channel_capacity2 + log2(length(modulation))+mean(sum(probabilities.*log2(probabilities)));      % Calculate the capacity
    end
    channel_capacity2=channel_capacity2/10;
    channel_capacity = [channel_capacity channel_capacity2];      % Calculate the capacity
end

plot(snr,channel_capacity(1:9));
% Display the capacity
disp(['The channel capacity is ', num2str(channel_capacity), ' bits per channel use']);



