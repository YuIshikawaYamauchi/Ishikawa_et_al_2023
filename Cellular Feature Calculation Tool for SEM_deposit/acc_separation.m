function [ th acc ]= acc_separation( value, class )
% �œK臒lth, th�ŕ��������ꍇ�̎��ʐ��xacc�̌v�Z

N=length( class);

vs = sort( value );
acc = 0;
for ii=2:N
	th0 = vs(ii);

	if isnan( th0 ) == 1; continue; end

	id0 = find( value < th0 );
	id1 = find( value >= th0 );

	class2 = class;
	class2(id0) = 0;
	class2(id1) = 1;

	acc0 = 1 - mean( abs( class(:) - class2(:) ));

	if acc < acc0
		acc = acc0;
		th = th0;
	end

	fprintf( 'th0=%f NC1=%3d NC2=%d acc0=%f th=%f acc=%f\n', th0, length(id0), length(id1), acc0, th, acc )
end

th
acc