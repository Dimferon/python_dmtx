// Define the SIP wrapper to the core library.

%Module(name=dtmx, language="C" use_limited_api=True)

%DefaultEncoding "UTF-8"

%TypeHeaderCode
#include "dtmx.h"
%End