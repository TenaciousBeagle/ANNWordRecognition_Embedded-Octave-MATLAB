%All variables required to run the testing part of the program are declared
%and assigned values below:
% Workspace saved after training.This will load all values saved during
% training in current workspace for the testing program to use
load(%Enter Workspace Name Here%)
%Testing portion starts here
for m=900+1:size(wineInputs2,2)
    otpt(:,1)=inpt(:,1);
    for i=2:n
        for j=1:layer(i)
            inpt(j,i)=0;
            for k=1:layer(i-1)
                inpt(j,i)=inpt(j,i)+weight(k,j,i-1)*otpt(k,i-1);
            end
            inpt(j,i)=inpt(j,i)+bias(j,i-1);
            otpt(j,i)=(inpt(j,i)/900)*exp(-((inpt(j,i)/900)^2)/2)/val; %Gaussian Wavelet Activation Func
        end
    end
    testotpt(:,m-900)=otpt(1:layer(n),n);
end
ans=-1*ones(layer(n),size(wineInputs2,2)-900);
storepers=0;storeprevpers=0;
for i=1:size(testotpt,2)
    max=testotpt(1,i);
    posi=1;
    for j=2:size(testotpt,1)
        if(max<testotpt(j,i))
            max=testotpt(j,i);
            posi=j;
        end
    end
    ans(posi,i)=1;
    if(wineTargets2(posi,900+i)==1)
        storepers=storepers+1;
    end
end
storepers=storepers/size(testotpt,2);
disp(storepers);
if(storeprevpers<storepers)
    storeprevpers=storepers;
    storeweight=weight;
    storebias=bias;
    storeiter=iter;
end
%plotconfusion(wineTargets2(:,900+1:size(wineInputs2,2)),ans);

