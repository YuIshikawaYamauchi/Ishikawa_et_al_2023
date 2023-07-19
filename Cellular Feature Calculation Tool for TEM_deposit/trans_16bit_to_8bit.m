function img_8bit = trans_16bit_to_8bit( img_16bit )

if 0
	imax = max( img_16bit(:) );
	imin = imax - 255;
	img_8bit = uint8( img_16bit-imin );

else
	[ m sd ] = get_static_mean_std( double(img_16bit) );

	imax = m+3*sd
	imin = m-3*sd

	img_8bit = uint8( ( double(img_16bit)-imin)/(imax-imin)*255 );

end
