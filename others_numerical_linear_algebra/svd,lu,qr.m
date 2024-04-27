% Author: Jun-Seop Song (= Euijun Song)

A = hilb(10);
b = rand([10 1]);

% SVD
[U, S, V] = svd(A);
x_svd = V * (S \ (U' * b));
norm_svd = norm(x_svd);

% QR Factorization
[Q, R] = qr(A);
x_qr = R \ (Q' * b);
norm_qr = norm(x_qr);

% LU Decomposition
[L, U] = lu(A);
x_lu = U \ (L \ b);
norm_lu = norm(x_lu);

% Cholesky Decomposition
R = chol(A);
x_cholesky = R \ (R' \ (A' * b));
norm_cholesky = norm(x_cholesky);