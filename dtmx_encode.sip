// Define the SIP wrapper to the core library.

%Module(name=pydmtx.core, language="C")

%DefaultEncoding "UTF-8"

func{
 dmtxEncodeCreate

 dmtxEncodeDestroy

 dmtxEncodeSetProp

 dmtxEncodeDataMatrix

 dmtxImageGetProp
}

PyObject *sipConvertFromDmtxMatrix3(void *cpp, PyT)
double[3][3]   DmtxMatrix3     

struct DmtxPixelLoc 
{
%TypeHeaderCode
#include<test_union.h>
   int X;
   int Y;
} 

struct DmtxRegion {

   /* Trail blazing values */
   int             jumpToPos;     /* */
   int             jumpToNeg;     /* */
   int             stepsTotal;    /* */
   DmtxPixelLoc    finalPos;      /* */
   DmtxPixelLoc    finalNeg;      /* */
   DmtxPixelLoc    boundMin;      /* */
   DmtxPixelLoc    boundMax;      /* */
   DmtxPointFlow   flowBegin;     /* */

   /* Orientation values */
   int             polarity;      /* */
   int             stepR;
   int             stepT;
   DmtxPixelLoc    locR;          /* remove if stepR works above */
   DmtxPixelLoc    locT;          /* remove if stepT works above */

   /* Region fitting values */
   int             leftKnown;     /* known == 1; unknown == 0 */
   int             leftAngle;     /* hough angle of left edge */
   DmtxPixelLoc    leftLoc;       /* known (arbitrary) location on left edge */
   DmtxBestLine    leftLine;      /* */
   int             bottomKnown;   /* known == 1; unknown == 0 */
   int             bottomAngle;   /* hough angle of bottom edge */
   DmtxPixelLoc    bottomLoc;     /* known (arbitrary) location on bottom edge */
   DmtxBestLine    bottomLine;    /* */
   int             topKnown;      /* known == 1; unknown == 0 */
   int             topAngle;      /* hough angle of top edge */
   DmtxPixelLoc    topLoc;        /* known (arbitrary) location on top edge */
   int             rightKnown;    /* known == 1; unknown == 0 */
   int             rightAngle;    /* hough angle of right edge */
   DmtxPixelLoc    rightLoc;      /* known (arbitrary) location on right edge */

   /* Region calibration values */
   int             onColor;       /* */
   int             offColor;      /* */
   int             sizeIdx;       /* Index of arrays that store Data Matrix constants */
   int             symbolRows;    /* Number of total rows in symbol including alignment patterns */
   int             symbolCols;    /* Number of total columns in symbol including alignment patterns */
   int             mappingRows;   /* Number of data rows in symbol */
   int             mappingCols;   /* Number of data columns in symbol */

   /* Transform values */
   DmtxMatrix3     raw2fit;       /* 3x3 transformation from raw image to fitted barcode grid */
   DmtxMatrix3     fit2raw;       /* 3x3 transformation from fitted barcode grid to raw image */
} DmtxRegion;

typedef struct DmtxImage_struct {
   int             width;
   int             height;
   int             pixelPacking;
   int             bitsPerPixel;
   int             bytesPerPixel;
   int             rowPadBytes;
   int             rowSizeBytes;
   int             imageFlip;
   int             channelCount;
   int             channelStart[4];
   int             bitsPerChannel[4];
   unsigned char  *pxl;
} DmtxImage;

typedef struct DmtxMessage_struct {
   size_t          arraySize;     /* mappingRows * mappingCols */
   size_t          codeSize;      /* Size of encoded data (data words + error words) */
   size_t          outputSize;    /* Size of buffer used to hold decoded data */
   int             outputIdx;     /* Internal index used to store output progress */
   int             padCount;
   int             fnc1;          /* Character to represent FNC1, or DmtxUndefined */
   unsigned char  *array;         /* Pointer to internal representation of Data Matrix modules */
   unsigned char  *code;          /* Pointer to internal storage of code words (data and error) */
   unsigned char  *output;        /* Pointer to internal storage of decoded output */
} DmtxMessage;

typedef struct DmtxEncode_struct {
   int             method;
   int             scheme;
   int             sizeIdxRequest;
   int             marginSize;
   int             moduleSize;
   int             pixelPacking;
   int             imageFlip;
   int             rowPadBytes;
   int             fnc1;
   DmtxMessage    *message;
   DmtxImage      *image;
   DmtxRegion      region;
   DmtxMatrix3     xfrm;  /* XXX still necessary? */
   DmtxMatrix3     rxfrm; /* XXX still necessary? */
} DmtxEncode;