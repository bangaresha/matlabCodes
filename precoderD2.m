function bn=precoderD2(an)
%an=binary input bits to precoder
bn=zeros(1,length(an));
    for i=1:length(an);
        if i==1 
            bn(i)=xor(an(i),1);
        elseif i==2 
            bn(i)=xor(an(i),1);
        else
            bn(i)=xor(an(i),bn(i-2));
        end
    end
bn=[1 1 bn];
end