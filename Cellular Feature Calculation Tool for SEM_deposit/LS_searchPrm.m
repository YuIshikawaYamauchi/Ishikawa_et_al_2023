function [ Yt_best Ycv_best model_best MAE_best ds_max id_select_best ] = LS_searchPrm( x, Y, prm )

%{
最小二乗法で分離度を最大にする変数選択を行う。

%}

fp = fopen( 'log_LS_searchPrm.txt', 'wt' );

N=length(Y);
Kcv = 10;

%id_cv = floor( rand( 1, N ) * Kcv * 0.9999 )+1;
id_cv = 1:N;

[ model MAE_t MAE_cv ds_t ds_cv Yt Ycv] = LS_cv( id_cv, x, Y, prm.LS );

fprintf( fp, '全変数,%d,MAE,%fds,%f\n', size(x,2), MAE_cv, ds_cv );

MAE_best = MAE_cv;
ds_max = ds_cv;
Yt_best = Yt;
Ycv_best = Ycv;
id_select = 1:size(x,2);
id_select_best = id_select;
model_best = model;
while(1)

	lid = length( id_select );
	if lid == 1; break; end

	ds_max_tmp = 0;
	MAE_best_tmp = 1e+10;
	for ii=1:length( id_select )
		id_select2 = id_select;
		id_select2(ii) = [];
		[ model MAE_t MAE_cv ds_t ds_cv Yt Ycv] = LS_cv( id_cv, x(:,id_select2), Y, prm.LS );

		fprintf( fp, 'MAE, %f, ds, %f, id_select2,', MAE_cv, ds_cv )

		%{
		sid = size( id_select2 )
		sb = size( model.b )
		pause
		%}

		for jj=1:length( id_select2 )
			fprintf( fp, '%3d,', id_select2(jj))
		end
		fprintf( fp, '\n')

		%if ds_max < ds
		if MAE_best > MAE_cv
			MAE_best = MAE_cv;
			ds_max = ds_cv;
			id_select_best = id_select2;
			model_best = model;
			model_best.id_select = id_select2;
			Yt_best = Yt;
			Ycv_best = Ycv;
		end

		%if ds_max_tmp < ds_cv
		%	ds_max_tmp = ds;
		if MAE_best_tmp > MAE_cv
			MAE_best_tmp = MAE_cv;
			id_select_best_tmp = id_select2;
		end
	end

	id_select = id_select_best_tmp;

end


fprintf( fp, '\nBest Result:\n')
fprintf( fp, 'MAE, %f, ds, %f, id_select_best,', MAE_best, ds_max )
for jj=1:length( id_select_best )
	fprintf( fp, '%3d,', id_select_best(jj))
end
fprintf( fp, '\n')


fclose(fp)


