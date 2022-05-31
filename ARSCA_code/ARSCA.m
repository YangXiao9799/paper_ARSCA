function [Destination_position,Convergence_curve]=ARSCA(N,Max_iteration,lb,ub,dim,fobj)
tic
%Initialize the set of random solutions
X=initialization(N,dim,ub,lb);

Destination_position=zeros(1,dim);
Destination_fitness=inf;

Convergence_curve=[];
Objective_values = zeros(1,size(X,1));

FEs=0;
it=1;
% Calculate the fitness of the first set and find the best one
for i=1:size(X,1)
    FEs = FEs+1;
    Objective_values(1,i)=fobj(X(i,:));
    if i==1
        Destination_position=X(i,:);
        Destination_fitness=Objective_values(1,i);
    elseif Objective_values(1,i)<Destination_fitness
        Destination_position=X(i,:);
        Destination_fitness=Objective_values(1,i);
    end
    Convergence_curve(it)=Destination_fitness;
end

%Main loop
it=it+1; % start from the second iteration since the first iteration was dedicated to calculating the fitness
while FEs<Max_iteration
    
    % Eq. (3.4)
    a = 2;
    %     Max_iteration = Max_iteration;
    r1=a-FEs*((a)/Max_iteration); % r1 decreases linearly from a to 0
    
    % Update the position of solutions with respect to destination
    for i=1:size(X,1) % in i-th solution
        for j=1:size(X,2) % in j-th dimension
            
            % Update r2, r3, and r4 for Eq. (3.3)
            r2=(2*pi)*rand();
            r3=2*rand;
            r4=rand();
            
            % Eq. (3.3)
            if r4<0.5
                % Eq. (3.1)
                X(i,j)= X(i,j)+(r1*sin(r2)*abs(r3*Destination_position(j)-X(i,j)));
            else
                % Eq. (3.2)
                X(i,j)= X(i,j)+(r1*cos(r2)*abs(r3*Destination_position(j)-X(i,j)));
            end

        end
        
    end
    for i=1:size(X,1)
        
        % Check if solutions go outside the search spaceand bring them back
        Flag4ub=X(i,:)>ub;
        Flag4lb=X(i,:)<lb;
        X(i,:)=(X(i,:).*(~(Flag4ub+Flag4lb)))+ub.*Flag4ub+lb.*Flag4lb;
        
        % Calculate the objective values
        FEs = FEs+1;
        Objective_values(1,i)=fobj(X(i,:));
        
        % Update the destination if there is a better solution
        if Objective_values(1,i)<Destination_fitness
            Destination_position=X(i,:);
            Destination_fitness=Objective_values(1,i);
        end
    end
    %% enhanced
        %% sort
        [Objective_values,SortOrder]=sort(Objective_values);
        for i=1:N
            X(i,:)=X(SortOrder(i),:);
        end
    %% enhanced end
    wMax=0.7;
    wMin=0.2;
    w=wMax-FEs*((wMax-wMin)/Max_iteration);
    nAda=floor(N*w);
    X_ada=zeros(N,dim);
    X_mean=mean(X);
    fit_mean=fobj(X_mean);
    FEs=FEs+1;
    %% SQI
    for i=1:N
        [k1,k2] = GetRan2(i,nAda);
        k4=1;
        for j=1:dim
            if rand>0.4
                X_ada(i,j)=0.5*(((X(i,j)^2-X(k1,j)^2)*Objective_values(1,k2)+(X(k1,j)^2-X(k2,j)^2)*Objective_values(1,i)+(X(k2,j)^2-X(i,j)^2)*Objective_values(1,k1))/((X(i,j)-X(k1,j))*Objective_values(1,k2)+(X(k1,j)-X(k2,j))*Objective_values(1,i)+(X(k2,j)-X(i,j))*Objective_values(1,k1))); 
            else
                X_ada(i,j)=0.5*(((X(i,j)^2-X_mean(1,j)^2)*Objective_values(1,k4)+(X_mean(1,j)^2-X(k4,j)^2)*Objective_values(1,i)+(X(k4,j)^2-X(i,j)^2)*fit_mean)/((X(i,j)-X_mean(1,j))*Objective_values(1,k4)+(X_mean(1,j)-X(k4,j))*Objective_values(1,i)+(X(k4,j)-X(i,j))*fit_mean)); 
            end
        	
            
            if X_ada(i,j)>ub
                X_ada(i,j)=ub+rand*(ub-lb);
            elseif X_ada(i,j)<lb
                X_ada(i,j)=ub-rand*(ub-lb);
            end
        end
        fit_ada(i)=fobj(X_ada(i,:));
        FEs=FEs+1;
        if fit_ada(i)<Objective_values(1,i)
        	Objective_values(1,i)=fit_ada(i);
            X(i,:)=X_ada(i,:);
            if Objective_values(1,i)<Destination_fitness
                Destination_position=X(i,:);
                Destination_fitness=Objective_values(1,i);
            end
        end
    end
    %% SQI end
    for i=1:N
        X_new(i,:)=X(i,:);
        fitness(i)=Objective_values(1,i);
    end
    [X_new,fitness,FEs] = RM(X_new,fitness,N,dim,FEs,it,Max_iteration,ub,lb,fobj);
    
    for i=1:N
        if fitness(i)<Objective_values(1,i)
            X(i,:)=X_new(i,:);
            Objective_values(1,i)=fitness(i);
            if Objective_values(1,i)<Destination_fitness
                Destination_position=X(i,:);
                Destination_fitness=Objective_values(1,i);
            end
        end
    end
    Convergence_curve(it)=Destination_fitness;
    it=it+1;
end
toc
end
