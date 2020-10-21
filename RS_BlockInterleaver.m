% “ THE_QUICK_BROWN_FOX_JUMPS_OVER_THE_LAZY_DOG_ “. A (255,235) Reed Solomon decoder
% (with correction capability of 10 symbols) is used. We assume that the channel is expected to produce
% a maximum of consecutive 20 symbols of burst error. The burst errors are denoted by ‘ *’ .
%Demonstration of design of Block Interleaver for Reed Solomon Code
clc;
clear;
%____________________________________________
%Input Parameters
%____________________________________________
%Interleaver Design for Reed-Solomon Codes
%RS code parameters
n=255; %RS codeword length
k=235; %Number of data symbols
b=20; %Number of symbols that is expected to be corrupted by the channel
%____________________________________________
p=n-k; %Number of parity symbols
t=p/2; %Error correction capability of RS code
fprintf('Given (%d,%d) Reed Solomon code can correct : %d symbols \n',n,k,fix(t));
fprintf('Given - expected burst error length from the channel : %d symbols \n',b);
disp('________________________________');
if(b>t)
fprintf('Interleaving MAY help in this scenario\n');
else fprintf('Interleaving will NOT help in this scenario\n');
end
disp('_______________________________');
D=ceil (b/t) +1; %Interleaver Depth
memory = zeros(D,n); %constructing block interleaver memory
data='THE_QUICK_BROWN_FOX_JUMPS_OVER_THE_LAZY_DOG_';
% A constant pattern used as a data
%If n>length(data) then repeat the pattern to construct a data of length 'n'
data=char([repmat(data,[1,fix(n/length(data))]),data(1:mod(n,length(data)))]);
% Sending D blocks of similar data
intlvrInput=repmat(data(1:n),[1 D]);
fprintf('Input Data to the Interleaver -> \n');
disp(char(intlvrInput));
disp('________________________________');
%INTERLEAVER
%Writing into the interleaver row-by-row
for index=1:D
memory(index,1:end)=intlvrInput((index-1)*n+1:index*n);
end
intlvrOutput=zeros(1,D*n);
%Reading from the interleaver column-by-column
for index=1:n
intlvrOutput((index-1)*D+1:index*D)=memory(:,index);
end
% Create b symbols error at 25th Symbol location for test in the interleaved output
%'*' means error in this case
intlvrOutput(1,25:24+b)=zeros(1,b)+42;
fprintf('\nInterleaver Output after being corrupted by %d symbol burst error - marked by ''*''->\n',b);
disp(char(intlvrOutput));
disp('______________________________');
%Deinteleaver
deintlvrOutput=zeros(1,D*n);
%Writing into the deinterleaver column-by-column
for index=1:n
memory(:,index)=intlvrOutput((index-1)*D+1:index*D)';
end
%Reading from the deinterleaver row-by-row
for index=1:D
deintlvrOnput((index-1)*n+1:index*n)=memory(index,1:end);
end
fprintf('Deinterleaver Output->\n');
disp(char(deintlvrOnput));
disp('___________________________');