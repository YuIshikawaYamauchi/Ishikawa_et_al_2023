function [ r img_gray img_gray2 ] = cell_analize( img, prm )

flag_plot = 0;

img_gray = rgb2gray( img( prm.offset.y(1)+1:end-prm.offset.y(2), prm.offset.x(1)+1:end-prm.offset.x(2), :) );

si = size( img_gray );

%スムージング
if prm.bilatfilt.SmoothingRate > 0.0 && prm.bilatfilt.Distance > 0
	img_gray2 = imbilatfilt( img_gray, prm.bilatfilt.SmoothingRate*255^2, prm.bilatfilt.Distance );
else
	img_gray2 = img_gray;
end


if 0
	r = std( double( img_gray(:) ) );
end

r = [];

if prm.kind_feature == 0 %特徴量の種類 0:フラクタル次元

	%フラクタル次元
	[fDGlobal,fDLocal] = getFractalDimension2D(img_gray2, prm.fd.epsilon,prm.fd.window, prm.edges);
	if 0	
		r(end+1) = fDGlobal(1); %メジアン
	else
		if 0
			edges = 2.0:0.05:2.3;
			r = histcounts( fDLocal(:), prm.edges );
		else
			r = fDGlobal; %メジアン、SD
		end

		%fprintf('特徴量の平均%f SD%f MAX%f MIN%f\n', mean( fDLocal(:) ), std( fDLocal(:) ), max( fDLocal(:) ) , min( fDLocal(:) ) );
	end

elseif prm.kind_feature == 1 %特徴量の種類 1:穴の数

	%穴の数
	BW = imbinarize(img_gray2,'adaptive','ForegroundPolarity','dark','Sensitivity', prm.Sensitivity );
	BW = not(BW);


	[L,nl] = bwlabeln(BW);
	%nh = 0;
	nh = nl;
	area = zeros( [ nl 1] );
	for l=1:nl
		area(l) = length( find( L(:) == l ));
		%{
		if area(l) >= prm.area_min
			nh = nh + 1;
		end
		%}
	end

	if 0
		figure
		subplot(1,3,1)
		imshow( img_gray2 )
		subplot(1,3,2)
		imshow( not(BW) )
		subplot(1,3,3)
		histogram( area, prm.edges(1:end-1) )
		pause
	end

	method =1;
	if method == 0
		r(end+1) = nh;
	elseif method == 1
		%edges = [ 0 prm.area_min prm.area_min*5 prm.area_min*10 prm.area_min*100 prm.area_min*1000 prm.area_min*10000 1e+10 ];
		%edges = [ 0 prm.area_min prm.area_min*5 prm.area_min*10 prm.area_min*100 1e+10 ];%best
		edges = [ 0:50:200 400:200:1000 2000 1e+10];
		%edges = [ 0 prm.area_min 1e+10 ];
		r = histcounts( area, prm.edges );
		%r = [ median( area(:) ), std( area(:) ) ];
	elseif method == 2
		r(1) = median( area );
		r(2) = std( area );
	end
	fprintf('nh=%d sum(r(2:end))=%d 特徴量の平均%f SD%f MAX%f MIN%f\n', nh, sum(r(2:end)), mean( area(:) ), std( area(:) ), max( area(:) ) , min( area(:) ) );

elseif prm.kind_feature == 2 %特徴量の種類 2:エッジ強度

	%エッジ強度

	%ラプラスフィルタの設計
	h = fspecial('gaussian', prm.LaprasFlt.hsize, prm.LaprasFlt.hsize*0.25 );
	cp = ceil(prm.LaprasFlt.hsize*0.5);
	h(cp,cp) = 0;
	h(cp,cp) = -sum( h(:) );
	img_edge = abs( imfilter( double( img_gray2 ), h ) );

	
	method =1;
	if method == 0
		edges = [0:100];
		hc = histcounts( img_edge(:), edges );
		r(end+1) = sum( hc(prm.hsum_start:end) );
	elseif method == 1
		%edges = [0 prm.hsum_start 20:10:100];
		r = histcounts( img_edge(:), prm.edges );
	elseif method == 2
		r(1) = median( img_edge(:) );
		r(2) = std( img_edge(:) );
	end
	fprintf('特徴量の平均%f SD%f MAX%f MIN%f\n', mean( img_edge(:) ), std( img_edge(:) ), max( img_edge(:) ) , min( img_edge(:) ) );

elseif prm.kind_feature == 3 %特徴量の種類 3:情報エントロピー

	r(end+1) = entropy( img_gray2 );

elseif prm.kind_feature == 4 %特徴量の種類 4:



end
	

	


	if flag_plot == 1
		figure
		subplot(2,3,1)
		imshow( img_gray )
		subplot(2,3,2)
		imshow( img_gray2 )
		subplot(2,3,3)
		imshow( BW )
		
		subplot(2,3,4)
		imshow( img_gray2 )
		subplot(2,3,5)
		imshow( img_edge/max( img_edge(:) ) )
		subplot(2,3,6)
		histogram( img_edge(:) )
		
	end




if 0
	%16x16ブロック画像の輝度SDのヒストグラム
	Nby = floor( ( prm.yrange(2)-prm.yrange(1)+1 ) / prm.block_size );
	Nbx = floor( ( prm.xrange(2)-prm.xrange(1)+1 ) / prm.block_size );
	
	std_block = [];
	nb = 0;
	for by= 1:Nby
		ys = prm.yrange(1) + (by-1)*prm.block_size;
		ye = ys+prm.block_size-1;
		for bx= 1:Nbx
			xs = prm.xrange(1) + (bx-1)*prm.block_size;
			xe = xs+prm.block_size-1;
			
			nb = nb+1;
	
			bi = img_gray2( ys:ye,xs:xe );
			std_block(nb) = std( double( bi(:) ) );
		end
	end
	
	%r = mean( std_block );
	
	edges = [ 1:100 ];
	r = histcounts( std_block, edges );
end


	