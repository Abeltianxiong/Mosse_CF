%��ȡ��Ƶ
function videoData=Load_video(videoDir)
    videoFile = videoDir; %�ļ�·��
    videoData = VideoReader(videoFile);%��ȡ��Ƶ
% % for i = 1 : 50
% %         videoframe = read(videoData,i);% ��ȡÿһ֡
% %         videoframe= rgb2gray(videoframe);%ת��Ϊ�Ҷ�ͼ
% %         imshow(videoframe);%��ʾÿһ֡
% %         % imwrite(frame,strcat(num2str(i),'.jpg'),'jpg');% ����ÿһ֡
% % end
end