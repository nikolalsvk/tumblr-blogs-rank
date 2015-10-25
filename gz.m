function [x, flag, it] = gz(A, b, x0, itMax, errMax)
% Gaus Zajdelov postupak za resavanje sistema 
% linearnih algebarskih jednacina
%   A ulazna matrica
%   b ulazni vektor
%   x0 pocetno resenje
%   itMax maksimalan broj iteracija
%   errMax maksimalna greska
%   x rezultat
%   flag = 0 sve je u redu
%   flag = 1 greska
    flag = 1;
    
    [n, c] = size(A);    
    if(n~=c)        
        return;
    end
    
    x = zeros(n,1);
    for it = 1:itMax
        for i=1:n
            s = 0;
            for j=1:i-1
                s = s + A(i,j)*x(j);
            end
            for j =i+1:n
                s = s + A(i,j)*x0(j);
            end
            x(i) = (b(i)-s)/A(i,i);
        end
        err = 0;
        for i=1:n
            err = err+(x(i)-x0(i))^2;
        end
        if (err<errMax^2)
            flag = 0;
            return;
        end
        for i=1:n
            x0(i) = x(i);
        end
    end
end
        
        
        
        
        
        
        
        
            
            
            
            
            
            
            
            