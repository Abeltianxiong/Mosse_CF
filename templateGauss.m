%%%%%%%%%%%%%%%%%%%%������˹������Ӧ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function F_response=templateGauss(im)
    if(size(im,3)==1) %�Ҷ�ͼ��
        [height,width]=size(im);
        gaussMaxSize=20;%��˹ƽ�����ֵ,ֵԽ���˹��ԽС
        x=-gaussMaxSize:gaussMaxSize*2/width:gaussMaxSize-gaussMaxSize*2/width;
        y=-gaussMaxSize:gaussMaxSize*2/height:gaussMaxSize-gaussMaxSize*2/width;
        [X,Y]=meshgrid(x,y);%
        response=255.*exp(-X.^2-Y.^2);%���ɶ�ά��˹�ֲ�
    else              %��ɫͼ��
        [height,width,~]=size(im);
        gaussMaxSize=20;%��˹ƽ�����ֵ,ֵԽ���˹��ԽС
        x=-gaussMaxSize:gaussMaxSize*2/width:gaussMaxSize-gaussMaxSize*2/width;
        y=-gaussMaxSize:gaussMaxSize*2/height:gaussMaxSize-gaussMaxSize*2/width;
        [X,Y]=meshgrid(x,y);%
        r=255.*exp(-X.^2-Y.^2);%���ɶ�ά��˹�ֲ�
        response(:,:,1)=r;response(:,:,2)=r;response(:,:,3)=r;
        
    end
        F_response=fft2(response);%����Ҷ�任
%         figure
%         imshow(response);
%         mesh(response);
end