function A = normalizeData0( A, A_mean, A_sd )

	for n=1:size(A,1)
		A(n,:) = A(n,:) - A_mean;
		for d=1:size(A,2)
			if A_sd(d) ~= 0
				A(n,d) = A(n,d) / A_sd(d);
			end
		end
	end
