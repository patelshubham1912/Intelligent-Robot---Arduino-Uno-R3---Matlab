%s=serial('COM3');
%set(s,'BaudRate',9600);
%fopen(s);
%or
b = Bluetooth('HC-05',1);
fopen(b);
%a='b';
%disp(a);
%fwrite(b,a,'uchar');
