function [F, D] = dir_recursive(TARGET_PATH)
% DIR_RECURSIVE  : �w�肵���t�@�C���������̓f�B���N�g���i�t�H���_�j�̃t�@�C���ƃf�B���N�g�����ċA�I�Ɍ������C���X�g��Ԃ��B
% 
%	[F, D] = DIR_RECURSIVE()�́C�J�����g�f�B���N�g����艺�̊K�w�ɂ���t�@�C���ƃf�B���N�g�������X�g���܂��B
%
%	F = DIR_RECURSIVE()
%	�J�����g�f�B���N�g����艺�̊K�w�ɂ���t�@�C���ƃf�B���N�g�������X�g���܂��B
%	
%	F = DIR_RECURSIVE('file_name')
%	�t�@�C�����w�肳�ꂽ�ꍇ�C���̃t�@�C���݂̂̍\���̂�F�Ƃ��ĕԂ�܂��B
%	
%	[F, D] = DIR_RECURSIVE('dir_path')
%	dir_path�Ŏw�肵���f�B���N�g����艺�̊K�w�ɂ���t�@�C���ƃf�B���N�g�������X�g���܂��B
%	
%	F�ɂ̓t�@�C���̃��X�g���CD�ɂ̓f�B���N�g���̃��X�g���Ԃ�܂��B
%	�܂��CF��D�͉��L�̃t�B�[���h�����\���̂ł��B
%		name  -- �f�B���N�g���C�������̓t�@�C����
%		path  -- �f�B���N�g���C�������̓t�@�C���̐�΃p�X
%		date  -- �t�@�C�����C�������ŐV��
%		datenum  --  date�t�B�[���h��MATLAB �V���A������
%		bytes - �t�@�C���ւ̊��蓖�ăo�C�g��
%		isdir - name���f�B���N�g���̏ꍇ1�A�����łȂ����0
%	
%	�Q�l DIR
% 
% --
%	Title : dir_recursive()
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Created : 2007/11/03 
% //--

% ���������̏ꍇ�̓J�����g�f�B���N�g���ɑ΂��Ď��s�D
if nargin == 0  TARGET_PATH = pwd; end;

% �w�肵���t�@�C���C�f�B���N�g���̏��𒲂ׂ�D�D
[num, pathinfo] = fileattrib(TARGET_PATH);

%%%% �t�@�C�����w�肳�ꂽ�ꍇ
if pathinfo(1).directory~=1 
	F = dir(TARGET_PATH);
	target_dir = fileparts(pathinfo(1).Name);
	F = arrayfun(@(strc) setfield(strc, 'path', fullfile(target_dir, strc.name)), F);
%%%% �f�B���N�g���i�t�H���_�j���w�肳�ꂽ�ꍇ
else 
	if num~=1 error('�f�B���N�g�����w�肷��ꍇ�ɂ̓��C���h�J�[�h�͎g���܂���B'); end;
	target_dir = pathinfo.Name;

	% �T�u�f�B���N�g���̃��X�g�擾
	dirs = strread(genpath(target_dir), '%s', 'delimiter', ';');

	% �ċA�I�Ɍ��� 
	F = [];
	for ind = 1:length(dirs) 
		path = dirs{ind};
		ff = dir(path);

		%2013.03.12 change start
		% �\���̂�path�t�B�[���h��ǉ� �� "," �� ".."���폜�D
		%ff = arrayfun(@(strc) setfield(strc, 'path', fullfile(path, strc.name)), ff(3:end));

		%"." �� ".."������(���O���邽��)
		num_use = 0;
		for ii = 1:length(ff)
			if strcmp( ff(ii).name, '.' ) == 0 && strcmp( ff(ii).name, '..' ) == 0
				num_use = num_use + 1;
				id_use( num_use ) = ii;
			end
		end

		% �\���̂�path�t�B�[���h��ǉ�
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

% datenum�t�B�[���h���Ȃ��ꍇ�C�ǉ�����B
if ~isfield(F, 'datenum') F = arrayfun(@(strc) setfield(strc, 'datenum', datenum({strc.date})), F); end;

% MATLAB 2007b�ȍ~�̏ꍇ��date�t�B�[���h��MATLAB�W���̃t�H�[�}�b�g'dd-mmm-yyyy HH:MM:SS'�ɕϊ�����B
if datenum(version('-date')) > 733268 F = arrayfun(@(strc) setfield(strc, 'date', datestr(strc.datenum)), F); end;

% �t�@�C���ƃf�B���N�g���̃��X�g�ɕ��ʂ���D
D = F(find([F.isdir]));
F = F(find(~[F.isdir]));
