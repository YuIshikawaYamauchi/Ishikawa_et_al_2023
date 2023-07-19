function ds = degree_separation( value, class );
%�����xds�̌v�Z

uc = unique( class );
N = length( value );

M = mean( value );

%�N���X�����U�A�N���X�ԕ��U�̌v�Z
dis1=0.0;%�N���X�����U
dis2=0.0;%�N���X�ԕ��U
for c=1:length(uc)
	id = find( class == uc(c) );
	dis1 = dis1 + var( value(id) ) * length(id)/N;
	dis2 = dis2 + ( mean( value(id) ) - M ).^2 * length(id)/N;
end

ds = dis2 / dis1;

