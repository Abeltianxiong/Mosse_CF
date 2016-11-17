%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function is correlation filter
%Visual Object Tracking using Adaptive Correlation Filters
%MOSSE
%date:2016-11-10
%author:WeiQin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;clear all;clc;
%% ����ͼƬ�ļ�
imgDir='D:\ImageData\David';%ͼƬ�ļ���·����
[groundtruth,img_path,img_files]=Load_image(imgDir);%���ú�����ȡͼƬ֡
img = imread([img_path img_files{1}]);%��ȡĿ��֡
startFrame=1;%��ʼ֡
if(size(img,3)==1) %�Ҷ�ͼ��
    im=img;
else
    im = rgb2gray(img);%ת��Ϊ�Ҷ�ͼ
end
%     figure
%     subplot(1,2,1)
%     imshow(im);title('current imge');
%������Ƶ�ļ�
% videoDir= '.\video\03_pedestrian1\pedestrian1.mpg';
% videoData=Load_video(videoDir);
if(size(groundtruth,2)==1)%һ��
    target=groundtruth(1:4);%x,y,w,hĿ����С
else if(size(groundtruth,2)==4)%4��
    target=groundtruth(1,1:4);%x,y,w,hĿ����С
else
    error('something wrong in groundtruth');
    end
end
%% ����ͼ��Χ��Ŀ��ȡͼ���Ե
if rem(target(3),2)==1
    target(3)=target(3)+1;
end
if rem(target(4),2)==1
    target(4)=target(4)+1;
end
target_sz=[target(4) target(3)];%h,w
pos=[target(2)+target(4)/2,target(1)+target(3)/2];%Ŀ������ĵ�
target_box=getsubbox(pos,target_sz,im);%��ȡĿ���s
%������˹����ģ��
F_response=templateGauss(target_sz,im);%��˹����ģ��
%% ��ѭ����ȡȫ��ͼ��֡
for frame=startFrame:length(img_files)
        %trainingѵ�����ģ��
        img = imread([img_path img_files{frame}]);%��ȡĿ��֡
        if(size(img,3)==1) %�Ҷ�ͼ��
            im=img;
        else
            im = rgb2gray(img);%ת��Ϊ�Ҷ�ͼ
        end
        target_box=getsubbox(pos,target_sz,im);%��ȡĿ���s
    if frame>startFrame
        %% ѵ��������ʼ���ٲ�����ģ��
        newPoint=real(ifft2(F_Template.*fft2(target_box)));%���з��任
%         newPoint=uint8(newPoint);
%         subplot(1,2,1)
%         imshow(256.*newPoint);
        [row, col,~] = find(newPoint == max(newPoint(:)), 1);
        pos = pos - target_sz/2 + [row, col]; 
    end
    F_im= fft2(getsubbox(pos,target_sz,im));
%     F_Template=F_response./(F_im+eps);%CFģ�����   
    F_Template=conj(F_im.*conj(F_response)./(F_im.*conj(F_im)+eps));%mosseģ�����      
        %% ��ͼ
%         subplot(1,2,2)
        imagesc(uint8(img))
        colormap(gray)
        rect_position = [pos([2,1]) - (target_sz([2,1])/2), (target_sz([2,1]))]; 
        rectangle('Position',rect_position,'LineWidth',4,'EdgeColor','r');
        hold on;
        text(5, 18, strcat('#',num2str(frame)), 'Color','y', 'FontWeight','bold', 'FontSize',20);
%         set(gca,'position',[0 0 1 1]); 
        pause(0.001); 
        hold off;
        drawnow;
end

