function an = modifiedDuoBinaryDecoder(yk)
%Decoding duobinary signal
an=zeros(1,length(yk));
    for i=1:length(yk)
        if abs(yk(i))>1 
            an(i)=1;
        elseif abs(yk(i))<1 
            an(i)=0;
        else
            an(i)=randn(1,1)<=0.5;
        end
    end
end