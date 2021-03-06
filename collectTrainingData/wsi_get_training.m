% function [ tilenames ] = wsi_get_training( sourcedir, svs_fname, destination_dir) 
% gather training data for images
% loop through the images
% ask whether the image is suitable to annotate
% until there is 7 qualified images
% the loop could be every 10 tiles. We have about 300 tiles/wsi

function [ tilenames ] = wsi_get_training( sourcedir, svs_fname, destination_dir, numtiles) 

%datadir = fullfile(datadir, 'TissueImages');
splitStr = regexp(svs_fname,'\.','split');
fileNames = dir(fullfile(sourcedir,'TissueImages',[splitStr{1} '*.' 'tif']));
imagepaths = {fileNames.name}';

numImages = length(imagepaths);% 420
numImagesQualified = 0;

% svs_image = imread(fullfile(sourcedir, 'svs',svs_fname),'Index',2);
% imshow(svs_image);

tilenames = cell(1,numtiles);
for i = 1:numImages
    imname = imagepaths{i}; 
    raw_image = imread(fullfile(sourcedir,'TissueImages',imname));
    imshow(raw_image);
    choice = menu('Image qualified?','not qualified','qualified');
    if choice == 2       
        % update
        numImagesQualified = numImagesQualified + 1;
        tilenames{numImagesQualified} = imname;
        % copy to the new directory
        copyfile(fullfile(sourcedir,'TissueImages',imname),destination_dir);        
    end
    % only consider up to 20 qualified images
    if numImagesQualified >= numtiles
        break;
    end
    
end

end