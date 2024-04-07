module matrix.gnu.bin.accept;

import std.string;

/** 
Aliasing can be used to 'import' a symbol from an import into the current scope:
**/ 

class MyAccept
{
    interface MyImport
    {
         int opApply(scope int delegate(ref Item) dg)
         {
            int result = 0;
         
            foreach (item; array)
            {
                result = dg(item);
                if (result)
                    break;
            }
         
            return result;
         }        
    }    
}