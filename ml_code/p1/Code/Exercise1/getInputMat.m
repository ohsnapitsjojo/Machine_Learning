function X = getInputMat(trainSet,P)
%K is number of sets

vel = trainSet(1:2:end,:);
ang = trainSet(2:2:end,:);

vel = vel' ;
ang = ang' ;

vel = vel(:);
ang = ang(:);

N = size(ang,1);
X= [] ; 

y_tmp=[1];

    for i = 1:N
        v= vel(i);
        w= ang(i);

        for k=1:P
            y_tmp = [y_tmp v^k w^k (v*w)^k];   
        end
        
        X = [X;y_tmp];
        y_tmp=[ 1 ];
    
    end    
end

