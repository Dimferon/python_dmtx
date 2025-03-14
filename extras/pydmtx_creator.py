import colorsys
import os;
from PIL import Image, ImageDraw

class DmCreator(object):
    """docstring for DmCreator."""
    def __init__(self, encodeString, sizeImage:int, foregroundColor: str | tuple[float,...] | None = "black", backgroundColor: str | tuple[float,...] | None = "black"):
        super(DmCreator, self).__init__()
        self.backgroundColor=backgroundColor;
        self.foregroundColor=foregroundColor;
        self.dmtxEncode=dmtxEncodeCreate();#TODO: в sip
        self.encodeString = encodeString;
        self.sizeImage=(sizeImage,sizeImage);
        self.encodeImage = None;

    def __del__(self):
        dmtxEncodeDestroy(self.dmtxEncode);
        super.__del__();

    def SaveImage(self, path, sizeImage, format="BMP"):
        normPath = os.path.normpath(path);
        assert os.chdir(normPath), "Error! Not find save dirs!";
        self.encodeImage.save(normPath, format=format);

    def toImage(self, sizeImage):
        a = 1
        #TODO: Плолучаем из картинку из dmtxEncode

    def renderEncode(self,)->bool:
        """
        Рисуем картинку по данным (dmtxEncode.image) полученным при декодировании
        """
        self.encodeImage=None;
        #TODO: DmtxImage
        image = Image.new('RGB',size=self.sizeImage, color=self.backgroundColor,);
        draw = ImageDraw.Draw(image);
        dmtxImData = self.dmtxEncode.image;
        if dmtxImData==None: #TODO: Добавить условия проверки, цвет размер
            return False;
        width = dmtxImData.width;
        height = dmtxImData.height;

        OFFSET_X = 0;
        OFFSET_Y = 0;
        SCALE_X = self.sizeImage[0] / width;
        SCALE_Y = self.sizeImage[1] / height;

        rowSizeBytes = dmtxImData.rowSizeBytes;
        bytesPerPixel = dmtxImData.bytesPerPixel;
        for y in range(0,height):
            for x in range(0, x):
                b =  dmtxImData.pxl[y * rowSizeBytes  + x * bytesPerPixel];
                if b == 0:
                    draw.rectangle((OFFSET_X + x * SCALE_X, OFFSET_Y + y * SCALE_Y, SCALE_X, SCALE_Y), fill=self.foregroundColor);
        self.encodeImage = image;
        return True;
        

    