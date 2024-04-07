module matrix.gnu.bin.typefiles;

/** 
Aliased symbols are useful as a shorthand for a long qualified symbol name, or as a way to
redirect references from one symbol to another:
**/
version(Win32):
@syetem:
@files:
extern(D){
    class MyAliased
    {
        interface MyNames
        {
            void names(Obj)(ref A, B) {
                return Obj(A,B);
            }
        }
        
    }
}