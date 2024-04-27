% Author: Jun-Seop Song (= Euijun Song)

function song_method()
p = [1 5 3 7 6 8 1 3 7] 
n = 8; 

dp = polyder(p) 

R=p(2);
for k=3:(n+1)
    if abs(p(k))^(1/(k-1)) > R
        R = abs(p(k))^(1/(k-1));
    end
end
R = R*2;


for k=1:n
    z(k) = -p(2)/n + R*exp(1i*3.1415926535897932384626433832795/n*(2*k-3/2));
end
num=0
z

NN=60;
for num=1:NN 
    for k=1:n
        w(k)=polyval(p,z(k));
        for j=1:(k-1)
            w(k)=w(k) / (z(k) - z(j));
        end
        for j=(k+1):n
            w(k)=w(k) / (z(k) - z(j));
        end
    end
    
    for k=1:n
        aa(k)=0;
        for j=1:(k-1)
            aa(k)=aa(k) + (w(j) / (z(k) - z(j)));
        end
        for j=(k+1):n
            aa(k)=aa(k) + (w(j) / (z(k) - z(j)));
        end
    end
    
    for k=1:n
        %z(k) = z(k) - 2*polyval(p,z(k)) / (polyval(dp,z(k)) + polyval(dp,z(k)-w(k))) %method(1)
        %z(k) = z(k) - 2*polyval(p,z(k)) / (polyval(dp, z(k))+polyval( dp, z(k)-w(k)/(1-polyval(p,z(k)-w(k))/polyval(p,z(k))))); %method(2)
        %z(k) = z(k) - polyval(p,z(k)) / polyval( dp, z(k)-(w(k)/2)/( 1-polyval(p,z(k)-w(k))/polyval(p,z(k)))); %method(3)
        %z(k) = z(k)-w(k)/( 1-polyval(p,z(k)-w(k))/polyval(p,z(k))) %petkovic1(The derivative-free method)
        %z(k) = z(k) - polyval(p,z(k)) / (polyval(dp, z(k)-w(k)/2)) %petkovic2(2009, midpoint)
        %z(k) = z(k) - w(k) % Durand-Kerner
        z(k) = z(k) - w(k) / (1+aa(k)) % Borsch-Supan method
    end
    
    num, z
    mm=abs(polyval(p,z(1)));
    for k=2:n
        if mm < abs(polyval(p, z(k)))
            mm = abs(polyval(p, z(k)));
        end
    end
    if mm < (1e-10) 
        break;
    end
end
num
mm

end