function y = Cal_Capsule_Val(args)
    
    global img_Frangi;
    
    y = 1 - img_Frangi(args(2), args(1));

end