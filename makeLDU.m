function [L,D,U] = makeLDU(A)
    [rows,cols] = size(A);
    
    L = zeros(rows,rows);
    D = zeros(rows,rows);
    U = zeros(rows,rows);
    for i = 1 : rows
        for j = 1 : rows
            if i==j
                D(i,j) = A(i,j);
            elseif i<j
                L(i,j) = A(i,j);
            else
                U(i,j) = A(i,j);
            end
        end
    end
    
% alternativno:    
%     D = eye(rows) .* A;
%     L = zeros(rows,cols);
%     U = zeros(rows,cols);
%     
%     for i=1:rows
%         for j=i+1:cols % prolazimo samo deo matrice iznad dijagonale
%            U(i,j) = A(i,j);
%            L(j,i) = A(j,i);
%         end
%     end
end