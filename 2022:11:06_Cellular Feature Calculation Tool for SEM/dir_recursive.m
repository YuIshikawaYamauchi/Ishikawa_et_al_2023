function [F, D] = dir_recursive(TARGET_PATH)
% DIR_RECURSIVE  : 指定したファイルもしくはディレクトリ（フォルダ）のファイルとディレクトリを再帰的に検索し，リストを返す。
% 
%	[F, D] = DIR_RECURSIVE()は，カレントディレクトリより下の階層にあるファイルとディレクトリをリストします。
%
%	F = DIR_RECURSIVE()
%	カレントディレクトリより下の階層にあるファイルとディレクトリをリストします。
%	
%	F = DIR_RECURSIVE('file_name')
%	ファイルが指定された場合，そのファイルのみの構造体がFとして返ります。
%	
%	[F, D] = DIR_RECURSIVE('dir_path')
%	dir_pathで指定したディレクトリより下の階層にあるファイルとディレクトリをリストします。
%	
%	Fにはファイルのリストが，Dにはディレクトリのリストが返ります。
%	また，FとDは下記のフィールドを持つ構造体です。
%		name  -- ディレクトリ，もしくはファイル名
%		path  -- ディレクトリ，もしくはファイルの絶対パス
%		date  -- ファイルを修正した最新日
%		datenum  --  dateフィールドのMATLAB シリアル日時
%		bytes - ファイルへの割り当てバイト数
%		isdir - nameがディレクトリの場合1、そうでなければ0
%	
%	参考 DIR
% 
% --
%	Title : dir_recursive()
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Created : 2007/11/03 
% //--

% 引数無しの場合はカレントディレクトリに対して実行．
if nargin == 0  TARGET_PATH = pwd; end;

% 指定したファイル，ディレクトリの情報を調べる．．
[num, pathinfo] = fileattrib(TARGET_PATH);

%%%% ファイルが指定された場合
if pathinfo(1).directory~=1 
	F = dir(TARGET_PATH);
	target_dir = fileparts(pathinfo(1).Name);
	F = arrayfun(@(strc) setfield(strc, 'path', fullfile(target_dir, strc.name)), F);
%%%% ディレクトリ（フォルダ）が指定された場合
else 
	if num~=1 error('ディレクトリを指定する場合にはワイルドカードは使えません。'); end;
	target_dir = pathinfo.Name;

	% サブディレクトリのリスト取得
	dirs = strread(genpath(target_dir), '%s', 'delimiter', ';');

	% 再帰的に検索 
	F = [];
	for ind = 1:length(dirs) 
		path = dirs{ind};
		ff = dir(path);

		%2013.03.12 change start
		% 構造体にpathフィールドを追加 ＆ "," と ".."を削除．
		%ff = arrayfun(@(strc) setfield(strc, 'path', fullfile(path, strc.name)), ff(3:end));

		%"." と ".."を検索(除外するため)
		num_use = 0;
		for ii = 1:length(ff)
			if strcmp( ff(ii).name, '.' ) == 0 && strcmp( ff(ii).name, '..' ) == 0
				num_use = num_use + 1;
				id_use( num_use ) = ii;
			end
		end

		% 構造体にpathフィールドを追加
		ff = arrayfun(@(strc) setfield(strc, 'path', fullfile(path, strc.name)), ff(id_use(1:num_use)));
		%2013.03.12 change end

		if length(ff) == 0
			continue;
		end

		if isempty(F) 
			F = ff;
		else 
			F(end+1:end+length(ff)) = ff;
		end;
	end;
end;

% datenumフィールドがない場合，追加する。
if ~isfield(F, 'datenum') F = arrayfun(@(strc) setfield(strc, 'datenum', datenum({strc.date})), F); end;

% MATLAB 2007b以降の場合にdateフィールドをMATLAB標準のフォーマット'dd-mmm-yyyy HH:MM:SS'に変換する。
if datenum(version('-date')) > 733268 F = arrayfun(@(strc) setfield(strc, 'date', datestr(strc.datenum)), F); end;

% ファイルとディレクトリのリストに分別する．
D = F(find([F.isdir]));
F = F(find(~[F.isdir]));
