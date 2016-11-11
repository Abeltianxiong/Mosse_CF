%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function is correlation filter
%Visual Object Tracking using Adaptive Correlation Filters
%MOSSE
%date:2016-11-10
%author:WeiQin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;clear all;clc;
%����ͼƬ�ļ�
imgDir='.\BlurCar3\';%ͼƬ�ļ���·����
[guroundtruth,img_path,img_files]=Load_image(imgDir);%���ú�����ȡͼƬ֡
im = imread([img_path img_files{1}]);%��ȡĿ��֡
im = rgb2gray(im);%ת��Ϊ�Ҷ�ͼ
    figure
    subplot(1,2,1)
    imshow(im);title('current imge');
%������Ƶ�ļ�
% videoDir= '.\video\03_pedestrian1\pedestrian1.mpg';
% videoData=Load_video(videoDir);
%������˹����ģ��
F_response=templateGauss(im);%��˹����ģ��
%��ѭ����ȡȫ��ͼ��֡
for frame=1:50%length(img_files)
        %trainingѵ�����ģ��
        im = imread([img_path img_files{frame}]);%��ȡĿ��֡
        im = rgb2gray(im);%ת��Ϊ�Ҷ�ͼ
        F_im= fft2(im);
    if frame>1
        %ѵ��������ʼ���ٲ�����ģ��
        F_newPoint=F_Template.*F_im;
        newPoint=real(ifft2(F_newPoint));%���з��任
        newPoint=uint8(newPoint);
        %��ͼ
        subplot(1,2,1)
        imshow(im);title('current imge');
        subplot(1,2,2)
        imshow(newPoint);title('mosse');
        drawnow
    end
    F_Template=conj(F_im.*conj(F_response)./(F_im.*conj(F_im)));%mosseģ�����  
end

