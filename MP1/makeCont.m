function contVal = makeCont(data)
[lgth,l1] = size(data);
lastTimeStamp = data(lgth, 1);
contVal = (1:lastTimeStamp)';

n = 1;
i = 1;
while and(n <= lgth-1, i<=lastTimeStamp)
  
   while contVal(i,1) < data(n+1,1)
       for xyz = 2:4
           contVal(i,2)=data(n,2);
       end
       i=i+1;
   end
   n = n+1;    
end
for xyz = 2:4
    contVal(lastTimeStamp,2)=data(n,2);
end

end