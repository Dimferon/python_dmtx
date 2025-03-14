import colorsys
import os;
from PIL import Image, ImageDraw

class DmCreator(object):
    """docstring for DmCreator."""
    def __init__(self, encodeString, sizeImage:int, foregroundColor: str | tuple[float,...] | None = "black", backgroundColor: str | tuple[float,...] | None = "black"):
        super(DmCreator, self).__init__()
        self.backgroundColor=backgroundColor;
        self.foregroundColor=foregroundColor;
        self.dmtxEncode="DtmxEncode";
        self.encodeString = encodeString;
        self.sizeImage=(sizeImage,sizeImage);
        self.encodeImage = None;

    def SaveImage(self, path, sizeImage, format="BMP"):
        normPath = os.path.normpath(path);
        assert os.chdir(normPath), "Error! Not find save dirs!";
        self.encodeImage.save(normPath, format=format);

    def toImage(self, sizeImage):
        a = 1
        #TODO: Плолучаем из картинку из dtmxEncode

    def renderEncode(self,)->bool:
        """
        Рисуем картинку по данным (dtmxEncode.image) полученным при декодировании
        """
        self.encodeImage=None;
        image = Image.new('RGB',size=self.sizeImage, color=self.backgroundColor,);
        draw = ImageDraw.Draw(image);
        dtmxImData = self.dmtxEncode.image;
        if dtmxImData==None: #TODO: Добавить условия проверки, цвет размер
            return False;
        width = dtmxImData.width;
        height = dtmxImData.height;

        OFFSET_X = 0;
        OFFSET_Y = 0;
        SCALE_X = self.sizeImage[0] / width;
        SCALE_Y = self.sizeImage[1] / height;

        rowSizeBytes = dtmxImData.rowSizeBytes;
        bytesPerPixel = dtmxImData.bytesPerPixel;
        for y in range(0,height):
            for x in range(0, x):
                b =  dtmxImData.pxl[y * rowSizeBytes  + x * bytesPerPixel];
                if b == 0:
                    draw.rectangle((OFFSET_X + x * SCALE_X, OFFSET_Y + y * SCALE_Y, SCALE_X, SCALE_Y), fill=self.foregroundColor);
        self.encodeImage = image;
        return True;
        

    