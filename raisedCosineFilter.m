%Raised Cosine Filter
L=41; %Filter Length
R=1E6; %Data Rate = 1Mbps
Fs=8*R; %Oversampling by 8
T=1/R;
Ts=1/Fs;
alpha =0.5; % Design Factor for Raised Cosing Filter
%----------------------------------------------------------
%Raised Cosing Filter Design
%----------------------------------------------------------
if mod(L,2)==0
M=L/2 ; % for even value of L
else
M=(L-1)/2; % for odd value of L
end
g=zeros(1,L); %Place holder for RC filter's transfer function
for n=-M:M
num=sin(pi*n*Ts/T)*cos(alpha*pi*n*Ts/T);
den=(pi*n*Ts/T)*(1-(2*alpha*n*Ts/T)^2);
g(n+M+1)=num/den;
    if (1-(2*alpha*n*Ts/T)^2)==0
        g(n+M+1)=pi/4*sin(pi*n*Ts/T)/(pi*n*Ts/T);
    end
    if n==0
        g(n+M+1)=cos(alpha*pi*n*Ts/T)/(1-(2*alpha*n*Ts/T)^2);
    end
end
%----------------------------------------------------------
% Plot the transfer function of RC filter
figure;
impz(g,1);
%----------------------------------------------------------
%Generate data of random 1s and 0s
data=2*(rand(1,1000)>=0.5)-1; %Polar encoding : 1= +1V, 0=-1V
output=upsample(data,Fs/R);
%y=conv(g,output); %Convolving the data signal with the Raised Cosine Filter
y=filter(g,1,output); %you can use either Conv function or filter function to obtain the output
%----------------------------------------------------------
%Plot data and RC filtered Output
figure;
subplot(2,1,1);
stem(data);
title('Input data to the Raised Cosine Filter');
xlabel('Samples');
ylabel('Amplitude');
axis([0,20,-1.5,1.5])
subplot(2,1,2);
plot(y);
axis([0,160,-1.5,1.5])
title('Response of the Raised Cosine Filter for the given Input');
xlabel('Samples');
ylabel('Amplitude');
% Obtain FFT of the output to plot its frequency response.
Fn=Fs/2;
NFFY=2.^(ceil(log(length(y))/log(2)));
FFTY=fft(y,NFFY);%pad with zeros
NumUniquePts=ceil((NFFY+1)/2);
FFTY=FFTY(1:NumUniquePts);
MY=abs(FFTY);
MY=MY*2;
MY(1)=MY(1)/2;
MY(length(MY))=MY(length(MY))/2;
MY=MY/length(y);
f1=(0:NumUniquePts-1)*2*Fn/NFFY;
%Plot Frequency spectrum
figure;
plot(f1,20*log10(abs(MY).^2));xlabel('FREQUENCY(Hz)');ylabel('DB');
grid
title('Frequency domain plots')
