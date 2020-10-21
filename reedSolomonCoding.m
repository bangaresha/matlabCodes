%Matlab Code for RS coding and decoding
n=7; k=3; % Codeword and message word lengths
m=3; % Number of bits per symbol
msg = gf([5 2 3; 0 1 7;3 6 1],m) % Three k-symbol message words
% message vector is defined over a Galois field where the number must
%range from 0 to 2^m-1
codedMessage = rsenc(msg,n,k)% Encoding the message vector using RS coding
dmin=n-k+1 % display dmin
t=(dmin-1)/2 % diplay error correcting capability of the code
% Generate noise - Add 2 contiguous symbol errors with first word;
% 2 symbol errors with second word and 3 distributed symbol
% errors to last word
noise=gf([0 0 0 2 3 0 0 ;6 0 1 0 0 0 0 ;5 0 6 0 0 4 0],m)
received = noise+codedMessage
%decoded contains the decoded message and cnumerr contains the number of
%symbols errors corrected for each row. Also if cnumerr(i) = -1 it indicates that the ith row contains
%unrecoverable error
[decoded,cnumerr] = rsdec(received,n,k)

codedMessage2 = [msg 0 0 0 0];
received2 = noise+codedMessage2
[decoded2, cnumerr2] = rsdec(received2,n,k)