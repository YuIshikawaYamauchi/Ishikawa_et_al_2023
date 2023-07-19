function [ A_mean A_sd A] = normalizeData( A )

	A_mean = mean(A,1);
	A_sd   = std(A,1);

	A = normalizeData0( A, A_mean, A_sd );
%{
	for n=1:size(A,1)
		A(n,:) = A(n,:) - A_mean;
		for d=1:size(A,2)
			if A_sd(d) ~= 0
				A(n,d) = A(n,d) / A_sd(d);
			end
		end
	end
%}