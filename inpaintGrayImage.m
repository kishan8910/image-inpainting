clc
clear
close all
n = 1;
while (n)
choice = menu('Options','Load the image','Select the Co-ordinated for inpainting',...
                'Show Image','Exit Application');
switch(choice)
    case (1)
        [FileName PathName] = uigetfile('*.jpg');
        addpath(PathName)
        Image = imread(FileName);
        GrayImage = rgb2gray(Image);
%         figure; imshow(Image); title('Loaded Image');
    case (2)
        x1 = input('Input the value of x1    ');
        x2= input('Input the value of x2    ');
        y1 = input('Input the value of y1    ');
        y2= input('Input the value of y2    ');
        TamperedImage = GrayImage;
        [mi ni] = size(GrayImage);
        ImageMask = ones(size(GrayImage));
        ImageMask(x1:x2,y1:y2) = 0;
        TamperedImage(x1:x2,y1:y2,:)= 0;
        InpaintedImage = TamperedImage(:,:);
        
        %% INPAINTING
        Pn = 51; P = 5;% P, Q stands for the patch size (you can try varying the patch size)
        Qn = 51; Q = 5;% Pn,Qn stands for the neighbourhood 
        PeeledCordinates_Fillfront = onionPeel(ImageMask,mi,ni);
        PeeledPatches = Patchfunction(InpaintedImage,PeeledCordinates_Fillfront,P,Q,mi,ni);
        LengthOfPeelCord = size(PeeledCordinates_Fillfront,1);
         NeighbouringPix = Neighbours(Pn,Qn,mi,ni,PeeledCordinates_Fillfront,ImageMask); %  Neighbouring pixel
         LengthOfNeighPix = size(NeighbouringPix);
         
         Flag =1;
         count =0;
         

         
%% In this while loop actual inpainting is happening          
         
        while (LengthOfPeelCord ~= 0 && Flag==1 )
            
%%%%%%%%%%%%%%% Patch selection from fillfront, depending on the similarity measure 'Rho'            
            count =count+1
            for i = 1 : LengthOfPeelCord
                temp = Patchfunction(InpaintedImage,NeighbouringPix{1,i}(:,:),P,Q,mi,ni);
                    x = PeeledCordinates_Fillfront(i,1);                y = PeeledCordinates_Fillfront(i,2);    
                Zp1     =   x-floor(P/2); Zp2  =   x+floor(P/2);
                Zq1     =   y-floor(Q/2); Zq2  =   y+floor(Q/2);   
                Rho(i) = SimilarityMeasure(Pn,Qn,PeeledPatches(:,:,i),temp,ImageMask(Zp1:Zp2, Zq1:Zq2));
%                 ImageMask(Zp1:Zp2, Zq1:Zq2) = 1;
            end
            [C Ind] = max(Rho); % In this step we found that maximum similarity is for 'C'th patch. and thus we have to
            % inpaint that Patch first
%                %% FOR CHECKING ONLY
% if (sum(isnan(C))>0)
%     Rho;
% end
            
            x = PeeledCordinates_Fillfront(Ind,1);                y = PeeledCordinates_Fillfront(Ind,2);    
            Zp1     =   x-floor(P/2); Zp2  =   x+floor(P/2);
            Zq1     =   y-floor(Q/2); Zq2  =   y+floor(Q/2); 
            Psip = PeeledPatches(:,:,Ind);
            clear temp
            temp = Patchfunction(InpaintedImage,NeighbouringPix{1,Ind}(:,:),P,Q,mi,ni);
            Wpp = WPPj(Pn,Qn,Psip,temp,ImageMask(Zp1:Zp2, Zq1:Zq2));
            [B IX] = sort(Wpp);
            clear i
            i = 0;
            N = 25;
            epsNew = P*Q*25;%P*Q*25*10^20;
            epsOld = epsNew+1;%epsNew*10;
            PsiTval = PsiT(ImageMask(Zp1:Zp2, Zq1:Zq2),PeeledPatches(:,:,Ind),temp,Wpp);
            
            
            InpaintFlag =1;
            InpaintCount = 0;
%%%%%%%%%%%%%%%%    Inpainting the selected patch is done in the following while loop  %%%%%%%%%%%%%%%%%%%%%%%%%%%%            
            
%             while(i<N && epsNew<epsOld)
              while(InpaintFlag)
                  InpaintCount =InpaintCount + 1;
                Xg = [];
                epsOld = epsNew;
                i = i+1;
                for k = 1 :i
                    DPsi = Dmatrix(temp(:,:,IX(k)),ImageMask(Zp1:Zp2, Zq1:Zq2));
                    Xg = [Xg DPsi];
                end
                GramMat = GramMatrix(PsiTval,Xg,i);
                Alphaval = Alpha(GramMat,i);
                result = zeros(size(temp(:,:,IX(1))));
                for k = 1 : length(Alphaval)
                    result = result+(Alphaval(k).*temp(:,:,IX(k)));
                end
                Dtemp = Dmatrix(result,ImageMask(Zp1:Zp2, Zq1:Zq2));
                epsNew = Epsilon(Dtemp,PsiTval);
%                 epsNew
                if (InpaintCount >N && epsNew<epsOld || epsNew<5)
%                     InpaintCount
                    InpaintFlag = 0;
                end
                
                
            end
            InpaintedImage(Zp1:Zp2, Zq1:Zq2)=double(InpaintedImage(Zp1:Zp2, Zq1:Zq2))+double(result(:,:).*(~ImageMask(Zp1:Zp2, Zq1:Zq2)));
            
            %% CLEAR elements
%             imshow(InpaintedImage);
%             input('Helloo...');
                


            clear Rho result Xg Psitval  Wpp Psip
             %% Mask Check
  
        ImageMask(Zp1:Zp2, Zq1:Zq2) = 1;
             MskChk = InpaintedImage(Zp1:Zp2, Zq1:Zq2)>0;
            if sum(sum(MskChk))<P*Q
              ImageMask(Zp1:Zp2, Zq1:Zq2) = ImageMask(Zp1:Zp2, Zq1:Zq2).*MskChk;
            end
            
%% FORM NEW MASK AFTER IN-PAINTING 

%%%%%% This is for updating the infromation about the filled pixels in the
%%%%%%%%%%%%%%%%%%%%%%%%%%% previos steps %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        clear PeeledCordinates_Fillfront PeeledPatches NeighbouringPix
        PeeledCordinates_Fillfront = onionPeel(ImageMask,mi,ni);
        if (length(PeeledCordinates_Fillfront)==0)
            Flag =0;
        else
        PeeledPatches = Patchfunction(InpaintedImage,PeeledCordinates_Fillfront,P,Q,mi,ni);
        LengthOfPeelCord = size(PeeledCordinates_Fillfront,1);
         NeighbouringPix = Neighbours(Pn,Qn,mi,ni,PeeledCordinates_Fillfront,ImageMask); %  Neighbouring pixel
         LengthOfNeighPix = size(NeighbouringPix);
        end
        end
        
        
        %%
%         InpaintedImage = Image ;
%         InpaintedImage(x1:x2,y1:y2,:)= 0;
%         figure; imshow(InpaintedImage); title('Inpainted Image');
    case(3)
        n1 = 1;
        while (n1)
                choice1 = menu('choose the image to be displayed','original Image',...
                                  'Tampered Image','Inpainted Image','Load the image','Exit');
                              switch (choice1)
                                  
                                  case 1
                                      if exist('Image','var') == 0;
                                          disp('The required Image doest not exist');
                                      else
                                            imshow(Image); title('Loaded Image');
                                      end
                                      if exist('GrayImage','var') == 0;
                                          disp('The required Image doest not exist');
                                      else
                                          figure
                                            imshow(GrayImage); title('Gray scale version of Loaded Image');
                                      end
                                      
                                       case 2
                                      if exist('TamperedImage','var') == 0;
                                          disp('The required Image doest not exist');
                                      else
                                            imshow(TamperedImage); title('Tampered Image');
                                      end
                                      
                                  case 3
                                      if exist('InpaintedImage','var') == 0;
                                          disp('The required Image doest not exist');
                                      else
                                                imshow(InpaintedImage); title('Inpainted Image');
                                      end
                                      
                                  case 4
                                      break
                                  case 5
                                    n1 = 0;
                              end
        end
    case (4)
        n=0;
end
end