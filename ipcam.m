%{
url = 'http://192.168.43.10:8080/shot.jpg';
ss  = imread(url);
fh = image(ss);
while(1)
    ss  = imread(url);
    set(fh,'CData',ss);
    drawnow;
    img=getsnapshot(fh);
    imshow(img);
end
%}
%or

url = 'http://192.168.1.3:8080/shot.jpg';
ss  = imread(url);
FileNum = 1;
fh = image(ss);
while(1)
    if s.BytesAvailable > 0
        d=fscanf(s,'%d');
         if d==1
            disp(d);
            pause(1)
            ss  = imread(url);
            set(fh,'CData',ss);
            drawnow;
            fname = ['Image' num2str(FileNum) '.jpg'];
            imwrite(ss, fname, 'JPG');
            disp(['image saved ' fname]);
            FileNum = FileNum + 1;
            d=2;
          end
     end
    
end

