%% *fractalDimension*
%% *definition*
function [fDGlobal,fDLocal] = getFractalDimension2D(im,epsilon,window,edges)
%% *purpose*
% to compute the fractal dimension of an image
%% *inputs*
% im      - input image
% epsilon - scaling parameter for search (typically between 3 and 11)
% window  - dimension of fractal homogeneity (local fractal dimension)
%% *outputs*
% fDGlobal - global fractal dimension (single value)
% fDLocal  - local fractal dimension (image of same size, mask regions nan)
%% *examples*
%{
    MaxLevel = 7; % size of image is 2^MaxLevel+1
    seed = 6231959;
    H = 0.1; % Hurst parameters a values between 0 and 1
    im = midpoint2D(MaxLevel,H,seed);
    epsilon = 11;
    window = 21;
    [fD,fDLocal] = getFractalDimension2D(im,epsilon,window);
    N = 2.0^MaxLevel;
    figure('Color','white');
    imagesc(-N/2:N/2,-N/2:N/2,im);
    title({['FBM 2D Hurst =' num2str(H)]; ...
        ['FD Input =' num2str(3-H,'%.2f') ...
         ' Measured =' num2str(fD,'%.2f')]}, ...
        'fontsize',12);
    axis equal
    axis tight
    colormap(bone);
    colorbar
    set(gca,'fontweight','bold');


    seed = 6231959; % seed enables repeatability
    seed = 19630820;
    MaxLevel = 8; % size of image is 2^MaxLevel+1
    H = [0.2 0.8]; % Hurst parameter between 0 and 1
    figure('Color','white','position',[100 100 1000 900]);
    for icase = 1:numel(H)
    im = midpoint2D(MaxLevel,H(icase),seed);
    nAng = 24;
    nRho = 36;
    [fDGlobal,fDLocal] = getFractalDimension2D(im,epsilon,window);

    subplot(numel(H),2,1+2*(icase-1))
    N = 2.0^MaxLevel;
    imagesc(-N/2:N/2,-N/2:N/2,im); %,[-1 1]);
    title({['FBM 2D Hurst =' num2str(H(icase)) ' \mu=' ...
        num2str(mean(im(:)),'%.2f') ' \sigma=' num2str(std(im(:)),'%.2f')]; ...
        ['FD Input =' num2str(3-H(icase),'%.2f') ...
        ' Measured =' num2str(fDGlobal,'%.2f')]}, 'fontsize',12);
    axis equal; axis tight;
    colormap(gca,bone); colorbar; set(gca,'fontweight','bold');

    subplot(numel(H),2,2+2*(icase-1))
    N = 2.0^MaxLevel;
    imagesc(-N/2:N/2,-N/2:N/2,fDLocal,[2 3]);
    title({['FBM 2D Hurst =' num2str(H(icase)) ' \mu=' ...
        num2str(mean(im(:)),'%.2f') ' \sigma=' num2str(std(im(:)),'%.2f')]; ...
        ['FD Input =' num2str(3-H(icase),'%.2f') ...
        ' Measured =' num2str(fDGlobal,'%.2f')]}, 'fontsize',12);
    axis equal; axis tight;
    jetbk = jet; jetbk(1,:) = [0 0 0];
    colormap(gca,jetbk); colorbar; set(gca,'fontweight','bold');

    end
%}
%% *references*
% Dennis and Dessipris (1989) Fractal modelling in image texture analysis
% IEE Proceedings, Vol. 136, Pt. F, No. 5, October 1989. p. 227-228
%% *history*
%  when     who   why
%  20200115 mnoah original code
%  20210318 mnoah added a kludge to the fd estimation
%%
if (~exist('epsilon','var'))
    epsilon = 3;
end
if (~exist('window','var'))
    window = max(min(21,floor(size(im,1)/5)),5);
end
% compute window region and log epsilon
halfmask = floor(window/2);
window = 2*halfmask + 1;
nmask = double(window)^2;
mask = ones(window,window)./nmask;
log_epsilon = log(double(epsilon));
%% allocate space for temporary arrays
[nrow,ncol] = size(im);
fDLocal  = nan(nrow,ncol);
% inImage = (inImage-mean(inImage(:)))/std(inImage(:));
%% create difference arrays
% note: Estimating the RMS by sum of absolute values instead of sum of the
% squares - this makes the code execute faster with little incurred error.
idata2r = ...
    abs(im - circshift(im, 1,1)) + ...
    abs(im - circshift(im,-1,1)) + ...
    abs(im - circshift(im, 1,2)) + ...
    abs(im - circshift(im,-1,2)); %近傍間のラプラスフィルタ
idata2e = ...
    abs(im - circshift(im, epsilon,1)) + ...
    abs(im - circshift(im,-epsilon,1)) + ...
    abs(im - circshift(im, epsilon,2)) + ...
    abs(im - circshift(im,-epsilon,2)); %epsilon離れた画素間のラプラスフィルタ
    
datavalr = conv2(idata2r,mask,'same');
datavale = conv2(idata2e,mask,'same');
idx = (datavalr > 0.0 & datavale > 0.0); %近傍エッジとepsilon離れたエッジの両方を満たす画素を収集
fDLocal(idx) = log(datavalr(idx)) - log(datavale(idx));
fDLocal(idx) = sqrt(2)*(0.5 + fDLocal(idx)/log_epsilon) + 2.5;
tmp = fDLocal(2*halfmask:end-2*halfmask,2*halfmask:end-2*halfmask);

if 0
	fDGlobal(1) = max(min(3,median(tmp(:))),2);%画素ごとのFDのメジアンを求め、2以上3以下にしている。
	fDGlobal(2) = std(tmp(:));%画素ごとのFDの標準偏差
else
	if 1
		%edges = 2:0.1:3;
		%edges = 1:0.1:3;
		%fDGlobal(1) = median(tmp(:));%画素ごとのFDの平均
		h = histcounts( tmp(:), edges );
		%fDGlobal(2:2+length(h)-1) = h;
		fDGlobal = h;
	else
		fDGlobal(1) = median(tmp(:));%画素ごとのFDのメジアン
		fDGlobal(2) = std(tmp(:));%画素ごとのFDの標準偏差
	end
end

fDLocal(1:halfmask,:) = nan;
fDLocal(:,1:halfmask) = nan;
fDLocal(end-halfmask:end,:) = nan;
fDLocal(:,end-halfmask:end) = nan;

end

%{
https://jp.mathworks.com/matlabcentral/fileexchange/71774-create-measure-characterize-visualize-1d-2d-3d-fractals?s_tid=srchtitle
Copyright (c) 2021, Meg Noah
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution

* Neither the name of  nor the names of its
  contributors may be used to endorse or promote products derived from this
  software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

%}