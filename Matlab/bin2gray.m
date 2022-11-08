function g = bin2gray(b)
    g(1) = b(1);
    for i = 2 : length(b)
        x = xor(str2double(b(i-1)), str2double(b(i)));
        g(i) = num2str(x);
    end
    if b == 0
        g = dec2bin(0,n);
    end
end
    