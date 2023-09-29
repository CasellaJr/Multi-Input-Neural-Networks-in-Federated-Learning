function converter(input_path, output_path)

% dicm2nii function is from the following repository:
%   https://github.com/xiangruili/dicm2nii
addpath('/home/nuc3/Documenti/phd/dicm2nii')
dicm2nii(input_path, output_path,'.nii.gz');
