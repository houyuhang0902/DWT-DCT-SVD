# 基于多通道的彩色图像水印系统<br>
## 实现功能
  将水印图像嵌入宿主图像中，承受攻击后，再将水印图像提取出来
## 使用方法
  代码基于`Matlab 2018b`实现，所有的代码和测试图片都保存在文件夹DWT-DCT-SVD中。<br>运行gui.m文件使用本系统，接着会弹出一个可视化界面。点击导入宿主图片可进行宿主图片的导入，例如选择文件夹中luna.jpg为宿主图像；点击导入水印图像可进行水印图片的导入，例如选择文件夹中water.jpg为水印图像；点击嵌入水印即可将水印嵌入，弹出框可以选择图像的保存位置；<br>可以点击右上角的下拉菜单选择图像攻击形式，包括JPEG2000攻击、JPEG攻击、噪声攻击、滤波攻击、锐化攻击和直方图均衡化攻击，选定攻击模式后JPEG2000攻击、JPEG攻击、噪声攻击、滤波攻击这四种攻击下方会弹出二级菜单，可以对该攻击的参数进行调整；点击提取水印即可得到提取出的水印图像。
## 联系方式
wechat:hytkshasaki
