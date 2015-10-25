function ro = spectralRadius(A)
    eigenValues = eig(A);
    ro = max(abs(eigenValues));
end