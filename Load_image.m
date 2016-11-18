%���ú�����ȡͼƬ֡����ȡgroundtruth����
function [target,img_path,img_files]=Load_image(imgDir)
%     %% Read params.txt
%     params = readParams('params.txt');
	%% load video info
    sequence_path = [imgDir,'/'];%�ļ�·��
    img_path = [sequence_path 'img/'];
    %% Read files 
    groundtruth = csvread([sequence_path 'groundtruth_rect.txt']);%��������ʵĿ��λ��
    %%%%%%%%%%%%%%%%%%%%%%%%%
    % read all the frames in the 'imgs' subfolder
    dir_content = dir([sequence_path 'img/']);
    % skip '.' and '..' from the count
    n_imgs = length(dir_content) - 2;
    img_files = cell(n_imgs, 1);
    for ii = 1:n_imgs
        img_files{ii} = dir_content(ii+2).name;
    end
    %% get position and boxsize ��ȡgroundtruth���� 
    if(size(groundtruth,2)==1)%һ��
        target=groundtruth(1:4);%x,y,w,hĿ����С
    else if(size(groundtruth,2)==4)%4��
        target=groundtruth(1,1:4);%x,y,w,hĿ����С
    else
        error('something wrong in groundtruth');
        end
    end
%     im = imread([img_path img_files{1}]);%��ȡĿ��֡
%     im= rgb2gray(im);%ת��Ϊ�Ҷ�ͼ
%     imshow(im);
end