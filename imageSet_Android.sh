#!/bin/sh
#本脚本的作用是使用三倍图片产生1倍、2倍图片，以下脚本会产生三个文件夹，
#分别是image1、image2、image3对应Android图片的，hdpi，xhdpi，xxhdpi

ScalePic1x () {
    imageHeight=`sips -g pixelHeight $1 | awk -F: '{print $2}'`
    imageWidth=`sips -g pixelWidth $1 | awk -F: '{print $2}'`

#获取原图片的大小（即宽、高）
    height=`echo $imageHeight`
    width=`echo $imageWidth`

#产生1倍图片的大小，可以修改这个比例产生你满意的规格图片
    height1x=$(($height*4/9))
    width1x=$(($width*4/9))


    imageFile=$1
    sips -z $height1x $width1x $1
}
#产生2倍图大小函数
ScalePic2x () {
    imageHeight=`sips -g pixelHeight $1 | awk -F: '{print $2}'`
    imageWidth=`sips -g pixelWidth $1 | awk -F: '{print $2}'`
    height=`echo $imageHeight`
    width=`echo $imageWidth`

    height2x=$(($height*2/3))
    width2x=$(($width*2/3))

    imageFile=$1

    sips -z $height2x $width2x $1 
}

cd $1
image1=$(basename image1)
image2=$(basename image2)
image3=$(basename image3)
mkdir image1
mkdir image2
mkdir image3
# 1 遍历$1文件夹下的所有文件，即所有图片素材了。
for file in ./*
do

    imageFile=$(basename $file)

    if [  -d $imageFile ];then
    continue
    fi

    cp $imageFile image1/
    cd $image1
    ScalePic1x $imageFile
    cd ..

    cp $imageFile image2/
    cd $image2
    
    ScalePic2x $imageFile
    cd ..
    cp $imageFile image3/
    
done
cd ..