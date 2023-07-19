function plot_regression_result( Yp, Ya, flag_logistic_regreion, filename, title_str )

if flag_logistic_regreion == 1
	Yp = sigmoid( Yp );
end

%回帰の予測結果の分離度
ds = degree_separation( Yp, Ya );
[ th acc ]= acc_separation( Yp, Ya );
MAE = mean(abs(Yp-Ya));

fig = figure
plot(Ya,Yp,'+b');
xlabel('answer')
ylabel('predict')
xlim([ -1 2 ])
grid on
title([ title_str ' 最適閾値=' num2str(th) ' 分類精度[%]=' num2str(acc*100) ])
saveas( fig, filename )
