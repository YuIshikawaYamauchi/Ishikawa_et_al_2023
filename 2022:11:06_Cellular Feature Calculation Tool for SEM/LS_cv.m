function [ model MAE_t MAE_cv ds_t ds_cv Yt Ycv] = LS_cv( id_cv, x, Y, prm )

model.prm = prm;

if prm.flag_normalize == 1
	[ x_mean x_sd x] = normalizeData( x );
	model.x_mean = x_mean;
	model.x_sd = x_sd;
else
	model.x_mean = mean(x,1);
	model.x_sd = std(x,1);
	%{
	for n=1:size(x,1)
		x(n,:) = x(n,:) - model.x_mean;
	end
	%}
end

N=length(Y);

if 0
	xsd = std(x,1);
	id_add = find( xsd ~= 0 );
	x2 = x(:,id_add);
else
	x2 = x;
end

X=[ ones(N,1) x2 ];

Kcv = max(id_cv);

Ycv = Y;
for k=1:Kcv
	id_valid = find( id_cv == k );
	id_train = find( id_cv ~= k );

	Xt = X(id_train,:);
	Yt = Y(id_train,:);

	b = (Xt'*Xt + prm.lambda*eye(size(Xt,2)) )\ (Xt'*Yt);

	Ycv(id_valid,:) = X(id_valid,:) * b;

end

b2 = (X'*X + prm.lambda*eye(size(X,2)) )\ (X'*Y);
Yt = X * b2;

if 0
	b=zeros( [ size(x,2)+1 1] );
	b([ 1 id_add],1) = b2;
else
	b = b2;
end

%{
sx = size(x)
sadd = size( id_add )
sb2 = size(b2)
pause
%}


%回帰の予測結果の分離度
ds_cv = degree_separation( Ycv, Y );
ds_t = degree_separation( Yt, Y );

if 1
	%クラスごとのMAEの平均
	uc = unique(Y);
	MAE_cv = zeros( [ length(uc) 1 ] );
	MAE_t  = zeros( [ length(uc) 1 ] );
	for c=1:length(uc)
		id = find( Y == uc(c) );
		MAE_cv(c) = mean( abs( Ycv(id) - Y(id) ) );
		MAE_t(c) = mean( abs( Yt(id) - Y(id) ) );
		%MAE_cv(c) = sqrt( mean( abs( Ycv(id) - Y(id) ).^2 ));
		%MAE_t(c) = sqrt( mean( abs( Yt(id) - Y(id) ).^2 ));
	end
	MAE_cv = mean( MAE_cv );
	MAE_t = mean( MAE_t );
else
	MAE_cv = mean( abs( Ycv - Y ) );
	MAE_t = mean( abs( Yt - Y ) );
end

model.b = b;
