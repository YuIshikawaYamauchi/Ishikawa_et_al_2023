clear all
close all

addpath('lib')
addpath('lib\libsvm-3.16\matlab')
%addpath('SaliencyToolbox')

prm.offset.x(1)			= 0;
prm.offset.x(2)			= 0;
prm.offset.y(1)			= 0;
prm.offset.y(2)			= 90;

indir = 'C:\tnagata\�}�g��w\�ΐ삳��\data\���q�摜���_�ΐ�\rawdata';


[flist, d] = dir_recursive( indir );

data=[];
class = [];
for i1 = 1:length( flist )
	[filepath,name,ext] = fileparts(flist(i1).path);
	if strcmp( ext, '.tif') == 1
		data(end+1).filename = flist(i1).path;
		if length( strfind( name, 'A' ) ) > 0
			class(end+1) = 1; %Adult
		else
			class(end+1) = 0; %Young
		end
	end
end


fp = fopen( 'result.csv', 'wt');

num_feature = 0;
result_all = [];
result_add = [];
%%%%%%%%%%%%%%%%%%%%%%%%%% �t���N�^������ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1
num_feature = num_feature + 1;

fprintf(fp, 'FractalDimension\n')
fprintf(fp, 'SmoothingRate,Distance,epsilon,window,Degree Separation\n')
fprintf(    'FractalDimension\n')
fprintf(    'SmoothingRate,Distance,epsilon,window,Degree Separation\n')
ds_max = 0;
result = [];
fig = figure( 'Position', [ 100 100 900 600] )
for SmoothingRate = 0.025; %[ 0:0.025:0.075]
for Distance = 1 %[ 0 1 2 ]
for epsilon  = 5 %3:2:7
for window = 20 %15:5:25

	prm.kind_feature		= 0; %�����ʂ̎�� 0:�t���N�^������
	prm.bilatfilt.SmoothingRate	= SmoothingRate;
	prm.bilatfilt.Distance 		= Distance;
	prm.fd.epsilon			= epsilon;
	prm.fd.window			= window;
	prm.edges			= [1:0.2:3];

	for i1 = 1:length( data )
		img = imread( data(i1).filename );
		[ result(i1,:) img_gray img_gray2 ] = cell_analize( img, prm );
	end

	%�����xds�̌v�Z
	%result2 = result(:,1);
	result2 = sum(result(:,1:end/2),2);
	ds = degree_separation( result2, class );

	fprintf(fp, '%f,%f,%f,%f,%f\n', SmoothingRate, Distance, epsilon, window, ds);
	fprintf(    '%f,%f,%f,%f,%f\n', SmoothingRate, Distance, epsilon, window, ds);

	prmstr = sprintf('SRate=%f Dist=%f eps=%f w=%f DS=%f', SmoothingRate, Distance, epsilon, window, ds );

	if ds_max < ds
		ds_max = ds;
		prm_best = prm;
		result_best = result;
		cla
		plot( class, result2, '+b' );
		xlabel('class (0:young 1:adult)');
		ylabel('�t���N�^������');
		title( [ '�t���N�^�������v�Z���� (' prmstr ')' ] );
		xlim([ -1 2 ] );
		grid on
		saveas( fig, 'result_fd.png')
		pause(0.1);
	end


end
end
end
end

result_add(end+1).data = result_best;

fprintf(fp, '\nBest\n');
fprintf(fp, '%f,%f,%f,%f,%f\n', prm_best.bilatfilt.SmoothingRate, prm_best.bilatfilt.Distance, prm_best.fd.epsilon, prm_best.fd.window, ds_max)

fprintf( '\nBest\n');
fprintf( '%f,%f,%f,%f,%f\n', prm_best.bilatfilt.SmoothingRate, prm_best.bilatfilt.Distance, prm_best.fd.epsilon, prm_best.fd.window, ds_max)

end

%%%%%%%%%%%%%%%%%%%%%%%%%% ���̐� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1

num_feature = num_feature + 1;
fprintf(fp, 'Num of Holes\n')
fprintf(fp, 'SmoothingRate,Distance,Sensitivity,area_min,Degree Separation\n')
fprintf( 'Num of Holes\n')
fprintf( 'SmoothingRate,Distance,Sensitivity,area_min,Degree Separation\n')
ds_max = 0;
fig = figure( 'Position', [ 100 100 900 600] )
for SmoothingRate = 0.05 %0.05:0.05:0.2 %0.1 %0.05:0.05:0.2 %[ 0:0.025:0.075]
for Distance = 4 %2:4 %[ 0 1 2 ]
for Sensitivity  =  0.5 %0.375:0.125:0.625 %0.25:0.25:0.75 %0.875 %0.865:0.01:0.885 %0.85:0.025:0.9 %0.625:0.125:0.875
for area_min = 100 %[ 50:50:150 ] %[ 100 1000 2500 ] %50 %25:25:75 %100:100:500 %1000:250:1500 %1500:250:2000 %1750:750:3250

	prm.kind_feature		= 1; %�����ʂ̎�� 1:���̐�
	prm.bilatfilt.SmoothingRate	= SmoothingRate;
	prm.bilatfilt.Distance 		= Distance;
	prm.Sensitivity			= Sensitivity;
	prm.area_min			= area_min;
	prm.edges			= [ 0:50:150 1000 1e+10];

%rdata = [ rdata(:,1:3) sum( rdata(:,4:8),2) sum( rdata(:,9:end),2) ];%best2
%		edges = [ 0:50:200 400:200:1000 2000 1e+10];

	result = [];
	for i1 = 1:length( data )
		img = imread( data(i1).filename );
		[ result(i1,:) img_gray img_gray2 ] = cell_analize( img, prm );
	end
	%result_all(:,end+1:end+size(result,2)) = result;

	%�����xds�̌v�Z
	%result2 = result;
	result2 = sum( result(:,2:end), 2 );
	ds = degree_separation( result2, class );

	fprintf(fp, '%f,%f,%f,%f,%f\n', SmoothingRate, Distance, Sensitivity, area_min, ds);
	fprintf( '%f,%f,%f,%f,%f\n', SmoothingRate, Distance, Sensitivity, area_min, ds);

	prmstr = sprintf('SRate=%f Dist=%d Sensitivity=%f areaMin=%d DS=%f', SmoothingRate, Distance, Sensitivity, area_min, ds );

	if ds_max < ds
		ds_max = ds;
		prm_best = prm;
		result_best = result;
		cla
		plot( class, result2, '+b' );
		xlabel('class (0:young 1:adult)');
		ylabel('��E��');
		title( [ '��E�� (' prmstr ')' ] );
		xlim([ -1 2 ] );
		grid on
		saveas( fig, 'result_num_holes.png')
		pause(0.1);
	end


end
end
end
end

result_add(end+1).data = result_best;



fprintf(fp, '\nBest\n');
fprintf(fp, '%f,%f,%f,%f,%f\n', prm_best.bilatfilt.SmoothingRate, prm_best.bilatfilt.Distance, prm_best.Sensitivity, prm_best.area_min, ds_max)
fprintf( '\nBest\n');
fprintf( '%f,%f,%f,%f,%f\n', prm_best.bilatfilt.SmoothingRate, prm_best.bilatfilt.Distance, prm_best.Sensitivity, prm_best.area_min, ds_max)



end

%%%%%%%%%%%%%%%%%%%%%%%%%% �G�b�W���x %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 1

num_feature = num_feature + 1;
fprintf(fp, 'Strength of Edge\n')
fprintf(fp, 'SmoothingRate,Distance,Hsize,hsum_start,Degree Separation\n')

ds_max = 0;
result = [];
fig = figure( 'Position', [ 100 100 900 600] )
for SmoothingRate = 0.05 %[ 0:0.05:0.2]
for Distance = 1 %[ 0:3 ]
for Hsize = 3 %[ 3 7 11 ]
for hsum_start = 9 %[ 2:15 ]

	prm.kind_feature		= 2; %�����ʂ̎�� 2:�G�b�W���x
	prm.bilatfilt.SmoothingRate	= SmoothingRate;
	prm.bilatfilt.Distance 		= Distance;
	prm.LaprasFlt.hsize		= Hsize;
	prm.hsum_start			= hsum_start;
	prm.edges			= [0 20 100 ];

%rdata = [  sum( rdata(:,1:2),2) sum( rdata(:,3:end),2) ]; %best (method=1)
%		edges = [0 prm.hsum_start 20:10:100];

	for i1 = 1:length( data )
		img = imread( data(i1).filename );
		[ result(i1,:) img_gray img_gray2 ] = cell_analize( img, prm );
	end
	%result_all(:,end+1:end+size(result,2)) = result;

	%�����xds�̌v�Z
	result2 = sum( result(:,2:end), 2 );
	ds = degree_separation( result2, class );

	fprintf(fp, '%f,%f,%f,%f,%f\n', SmoothingRate, Distance, Hsize, hsum_start, ds);
	fprintf(    '%f,%f,%f,%f,%f\n', SmoothingRate, Distance, Hsize, hsum_start, ds);

	prmstr = sprintf('SRate=%f Dist=%f Hsize=%f hsumStart=%f DS=%f', SmoothingRate, Distance, Hsize, hsum_start, ds );

	if ds_max < ds
		ds_max = ds;
		prm_best = prm;
		result_best = result;
		cla
		plot( class, result2, '+b' );
		xlabel('class (0:young 1:adult)');
		ylabel('�G�b�W���x');
		title( [ '�G�b�W���x�v�Z���� (' prmstr ')' ] );
		xlim([ -1 2 ] );
		grid on
		saveas( fig, 'result_edge.png')
		pause(0.1);
	end


end
end
end
end

result_add(end+1).data = result_best;


fprintf(fp, '\nBest\n');
fprintf(fp, '%f,%f,%f,%f,%f\n', prm_best.bilatfilt.SmoothingRate, prm_best.bilatfilt.Distance, prm_best.LaprasFlt.hsize, prm_best.hsum_start, ds_max)
fprintf( '\nBest\n');
fprintf( '%f,%f,%f,%f,%f\n', prm_best.bilatfilt.SmoothingRate, prm_best.bilatfilt.Distance, prm_best.LaprasFlt.hsize, prm_best.hsum_start, ds_max)

end


%%%%%%%%%%%%%%%%%%%%%%%%%% ���G���g���s�[ %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0

num_feature = num_feature + 1;
fprintf(fp, 'Entropy\n')
fprintf(fp, 'SmoothingRate,Distance,Degree Separation\n')

ds_max = 0;
result = [];
fig = figure( 'Position', [ 100 100 900 600] )
for SmoothingRate = 0 %[ 0:0.05:0.2]
for Distance = 0 %[ 0:5 ]

	prm.kind_feature		= 3; %�����ʂ̎�� 3:���G���g���s�[
	prm.bilatfilt.SmoothingRate	= SmoothingRate;
	prm.bilatfilt.Distance 		= Distance;

	for i1 = 1:length( data )
		img = imread( data(i1).filename );
		[ result(i1,:) img_gray img_gray2 ] = cell_analize( img, prm );
	end
	%result_all(:,end+1:end+size(result,2)) = result;

	%�����xds�̌v�Z
	result2 = sum( result, 2 );
	ds = degree_separation( result2, class );

	fprintf(fp, '%f,%f,%f\n', SmoothingRate, Distance, ds);
	fprintf(    '%f,%f,%f\n', SmoothingRate, Distance, ds);

	prmstr = sprintf('SRate=%f Dist=%f DS=%f', SmoothingRate, Distance, ds );

	if ds_max < ds
		ds_max = ds;
		prm_best = prm;
		result_best = result;
		cla
		plot( class, result2, '+b' );
		xlabel('class (0:young 1:adult)');
		ylabel('�G���g���s�[');
		title( [ '�G���g���s�[�v�Z���� (' prmstr ')' ] );
		xlim([ -1 2 ] );
		grid on
		saveas( fig, 'result_entropy.png')
		pause(0.1);
	end


end
end

result_add(end+1).data = result_best;

fprintf(fp, '\nBest\n');
fprintf(fp, '%f,%f,%f\n', prm_best.bilatfilt.SmoothingRate, prm_best.bilatfilt.Distance, ds_max)
fprintf( '\nBest\n');
fprintf( '%f,%f,%f\n', prm_best.bilatfilt.SmoothingRate, prm_best.bilatfilt.Distance, ds_max)

end



%�v�Z���������ʂ��v���b�g
%{
figure
id0 = find( class == 0 );
id1 = find( class == 1 );
plot3( result(1,id0), result(2,id0), result(3,id0), '+r');
hold on
plot3( result(1,id1), result(2,id1), result(3,id1), '+b');
xlabel('�t���N�^������')
ylabel('��E��')
zlabel('�G�b�W���x')
legend('young','adult')
grid on
%}

%id_cv = floor( rand( 1, N ) * prm.Kcv * 0.9999 )+1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���W���������ʂ��}�[�W
result_all=[];

rdata = result_add(1).data;
result_all(:,end+1:end+size(rdata,2)) = rdata;

rdata = result_add(2).data;
result_all(:,end+1:end+size(rdata,2)) = rdata;

rdata = result_add(3).data;
result_all(:,end+1:end+size(rdata,2)) = rdata;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ���`�d��A  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=length(data);
Y = class';

prm.LS.flag_normalize = 1;
prm.LS.lambda = 1;

if 1
	%[ Y2 Ycv b ds_cv id_select_best ] = LS_searchPrm( [result_all result_all.^2 result_all.^3 result_all.^4 result_all.^5  result_all.^6 result_all.^7], Y );
	%[ Y2 Ycv b MAE_cv ds_cv id_select_best ] = LS_searchPrm( [result_all result_all.^2 result_all.^3 ], Y );
	%[ Y2 Ycv b MAE_cv ds_cv id_select_best ] = LS_searchPrm( [result_all result_all.^2 ], Y ); % 3,  4,  8,  9, 18,
	[ Y2 Ycv model MAE_cv ds_cv id_select_best ] = LS_searchPrm( [result_all], Y, prm );
else
	%X=[ ones(N,1) result_all result_all.^2 result_all.^3 ];
	X=[ ones(N,1) result_all ];
	b = (X'*X )\ (X'*Y)
	Y2 = X * b;
end

if 0
	%id_select = [ 3  4  8  9 18];
	id_select = [ 1  3  4  6  8  9 10 12 17 18 25 26 ];
	x = [result_all result_all.^2 ];
	[ b MAE_t MAE_cv ds_t ds_cv Y2 Ycv] = LS_cv( id_cv, x(:,id_select), Y );
	[ th acc ]= acc_separation( Y2, class );
end

%plot_regression_result( Y2, Y, 0, 'result_LSR_train.png' );
%plot_regression_result( Ycv, Y, 0, 'result_LSR_cv.png' );


plot_regression_result( Y2, Y, 1, 'result_LSR_train.png', '���`�d��A����(���t�f�[�^)' );
plot_regression_result( Ycv, Y, 1, 'result_LSR_cv.png', '���`�d��A����(LOO��������)' );
id_select_best

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SVR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if 0
prm.svm.option = '-s 4 -t 2 -h 0 -e 1';% nu_SVR, RBF kernel, shrinking(1:ON�ɂ���Ǝ��Ԃ������邪�J��Ԃ��񐔂������ꍇ�Ɏ�����������A0:�J��Ԃ��񐔂����Ȃ��ꍇ��OFF�̕����ǂ�), ����臒l(0.01���Ǝ��Ԃ�������̂�1�ɂ���)
%prm.svm.option = '-s 0 -t 2 -h 0 -e 1';% SVM, RBF kernel, shrinking(1:ON�ɂ���Ǝ��Ԃ������邪�J��Ԃ��񐔂������ꍇ�Ɏ�����������A0:�J��Ԃ��񐔂����Ȃ��ꍇ��OFF�̕����ǂ�), ����臒l(0.01���Ǝ��Ԃ�������̂�1�ɂ���)
prm.Kcv = 10; %��������O���[�v��

id_cv_2 = [];
id_cv_2(1,:) = id_cv;
[ model_svr C_best G_best N_best MAE_cv_best_svr predict_value_cv_best predict_value_train ] = svm_grid_search( result_all, class', prm.svm.option, id_cv_2, 0, 1, 0 );
Y2 = predict_value_cv_best;

%��A�̗\�����ʂ̕����x
ds = degree_separation( Y2, class );

fig = figure
plot(Y,Y2,'+b');
xlabel('answer')
ylabel('predict')
xlim([ -1 2 ])
grid on
title(['�R�̓����ʂ�SVR�������� �����x=' num2str(ds) ])
saveas( fig, 'result_SVR.png')

end



fclose( fp );


 