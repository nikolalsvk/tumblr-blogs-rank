function [x, flag, it] = jakobi(A, b, x0, itMax, errMax)
    [n,c]= size(A);
    if(n ~= c)
        flag = 1;
        return;
    end
    x = zeros(n,1);
    for it = 1:itMax
        % pocetak iteracije
        err = 0;
        for i = 1:n
            s = 0;
            for j = 1:i-1
                s = s + A(i,j)*x0(j);
            end
            for j = i+1:n
                s = s + A(i,j)*x0(j);
            end
            % racunanje nove vrednosti resenja
            x(i) = (b(i)-s)/A(i,i);
            % sumiranje greske
            err = err+(x(i)-x0(i))^2;
        end
        % postavi da nova izracunata resenja budu pocetna, kako bi se ona
        % koristila u sledecoj iteraciji
		for i = 1:n
            x0(i) = x(i);
        end
        % provera da li je greska manja od zadate
        % ako jeste, ispisi broj iteracije u kojoj se to desilo
        if(err < errMax^2)
            flag = 0;
            return;
        end
    end
end