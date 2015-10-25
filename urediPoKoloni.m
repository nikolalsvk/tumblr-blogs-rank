function H = urediPoKoloni(C)
    [rows, cols] = size(C);
    H = zeros(rows, cols);
    sumCols = sum(C);
    for j = 1:cols
        if(sumCols(j) == 0)
            H(:, j) = 0;
        else
            H(:, j) = C(:,j) / sumCols(j);
    end
end