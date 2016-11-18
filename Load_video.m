%�ú�����ȡ��Ƶ����ȡgroundtruth����
function [videoData,target] = Load_video(videoDir)
    sequence_path = [videoDir,'\'];%�ļ�·��
    videoFile = [sequence_path 'david.mpg']; %�ļ�·��
    videoData = VideoReader(videoFile);%��ȡ��Ƶ
% % for i = 1 : 50
% %         videoframe = read(videoData,i);% ��ȡÿһ֡
% %         videoframe= rgb2gray(videoframe);%ת��Ϊ�Ҷ�ͼ
% %         imshow(videoframe);%��ʾÿһ֡
% %         % imwrite(frame,strcat(num2str(i),'.jpg'),'jpg');% ����ÿһ֡
% % end
    %% Read files 
    groundtruth = csvread([sequence_path 'groundtruth_rect.txt']);%��������ʵĿ��λ��
    %% get position and boxsize ��ȡgroundtruth���� 
    if(size(groundtruth,2)==1)%һ��
        target=groundtruth(1:4);%x,y,w,hĿ����С
    else if(size(groundtruth,2)==4)%4��
        target=groundtruth(1,1:4);%x,y,w,hĿ����С
    else
        error('something wrong in groundtruth');
        end
    end
end