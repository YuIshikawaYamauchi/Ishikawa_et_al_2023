function main


global fpath
fpath = './';

global prm
global prm_fd
global prm_hole
global prm_edge

prm.offset.x(1)			= 0;
prm.offset.x(2)			= 0;
prm.offset.y(1)			= 0;
prm.offset.y(2)			= 90;

prm.LS.flag_normalize = 1;
prm.LS.lambda = 1;

prm_fd = prm;
prm_fd.kind_feature		= 0; %特徴量の種類 0:フラクタル次元
prm_fd.bilatfilt.SmoothingRate	= 0.025;
prm_fd.bilatfilt.Distance 	= 1;
prm_fd.fd.epsilon		= 5;
prm_fd.fd.window		= 20;
prm_fd.edges			= [1:0.2:3];

prm_hole = prm;
prm_hole.kind_feature		= 1; %特徴量の種類 1:穴の数
prm_hole.bilatfilt.SmoothingRate= 0.05;
prm_hole.bilatfilt.Distance 	= 4;
prm_hole.Sensitivity		= 0.5;
%prm_hole.area_min		= 100;
prm_hole.edges			= [ 0:50:150 1000 1e+10];

prm_edge = prm;
prm_edge.kind_feature		= 2; %特徴量の種類 2:エッジ強度
prm_edge.bilatfilt.SmoothingRate= 0.05;
prm_edge.bilatfilt.Distance 	= 1;
prm_edge.LaprasFlt.hsize	= 3;
%prm_edge.hsum_start		= 9;
%prm_edge.edges			= [0 20 100 ];
prm_edge.edges			= [0 20 40 60 100 ];

GUI