function [ m sd ] = get_static_mean_std( data )

if 1
	m = median( data(:) );
	sd = 1.4826 * median( abs(data(:)-m) );
else
	m = mean( double( data(:) ) );
	sd = std( double( data(:) ) );
end

