function draw_tex(tex_id,sRect,angle, color_stim, phase, freq, sc, contrast)
%Screen('DrawTexture', windowPointer, texturePointer [,sourceRect] [,destinationRect] [,rotationAngle] [, filterMode] [, globalAlpha] [, modulateColor] [, textureShader] [, specialFlags] [, auxParameters]);
% %% default value %%
%[,sourceRect]: full texture, <作った texture の一部を切り取って使う場合使う>
%[,destinationRect]: center, <texture を出す場所>
%[,RoutationAngle]: 0 deg = upright, <texture の傾き (deg)>
%[,filterMode]:1, <texture 拡大/縮小表示の際の色の計算: 0:Nearest neighbor, 1:Biliniear,
%2:BL nearest mipmap, 3:Trilinear filtering across mipmap, 4:NN for nearest mipmap
%5:NN with linear interpolation between mipmap levels.
%Mipmap filtering is only supportedfor GL_TEXTURE_2D textures (specialFlags)
%[,globalAlpha]: 1, <透明度:0（透明）~ 1（不透明）の範囲で使用> (alpha-cahnnel も指定してる場合はかけ算される）
%[,modulateColor]: white <指定すると globalAlpha は無視. eg:[128,255,0] だと G-ch と alpha はそのまま. 
%B-ch は 0 かけ算される． R-ch は 128/255 かけ算されて intensity が 50 % になる
%[, textureShader](optional):
%[, specialFlags](optional):
%[, auxParameters](optinoal):
global sobj

switch sobj.pattern
    case {'Sin','Rect'}
        Screen('DrawTexture', sobj.wPtr,tex_id, sRect, sobj.position_cord, angle, [],[],color_stim,[],[], [phase, freq, contrast, 0]);
    case 'Gabor'
        aspectratio = 1;
        Screen('DrawTexture', sobj.wPtr,tex_id, sRect, sobj.position_cord, angle, [],[],color_stim,[],kPsychDontDoRotation, [phase, freq, sc, contrast, aspectratio, 0, 0, 0]);
        %Screen('DrawTexture', sobj.wPtr,tex_id, sRect, sobj.position_cord, angle, [],[],[],[],kPsychDontDoRotation, [phase, freq, sc, contrast, aspectratio, 0, 0, 0]);

end
