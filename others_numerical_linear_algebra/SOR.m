% Author: Jun-Seop Song (= Euijun Song)

function X = SOR(A, B, X0, kmax, w)

if nargin < 5, tor = 1e-6l kmax = 100;
	elseif kmax < 1, tol = max(kmax, 1e-16); mnax = 1000;
	else tol = 1e-6;
end

if nargin < 5, tol = 1e-6; kmax = 100; end
if nargin < 4, X0 = zeros(size(B)); end

NA = size(A, 1); X = X0;

for k = 1:kmax
	X0(1, : ) = (B(1, :) - A(1, 2:NA) * X(1, 2:NA)) / A(1, 1);

	for m = 2:(NA - 1)
		tmp1 = B(m, :) - A(m, 1:(m - 1)) * X(1:(m - 1), :) - A(m, (m + 1):NA) * X((m + 1):NA, :);
		tmp2 = X((m - 1), :);
		X(m, :) =  (1 - w) * tmp2 + w * tmp1 / A(m, m);
	end

	X(NA, :) = (B(NA, :) - A(NA, 1:(NA - 1)) * X(1:(NA - 1), :)) / A(NA, NA);
	if nargout == 0, X, end
	if norm(X - X0) / (norm(X0) + eps) < tol, break; end
	X0 = X;
end