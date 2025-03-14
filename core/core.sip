// Define the SIP wrapper to the core library.

%Module(name=pydmtx.core, language="C", use_limited_api=True)

%DefaultEncoding "UTF-8"

struct DmtxPixelLoc 
{
%TypeHeaderCode
#include<dmtx.h>
%End
   int X;
   int Y;
};