function c = convolve_vox_tract(b,vox)
%

b = b(:); vox = vox(:);
c = conv(b,vox);
c = c(4097:end);
c = c(1:end-5000);


%c = -c;
