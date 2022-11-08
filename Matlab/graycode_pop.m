%P = zeros(Pop_size,n);
%for i=1:Pop_size
     % encode line
     %P(i,:) = bin2gray(dec2bin(x_upscaled(i),n));
     % put to cell array to disp
     %pop = {char(P(:,:)),x_upscaled(:)};

     % Gray code in P corresponds to ASCII char dec numbers - because Matlab (48 = 0, 49 = 1)
     % Can displayed be in cell array - pop{1,1}(i,:), where i is row number from 1 to Pop_size
     % Corresponding num value to gray code is stored in pop{1,2}{i), should be /100 to correspond to values in x
     % To decode to dec values in x use code like: bin2dec(gray2bin('0000000100101010'))/100
     % Getting 1 bit from gray code: pop{1,1}(i,n), where n is bit's position
     
%end