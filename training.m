%{
url = 'http://192.168.43.10:8080/shot.jpg';
ss  = imread(url);
fh = image(ss);
while(1)GoForward();
    delay(5000);
    ss  = imread(url);
    set(fh,'CData',ss);
    drawnow;
    img=getsnapshot(fh);
    imshow(img);
end
%}

%or
cd H:\IM
url = 'http://192.168.43.1:8080/shot.jpg';
ss  = imread(url);
FileNum = 1;
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
            FileNum = FileNum + 1;
            d=2;
            a=3;
            disp(a);
            fwrite(b,a,'int');
          end
     end
    
end

