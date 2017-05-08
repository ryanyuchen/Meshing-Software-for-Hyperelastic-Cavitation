clear
clc

r=1.6383;

for i=1:36;
    r2(i)=r*(pi/60*2+1)^i*1.05^(i-1);
end

r2'

x=1:36;
plot(x,r2)