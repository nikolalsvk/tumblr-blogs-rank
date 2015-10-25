function [Rgz, Rj] = racunajPageRank(G, ocene)
    H = urediPoKoloni(G);
    d = 0.85;

    rows = size(G, 1);
    I = eye(rows);
    
    % normalizacija vektora personalizacije
    ocene_norm = ocene / norm(ocene, 1);
    p = ocene_norm *(1-d);

    A = I - d*H;
    
%     [L, D, U] = makeLDU(A);
%     Tgz = ( -(D+L) )^(-1) * U;
%     Tj = (-D)^(-1)*(L+U);
%     
%     disp('b) Jakobi konvergira po spektralnom radijusu: ')
%     spectralRadius_J = spectralRadius(Tj)
%     if spectralRadius_J < 1
%         disp('da')
%     else
%         disp('ne')
%     end
% 
%     disp('b) GZ konvergira po spektralnom radijusu: ')
%     spectralRadius_GZ = spectralRadius(Tgz)
%     if spectralRadius_GZ < 1
%         disp('da')
%     else
%         disp('ne')
%     end
    
    b = p;
    x0 = zeros(rows, 1);
    itMax = 100000;
    errMax = 0.000001;
    
    Rgz = gz(A, b, x0, itMax, errMax);
    Rj = jakobi(A, b, x0, itMax, errMax);
end

