function [X,fitness,FEs] = sbesiege(X,fitness,N,dim,FEs,k,MaxFEs,ub,lb,fobj)
    [~,index]=min(fitness);
    Rabbit_Location=X(index,:);

    E1=(1-(FEs/MaxFEs));
    for i=1:N
        Escaping_Energy=E1*(E0);
        if k==1
          Escaping_Energy=1;
        end
        if abs(Escaping_Energy)>=1
            q=rand();
            rand_Hawk_index = floor(N*rand()+1);
            X_rand = X(rand_Hawk_index,:);
            if q<0.5
                tempX=X_rand-rand()*abs(X_rand-2*rand()*X(i,:));
            elseif q>=0.5
                tempX=(Rabbit_Location(1,:)-mean(X))-rand()*((ub-lb)*rand+lb);
            end
            Flag4ub=tempX>ub;
            Flag4lb=tempX<lb;
            tempX=(tempX.*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
            newFit=fobj(tempX);
            FEs=FEs+1;
            if newFit<fitness(i)
                fitness(i)=newFit;
                X(i,:)=tempX;
            end
        else
            r=rand();
            if r>=0.5 
                Jump_strength=2*(1-rand());
                tempX=(Rabbit_Location-X(i,:))-Escaping_Energy*abs(Jump_strength*Rabbit_Location-X(i,:));
                Flag4ub=tempX>ub;
                Flag4lb=tempX<lb;
                tempX=(tempX.*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
                tempFit=fobj(tempX);
                FEs=FEs+1;
                if tempFit<fitness(i)
                    X(i,:)=tempX;
                    fitness(i)=tempFit;
                end
            else
                Jump_strength=2*(1-rand());
                X1=Rabbit_Location-Escaping_Energy*abs(Jump_strength*Rabbit_Location-X(i,:));
                Flag4ub=X1>ub; 
                Flag4lb=X1<lb;
                X1=(X1.*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
                tempFit1=fobj(X1);
                FEs=FEs+1;
                if tempFit1<fitness(i) 
                    X(i,:)=X1;
                    fitness(i)=tempFit1;
                else 
                    X2=Rabbit_Location-Escaping_Energy*abs(Jump_strength*Rabbit_Location-X(i,:))+rand(1,dim).*Levy(dim);
                    Flag4ub=X2>ub;
                    Flag4lb=X2<lb;
                    X2=(X2.*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
                    tempFit2=fobj(X2);
                    FEs=FEs+1;
                    if tempFit2<fitness(i)
                        X(i,:)=X2;
                        fitness(i)=tempFit2;
                    end
                end
            end
        end
    end
end
function o=Levy(d)
    beta=1.5;
    sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
    u=randn(1,d)*sigma;v=randn(1,d);
    step=u./abs(v).^(1/beta);
    o=step;
end

