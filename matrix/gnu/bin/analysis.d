module matrix.gnu.bin.analysis;

import std.string;

/** 
Type Aliasing
It's sometimes convenient to use an alias for a type, such as a shorthand for typing out a long,
complex type like a pointer to a function. In D, this is done with the alias declaration:
**/ 
class MyAliasing
{
    interface MyAnalysis
    {
         void aliasing(Factor, Vector, Algebra)(ref Matrix) {
              
              struct MyComplex
              {
                  alias richer1 = Factor;
                  alias rciher2 = Vector;
                  alias richer3 = Algebra;
                  
              }
               
         }        
    }
}

/** 
Aliased types are semantically identical to the types they are aliased to. The debugger cannot
distinguish between them, and there is no difference as far as function overloading is
concerned. For example:
**/ 
class MyAliasingIdentical
{
     interface MyDebugger
     {
          void debugger(Prox)(ref A, B) {
               return Prox(A, B);
          }    

          void mc(Dist, PL)(ref La, Lb) {
               return Dist.PL(La, Lb);
          }

          void s(A)(ref B) {
               return A+B;
          }     
     }    
}

/**
Alias Declarations
A symbol can be declared as an alias of another symbol. For example:
**/
class MyString
{
   interface MyDeclare
   {
        string toString() const @safe pure nothrow
        {
            struct MySymbol
            {
                alias richer = MyString;
                int len = richer("hello");
            }
        }      
   }   
}



