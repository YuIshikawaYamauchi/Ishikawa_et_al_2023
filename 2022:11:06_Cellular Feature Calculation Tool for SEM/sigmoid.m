function p = sigmoid( Y )

%シグモイド関数を利用して、回帰推定値を尤度に変換する

p = 1./(1+exp(-Y));
