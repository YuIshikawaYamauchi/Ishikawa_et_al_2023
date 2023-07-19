function ds = degree_separation( value, class );
%分離度dsの計算

uc = unique( class );
N = length( value );

M = mean( value );

%クラス内分散、クラス間分散の計算
dis1=0.0;%クラス内分散
dis2=0.0;%クラス間分散
for c=1:length(uc)
	id = find( class == uc(c) );
	dis1 = dis1 + var( value(id) ) * length(id)/N;
	dis2 = dis2 + ( mean( value(id) ) - M ).^2 * length(id)/N;
end

ds = dis2 / dis1;

