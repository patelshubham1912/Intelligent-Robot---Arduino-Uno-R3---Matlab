%%capturing and canny edge detection
cd H:\IM1
url = 'http://192.168.1.3:8080/shot.jpg';
ss  = imread(url);
FileNum = 101;
fh = image(ss);
while(1)
    if b.BytesAvailable > 0
        d=fscanf(b,'%d');
         if d==1
            disp(d);
            pause(1)
            ss  = imread(url);
            set(fh,'CData',ss);
            drawnow;
            fname = ['Image' num2str(FileNum) '.jpg'];
            imwrite(ss, fname, 'JPG');
            disp(['image saved ' fname]);
            
            
           %  Load reference image, and compute surf features
            
            ref_img = imread(fname);
            ref_img_gray = rgb2gray(ref_img);
            ref_pts = detectSURFFeatures(ref_img_gray);
            [ref_features,  ref_validPts] = extractFeatures(ref_img_gray,  ref_pts);

            figure; imshow(ref_img);
            hold on; plot(ref_pts.selectStrongest(50));
            cd H:\IM
            srcFiles = dir('H:\IM\*.jpg');  % the folder in which ur images exists
            b=0;
            for i = 1 : length(srcFiles)
                
                  filename = strcat('H:\IM\',srcFiles(i).name);
                  image = imread(filename);
                  % Compare to video frame
                  I = rgb2gray(image);

                 % Detect features
                  I_pts = detectSURFFeatures(I);
                  [I_features, I_validPts] = extractFeatures(I, I_pts);
                  figure;imshow(image);
                   hold on; plot(I_pts.selectStrongest(50));
                   
                   % Compare card image to video frame
                    index_pairs = matchFeatures(ref_features, I_features);

                    ref_matched_pts = ref_validPts(index_pairs(:,1)).Location;
                    I_matched_pts = I_validPts(index_pairs(:,2)).Location;
                    if(ref_matched_pts>0 & I_matched_pts>0)
                        disp('a');
                        a=1;
                        disp(a);
                        fwrite(b,a,'int');
                        break;
                    else 
                            b=b+1;
                            disp(b);
                            if b==length(srcFiles)
                        disp('b');
                        a=2;
                        disp(a);
                       fwrite(b,a,'int');
                            end
                    end

                    figure, showMatchedFeatures(image, ref_img, I_matched_pts, ref_matched_pts, 'montage');
                    title('Showing all matches');
            
            end
            FileNum = FileNum + 1;
            d=2;
         end
     end
    
end
    
    %{
    I=imread('Image1.jpg');
    BW = im2bw(I, 0.5);
    BW1=edge(BW,'canny');
    figure,imshow(BW1);
    fname1 = strcat('Image',num2str(i+2),'.jpg');
    imwrite(BW1,fname1);
 


%% Define Geometric Transformation Objects
gte = vision.GeometricTransformEstimator; 
gte.Method = 'Random Sample Consensus (RANSAC)';

[tform_matrix, inlierIdx] = step(gte, ref_matched_pts, I_matched_pts);

ref_inlier_pts = ref_matched_pts(inlierIdx,:);
I_inlier_pts = I_matched_pts(inlierIdx,:);

% Draw the lines to matched points
figure;showMatchedFeatures(image, ref_img, I_inlier_pts, ref_inlier_pts, 'montage');
title('Showing match only with Inliers');

%% Transform the corner points 
% This will show where the object is located in the image

tform = maketform('affine',double(tform_matrix));
[width, height,~] = size(ref_img);
corners = [0,0;height,0;height,width;0,width];
new_corners = tformfwd(tform, corners(:,1),corners(:,2));
figure;imshow(image);
patch(new_corners(:,1),new_corners(:,2),[0 1 0],'FaceAlpha',0.5);
%}
