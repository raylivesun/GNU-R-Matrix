# R: News for R Package 'Matrix'
<!DOCTYPE html>
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
<link rel="stylesheet" href="README_files/katex.min.css">
<script type="text/javascript">
const macros = { "\\R": "\\textsf{R}", "\\code": "\\texttt"};
function processMathHTML() {
    var l = document.getElementsByClassName('reqn');
    for (let e of l) { katex.render(e.textContent, e, { throwOnError: false, macros }); }
    return;
}</script>
<script defer="defer" src="README_files/katex.min.js" onload="processMathHTML();"></script>
<link rel="stylesheet" type="text/css" href="README_files/CRAN_web.css">
</head><body><div class="container">

<table style="width: 100%;"><tbody><tr><td>NEWS</td><td style="text-align: right;">R Documentation</td></tr></tbody></table>

<h2 id="NEWS">News for <span class="rlang"><b>R</b></span> Package <span class="pkg">Matrix</span></h2>

<h3>Changes in version 1.6-5 (2024-01-06 r4560)</h3>



<h4>Bug Fixes</h4>


<ul>
<li> <p><code>x[]</code> works for <code>x</code> inheriting from virtual class
<code>sparseVector</code>.
</p>
</li>
<li> <p><code>length(x)</code> is always an integer for <code>x</code>
inheriting from virtual class <code>sparseVector</code>.  Truncation
did not occur for <code>x@length</code> of type <code>"double"</code>
equal to or greater than <code>.Machine[["integer.max"]] + 1</code>.
</p>
</li>
<li> <p><code>tril(&lt;n-by-n&gt;, -n)</code> now works again.
</p>
</li>
<li> <p><code>tri[ul](&lt;indMatrix&gt;, k)</code> now works correctly for
<code>k != 0</code>.
</p>
</li>
<li> <p>C API function <code>cholmod_triplet_as_sexp</code>
transposes entries “opposite” the <code>stype</code> when that
is nonzero, following CHOLMOD.
</p>
</li>
<li> <p><code>R_init_Matrix</code> did not register <code>cholmod_defaults</code>,
so calls to the corresponding stub did not work.
</p>
</li></ul>




<h4>Misc</h4>


<ul>
<li> <p><code>%||%</code> is defined in the <span class="pkg">Matrix</span> namespace
only for <span class="rlang"><b>R</b></span> versions less than 4.4.0.
</p>
</li></ul>




<h3>Changes in version 1.6-4 (2023-11-29 r4523)</h3>



<h4>Bug Fixes</h4>


<ul>
<li> <p><code>printf</code> format mismatches detected by R-devel
are fixed in 3 ‘<span class="file">src/*.c</span>’.
</p>
</li>
<li><p> better deprecation message for <code>..2dge()</code>.
</p>
</li></ul>




<h4>Misc</h4>


<ul>
<li><p> Entry point <code>M_chm_triplet_to_SEXP</code>, removed
in <span class="pkg">Matrix</span> version 1.6-2, is restored (as a macro).
It was “covertly” used by package <span class="pkg">Rmosek</span>.
</p>
</li></ul>




<h3>Changes in version 1.6-3 (2023-11-13 r4513)</h3>



<h4>Misc</h4>


<ul>
<li><p> With an <span class="rlang"><b>R</b></span> built with <code>configure</code> option
<span class="option">--disable-long-double</span>, <code>prod(M)</code> now very slightly
differs for two differently classed versions of <code>M</code>.
</p>
</li>
<li> <p><code>checkMatrix()</code> from ‘<span class="file">test-tools-Matrix.R</span>’ gets
optional <code>MSG</code> argument for suppressing <code>prod()</code> differences.
</p>
</li></ul>




<h3>Changes in version 1.6-2 (2023-11-05 r4503)</h3>



<h4>Significant User-Visible Changes</h4>


<ul>
<li><p> Methods for generic functions <code>rbind2</code>, <code>cbind2</code>,
<code>%*%</code>, <code>%&amp;%</code>, <code>crossprod</code>, and <code>tcrossprod</code>
determine the class of the result using more strict rules,
designed to avoid “surprising” coercions where possible.
Notably, operations involving <code>RsparseMatrix</code> now return
an <code>RsparseMatrix</code> in more cases.  <code>TsparseMatrix</code> and
<code>diagonalMatrix</code> may be handled as <code>CsparseMatrix</code> or as
<code>RsparseMatrix</code>, depending on context.
</p>
</li></ul>




<h4>New Features</h4>


<ul>
<li><p> New <span class="rlang"><b>R</b></span> function <code>Matrix.Version</code>, taking no arguments
and returning <code>list(package, abi, suitesparse)</code>, a list
containing the numeric versions of the package, its ABI, and the
internal SuiteSparse library.  ABI versioning is new: the version
is 1 in this release and will be incremented by 1 in each future
release that changes the ABI. Versions and their components are
defined in a header for use by packages with <code>LinkingTo: Matrix</code>
in ‘<span class="file">DESCRIPTION</span>’.  See ‘<span class="file">inst/include/Matrix/version.h</span>’.
</p>

</li>
<li><p> New nonvirtual class <code>ndiMatrix</code>, extending virtual
classes <code>diagonalMatrix</code> and <code>nMatrix</code>, for nonzero
pattern diagonal matrices.  It is used to represent the result
of <code>is.na</code>, <code>is.nan</code>, <code>is.infinite</code> applied to
<code>diagonalMatrix</code>, as well as diagonal boolean products.
Coercions <code>as(&lt;diagonalMatrix&gt;, "nMatrix")</code> now give
<code>ndiMatrix</code> instead of <code>ntCMatrix</code>.  The latter can
for now still be obtained by coercing to <code>nsparseMatrix</code>
instead of <code>nMatrix</code>.
</p>
</li>
<li><p> New C-level validity methods for <code>sparseVector</code> and
<code>[nlidz]sparseVector</code>, now requiring <code>length</code> not
exceeding <code>2^53</code>, which on most platforms is the maximum
integer representable exactly as <code>double</code>.
</p>
</li>
<li> <p><code>mean(&lt;sparseVector&gt;, trim=)</code> now works efficiently
for nonzero values of <code>trim</code>.
</p>
</li>
<li> <p><code>rep(&lt;sparseVector&gt;, each=)</code> now works efficiently,
avoiding <code>rep(., times = rep(each, times = length(.)))</code>.
</p>
</li>
<li> <p><code>.m2dense</code> and <code>.m2sparse</code> gain an argument
<code>trans</code> indicating if vectors that are not matrices should
be coerced to 1-row matrices rather than 1-column matrices.
</p>
</li>
<li> <p><code>.m2dense</code> and <code>.m2sparse</code> can be called
with one argument.  Their <code>class</code> arguments admit new
default values <code>".ge"</code> and <code>".gC"</code>.
</p>
</li>
<li> <p><code>.diag2dense</code> and <code>.diag2sparse</code> gain an
argument <code>kind</code> indicating the “kind” of the
result.
</p>
</li>
<li><p> New exports <code>.M2V</code> and <code>.m2V</code>, for coercing
<code>Matrix</code> and <code>matrix</code> (and in fact <code>vector</code>)
to <code>sparseVector</code>.
</p>
</li>
<li><p> New exports <code>isUniqueT</code> and <code>asUniqueT</code>, with
optional argument <code>byrow</code> allowing for row-major ordering
of entries.  <code>asUniqueT</code> supercedes <code>uniqTsparse</code>,
which is no longer documented.
</p>
</li>
<li><p> New export <code>aggregateT</code>, for aggregating
<code>TsparseMatrix</code> <em>without</em> sorting.
</p>
</li>
<li><p> Methods for <code>all.equal</code> now report the packages
where S4 classes are defined.
</p>
</li>
<li> <p><code>sum(x)</code> and <code>prod(x)</code> no longer require a
coercion from <code>symmetricMatrix</code> to <code>generalMatrix</code>.
Results where coercions are now avoided may differ numerically
due to reordering of adds and multiplies, most commonly on
systems where <code>sizeof(long double) == sizeof(double)</code>.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> Methods for <code>cbind2</code> and <code>rbind2</code> did not in all
cases handle vectors as 1-column and 1-row matrices, respectively.
</p>
</li>
<li><p> Methods for <code>cbind2</code> and <code>rbind2</code> did not handle
0-length vectors (including <code>NULL</code>) correctly where the result
would have 0 rows and columns, respectively.
</p>
</li>
<li><p> Methods for <code>cbind2</code> and <code>rbind2</code> did not handle
<code>NA</code> in the <code>x</code> slot of <code>ndenseMatrix</code> correctly
(i.e., as <code>TRUE</code>).
</p>
</li>
<li> <p><code>cbind2(&lt;ndenseMatrix&gt;, &lt;ldenseMatrix&gt;)</code> gave
<code>ngeMatrix</code> instead of <code>lgeMatrix</code>.
<code>cbind2(&lt;lsparseMatrix&gt;, &lt;lsparseMatrix&gt;)</code> gave
<code>dgCMatrix</code> instead of <code>lgCMatrix</code>.
Methods for <code>rbind2</code> had similar problems.
</p>
</li>
<li> <p><code>rcond(&lt;0-by-0&gt;)</code> now returns <code>Inf</code>; see <a href="https://bugs.r-project.org/show_bug.cgi?id=18543">PR#18543</a>.
</p>
</li>
<li> <p><code>round(&lt;dp[op]Matrix&gt;)</code> and <code>signif(&lt;dp[op]Matrix&gt;)</code>
now return <code>ds[yp]Matrix</code> rather than <code>dp[op]Matrix</code> and
now discard <code>factors</code>.
</p>
</li>
<li><p> Methods for <code>length</code> now return <code>integer</code> rather
than <code>double</code> if the result does not exceed <code>INT_MAX</code>.
</p>
</li>
<li> <p><code>dsparseVector</code> with <code>x</code> slot of type
<code>integer</code> are now formally invalid, as always intended.
</p>
</li>
<li><p> Methods for subscripting <code>sparseVector</code> did not behave
compatibly with <span class="pkg">base</span> when supplied with fractional, <code>NA</code>,
or out-of-bounds subscripts.
</p>
</li>
<li> <p><code>symmpart(x)</code>, <code>skewpart(x)</code>,
<code>band(x, k1, k2)</code>, <code>triu(x, k)</code>, and
<code>tril(x, k)</code> now always return a <code>.diMatrix</code>
for <code>x</code> inheriting from <code>diagonalMatrix</code>.
</p>
</li>
<li> <p><code>colSums(&lt;(n|l|ind)Matrix&gt;)</code> and
<code>rowSums(&lt;(n|l|ind)Matrix&gt;)</code> now always give a result
of type <code>"integer"</code>.  Methods differed previously,
some giving <code>"double"</code> (as <span class="pkg">base</span> does, suboptimally,
traditional matrices of type <code>"logical"</code>).
</p>
</li>
<li><p> Some methods for generic function <code>lu</code> did not transmit
<code>Dimnames</code> to the result.
</p>
</li>
<li><p> Some methods for group generic function <code>Summary</code>
ignored arguments matching <code>...</code>.  Other methods did
not ignore the “garbage” elements of the <code>x</code> slot
of dense, triangular matrices.
</p>
</li>
<li> <p><code>kronecker(&lt;n.TMatrix&gt;, &lt;diagonalMatrix&gt;)</code> threw
an error for attempting to access the nonexistent <code>x</code> slot
of its first argument.
</p>
</li>
<li><p> Matrix products now behave exactly as <span class="pkg">base</span> when
testing for conformable arguments.
</p>
</li>
<li><p> Numeric products (<code>%*%</code>) did not always return a
<code>dMatrix</code>.
</p>
</li>
<li><p> Methods for <code>all.equal</code> now “see” attributes
of S4 objects that are not slots.  This can be disabled
by setting argument <code>check.attributes</code> to <code>NA</code>,
which is otherwise equivalent to <code>TRUE</code>.
</p>
</li>
<li> <p><code>prod(x)</code> is computed more diligently for <code>x</code>
inheriting from <code>sparseMatrix</code>, <code>sparseVector</code>, or
<code>.t[rp]Matrix</code>, i.e., those <code>x</code> that can be understood
to have “structural” zeros.  Now, multiplication by zero
occurs at the position of the first structural zero in the matrix
or vector (when traversed by row in the case of <code>RsparseMatrix</code>).
An exception is <code>TsparseMatrix</code>, for which multiplication
by zero occurs before multiplication by any stored entry,
regardless of the position of the first structural zero in the
corresponding sorted matrix (to avoid the cost of sorting).
</p>
</li>
<li> <p><code>tri[ul](&lt;.t[rp]Matrix&gt;, k)</code> was often wrong for
nonzero <code>k</code>, setting too many bands to zero.
</p>
</li>
<li><p> C-level <code>tCsparse_diag</code> (formerly <code>diag_tC</code>)
now handles structural zeros and <code>NaN</code> on the main diagonal
correctly.  Option <code>"diagBack"</code> now works correctly.
</p>
</li>
<li><p> The prototype of API function <code>M_cholmod_band_inplace</code>
was wrongly copied from <code>cholmod_band</code>,
instead of from <code>cholmod_band_inplace</code>.
</p>
</li>
<li><p> Many API function prototypes wrongly used <code>const</code>
qualifiers where the registered routines do not.
</p>
</li>
<li> <p><code>expm(x)</code> failed for <code>x</code> of class <code>dtpMatrix</code>
or <code>dspMatrix</code>, since <span class="pkg">Matrix</span> version 1.6-1.
</p>
</li>
<li> <p><code>.m2dense(x, ".ge")</code> allocated unnecessarily
for <code>x</code> without attributes.
</p>
</li></ul>




<h4>Misc</h4>


<ul>
<li><p> C code now refers to the symbol <code>factors</code> as
<code>Matrix_factorsSym</code>, rather than <code>Matrix_factorSym</code>.
</p>
</li>
<li><p> Certain never or seldom used class unions are removed.
</p>
</li>
<li><p> The content of ‘<span class="file">src/Mutils.[ch]</span>’ has been migrated
to more transparently named files: ‘<span class="file">src/attrib.[ch]</span>’,
‘<span class="file">src/objects.[ch]</span>’, etc.
Similarly, much of ‘<span class="file">src/factorizations.[ch]</span>’ have been
migrated to ‘<span class="file">src/solve.[ch]</span>’ and ‘<span class="file">src/determinant.[ch]</span>’.
</p>
</li>
<li><p> All matrix product code has been migrated to
‘<span class="file">products.[Rch]</span>’.
</p>
</li>
<li><p> Files in ‘<span class="file">po/</span>’ and ‘<span class="file">inst/po/</span>’ have been updated
due to more frequent use of <code>gettextf</code> in ‘<span class="file">R/*.R</span>’.
</p>
</li>
<li><p> C code is prepared to handle complex matrices and their
factorizations.  Notably, new machinery in ‘<span class="file">src/cs-etc.[ch]</span>’
will enable linking the CXSparse library instead of the CSparse
library, the latter supporting numeric types but not complex ones.
</p>
</li>
<li><p> Some API declarations and macros not used by <em>any</em>
reverse <code>LinkingTo</code> are removed or remapped.
</p>
</li>
<li><p> API headers are now nested under ‘<span class="file">inst/include/Matrix/</span>’
for better namespacing.  Where possible, packages should start to
use <code>LinkingTo: Matrix (&gt;= 1.6-2)</code> and include files from the
new subdirectory, e.g., with <code>#include &lt;Matrix/Matrix.h&gt;</code>.
</p>
</li>
<li><p> Users including API headers can define macro
<code>R_MATRIX_INLINE</code>,
typically with <code>#define R_MATRIX_INLINE inline</code>,
to allow the compiler to inline stubs for registered routines.
</p>
</li>
<li> <p><span class="pkg">Matrix</span> did not pass its checks under <span class="rlang"><b>R</b></span> 3.5.0,
implicitly violating <code>Depends: R (&gt;= 3.5.0)</code>.  This release
restores compatibility.
</p>
</li></ul>




<h3>Changes in version 1.6-1.1 (2023-09-08)</h3>



<h4>Misc</h4>


<ul>
<li><p> Export the generics <code>crossprod()</code> and <code>tcrossprod()</code>
explicitly, needed for R-devel when they become primitive internal
generics.
</p>
</li></ul>




<h3>Changes in version 1.6-1 (2023-08-11 r4228)</h3>



<h4>New Features</h4>


<ul>
<li><p> Several new coercion utilities, exported and documented
in <code>help("fastMisc")</code>.  Some of these supercede ones made
available (experimentally) in <span class="pkg">Matrix</span> 1.5-4; for example,
<code>.M2m</code> makes both <code>.dense2m</code> and <code>.sparse2m</code>
redundant.  The superceded ones are not yet formally deprecated,
but are no longer documented.
</p>
</li>
<li> <p><code>drop0</code> is now implemented independently
of <code>CHOLMOD</code>, becoming more efficient notably for
logical arguments, no longer requiring a coercion to double.
</p>
</li>
<li> <p><code>drop0</code> gains an argument <code>give.Csparse</code>
to complement <code>is.Csparse</code>.  <code>FALSE</code> indicates
that <code>RsparseMatrix</code>, <code>TsparseMatrix</code>, and
<code>indMatrix</code> arguments should be handled directly,
without a coercion to <code>CsparseMatrix</code>.  The default
value is <code>TRUE</code>, for backwards compatibility.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> Fix four Valgrind-detected memory bugs.
</p>




</li>
<li> <p><code>&lt;diagonalMatrix&gt; %*% &lt;RsparseMatrix&gt;</code> works again.
</p>
</li>
<li> <p><code>diag(&lt;non-square RsparseMatrix&gt;) &lt;- value</code>
works again, no longer giving a <code>p</code> slot of length
<code>Dim[2]</code> rather than <code>Dim[1]</code>.
</p>
</li>
<li> <p><code>as(&lt;diagonalMatrix&gt;, "symmetricMatrix")</code> now checks
for symmetric <code>Dimnames</code>, for consistency.
</p>
</li>
<li><p> as(&lt;indMatrix&gt;, "[nld](sparse)?Matrix") now returns
a <code>.gRMatrix</code> or a <code>.gCMatrix</code> depending on the
<code>margin</code> slot.
</p>
</li>
<li> <p><code>as(&lt;[CR]sparseMatrix&gt;, "generalMatrix")</code> now checks
if the number of nonzero entries in the result would exceed
<code>INT_MAX</code> and throws an error in that case.
</p>
</li>
<li><p> Validity checks on the <code>perm</code> slot of classes
<code>Cholesky</code> and <code>pCholesky</code> have been enabled
(forgotten in <span class="pkg">Matrix</span> 1.6-0).
</p>
</li>
<li><p> API C function <code>chm_sparse_to_SEXP</code> now sorts and
packs its first argument <em>before</em> assigning struct members
to variables, no longer accessing blocks of memory freed by
<code>cholmod_sort</code>.
</p>
</li></ul>




<h4>Misc</h4>


<ul>
<li><p> Run speed-measuring tests only <code>if(doExtras)</code>:
these were too slow when run under Valgrind.
</p>
</li>
<li><p> Most coercion code has been migrated to ‘<span class="file">coerce.[Rch]</span>’
from elsewhere.
</p>
</li>
<li><p> The number of methods for generic functions <code>coerce</code>
and <code>as.*</code> has been reduced substantially, from 306 to 194
(not counting deprecated ones), partly as a result of efforts to
do more fine-grained dispatch in C code.
</p>
</li>
<li><p> Files in ‘<span class="file">po/</span>’ and ‘<span class="file">inst/po/</span>’ have been updated
(again), as many more C level messages now use format strings
as a result of <code>vsnprintf</code> usage in ‘<span class="file">src/validity.c</span>’.
</p>
</li></ul>




<h3>Changes in version 1.6-0 (2023-06-30 r4125)</h3>



<h4>Significant User-Visible Changes</h4>


<ul>
<li><p> Class <code>indMatrix</code> gains a <code>margin</code> slot with value
<code>1L</code> or <code>2L</code> (<code>1L</code> being the prototype and
previously implicit value), indicating that the object represents
a row or column index matrix, with ones at <code>[i, perm[i]]</code> or
<code>[perm[j], j]</code>, respectively.
<br>
Methods with <code>indMatrix</code> or its subclass <code>pMatrix</code>
in the signature have been adjusted to account for the new slot.
Notably, multiplication on the right by an <code>indMatrix</code> with
<code>margin = 2</code> is now implemented as a column subscript, and
the transpose of an <code>indMatrix</code> is now the same object but
with “opposite” <code>margin</code>.
</p>
</li>
<li><p> Virtual class <code>MatrixFactorization</code> gains a
<code>Dimnames</code> slot.  Now all factorizations preserve the
<code>Dimnames</code> of the original, factorized <code>Matrix</code>,
whereas previously classes <code>Schur</code>, <code>sparseLU</code>,
<code>sparseQR</code>, <code>dCHMsimpl</code>, and <code>dCHMsuper</code> did
<em>not</em>.
Users can get the value of the new <code>Dimnames</code> slot with
<code>dimnames(.)</code> and set it with <code>dimnames(.) &lt;- value</code>.
</p>
</li>
<li><p> Classes <code>p?BunchKaufman</code> and <code>p?Cholesky</code> no
longer extend <code>dtrMatrix</code> or <code>dtpMatrix</code> and in turn
no longer extend <code>Matrix</code>.  They retain slots <code>Dim</code>,
<code>Dimnames</code>, <code>uplo</code>, and <code>x</code>, but not <code>diag</code>.
This change implies that virtual classes <code>Matrix</code> and
<code>MatrixFactorization</code> no longer intersect.
</p>
</li>
<li><p> Classes <code>p?Cholesky</code> gain a <code>perm</code> slot with
prototype <code>integer(0L)</code> to support representation of
pivoted factorizations, as typically computed by LAPACK routine
<code>dpstrf</code>.  <code>perm</code> of length 0 is valid and equivalent
to the identity permutation.
</p>
</li>
<li><p> Methods for generic function <code>chol</code> that previously
returned an object of class <code>p?Cholesky</code> now return an
equivalent object of class <code>dtrMatrix</code> or <code>dtpMatrix</code>.
Existing code that relied (correctly) on <code>chol</code> to return
the upper triangular Cholesky factor as a <code>Matrix</code> can be
expected to work as before.
</p>
</li></ul>




<h4>New Features</h4>


<ul>
<li><p> Methods for subscripting <code>Matrix</code> now use the more
systematic code in ‘<span class="file">R/subscript.R</span>’ and
‘<span class="file">src/subscript.c</span>’, becoming more efficient for all
<code>lsparseMatrix</code>
(no longer coercing to <code>dsparseMatrix</code> and back),
sparse <code>symmetricMatrix</code>
(no longer coercing to <code>generalMatrix</code> and back
when <code>i</code> in <code>x[i, i]</code> is monotone),
<code>unpackedMatrix</code>
(no longer coercing to <code>matrix</code> and back), and
<code>RsparseMatrix</code>
(no longer coercing to <code>TsparseMatrix</code>, then to
<code>CsparseMatrix</code>, then back to <code>TsparseMatrix</code> [!]).
<br>
<code>x[i, j, drop = FALSE]</code> preserves the class of <code>x</code>
in more cases where <code>x</code> is a <code>triangularMatrix</code>,
<code>diagonalMatrix</code>, or <code>pMatrix</code>, doing more complete
checks on <code>i</code> and <code>j</code>.
<br>
Notably, for <code>x</code> inheriting from <code>RsparseMatrix</code>,
the result is now always an <code>RsparseMatrix</code>, rather than
always a <code>TsparseMatrix</code>.
</p>
</li>
<li> <p><code>NULL</code> subscripts, as in <code>x[NULL]</code>,
<code>x[NULL, j]</code>, and <code>x[i, NULL]</code>, are now supported
for <code>x</code> inheriting from <code>Matrix</code>.  They are handled
as <code>integer(0)</code>, consistent with <span class="pkg">base</span>.
</p>
</li>
<li><p> New nonvirtual class <code>pcorMatrix</code> extending
<code>dppMatrix</code>.  It is the counterpart of <code>corMatrix</code>
using packed storage, supporting more efficient storage of
dense correlation matrices.  Now <code>pack(&lt;corMatrix&gt;)</code>
gives a <code>pcorMatrix</code> preserving the <code>sd</code> slot,
rather than a <code>dppMatrix</code> without an <code>sd</code> slot.
</p>
</li>
<li><p> New virtual classes <code>BunchKaufmanFactorization</code>,
<code>SchurFactorization</code>, and <code>QR</code>, extended by existing
nonvirtual classes <code>p?BunchKaufman</code>, <code>Schur</code>, and
<code>sparseQR</code>, respectively.  These are parallel to the
existing virtual classes <code>CholeskyFactorization</code> and
<code>LU</code>.  Packages defining new factorization classes may
extend these.
</p>
</li>
<li><p> Virtual class <code>CHMfactor</code> and its subclasses
gain formal validity methods.
</p>
</li>
<li><p> The validity method for class <code>sparseQR</code> now
checks that the <code>V</code> slot is lower trapezoidal and that
the <code>R</code> slot has non-negative diagonal elements.
</p>
</li>
<li><p> New generic functions <code>expand1</code> and <code>expand2</code>,
intended to eventually replace <code>expand</code> and certain coercions
from (subclasses of) <code>MatrixFactorization</code> to (subclasses of)
<code>Matrix</code>.  <code>expand1</code> is used as
<code>expand1(&lt;MatrixFactorization&gt;, &lt;character string&gt;)</code>
and constructs by name factors appearing in the factorization.
<code>expand2</code> is used as <code>expand2(&lt;MatrixFactorization&gt;)</code>
and returns a named list of <em>all</em> factors appearing in the
factorization, in order and with row names on the first factor
and column names on the last factor.  The result can be used to
reconstruct the factorized <code>Matrix</code> as the product of the
elements of the list, namely <code>Reduce(`%*%`, expand2(.))</code>.
<br>
<code>expand</code> and its methods are retained for backwards
compatibility.  They may be formally deprecated in the future,
hence new code should use <code>expand1</code> and <code>expand2</code>.
Notably, <code>expand1</code> and <code>expand2</code> have methods for all
factorizations in <span class="pkg">Matrix</span>, whereas <code>expand</code> continues
to have methods only for <code>denseLU</code>, <code>sparseLU</code>, and
<code>CHMfactor</code>.  See <code>help("expand-methods")</code> for a list
of methods, including useful optional arguments.
</p>
</li>
<li><p> Generic function <code>Cholesky</code> gains methods for
<code>denseMatrix</code> returning an object of class <code>p?Cholesky</code>.
The method for subclass <code>dsyMatrix</code> admits an argument
<code>perm</code> indicating if the pivoted factorization should be
computed.  The corresponding <code>chol</code> method gains an argument
<code>pivot</code> indicating the same.  By default, <code>Cholesky</code>
pivots and <code>chol</code> does not.
</p>
</li>
<li><p> Many subclasses of <code>MatrixFactorization</code> can now be
coerced to “nearby” subclasses of <code>Matrix</code>.
The resulting <code>Matrix</code> reflects the internal representation
of the factorization and not necessarily a particular matrix
factor.  The new coercions are:
<code>as(&lt;denseLU&gt;, "dgeMatrix")</code>,
<code>as(&lt;BunchKaufman&gt;, "dtrMatrix")</code>,
<code>as(&lt;pBunchKaufman&gt;, "dtpMatrix")</code>,
<code>as(&lt;Cholesky&gt;, "dtrMatrix")</code>,
<code>as(&lt;pCholesky&gt;, "dtpMatrix")</code>,
<code>as(&lt;CHMsimpl&gt;, "dtCMatrix")</code>, and
<code>as(&lt;CHMsuper&gt;, "dgCMatrix")</code>.
See <code>help("denseLU-class")</code> (and similar) for details.
</p>
</li>
<li> <p><code>determinant(x, ...)</code> and <code>solve(a, b, ...)</code>
now work for <code>x</code> and <code>a</code> inheriting from
<code>MatrixFactorization</code>, behaving as if <code>x</code> and <code>a</code>
were replaced by the factorized <code>Matrix</code>.  The exception is
<code>x</code> inheriting from <code>CHMfactor</code>, where for backwards
compatibility the default behaviour is still to compute the
determinant of the Cholesky factor.  This exception should be
considered <em>temporary</em>, hence defensive code will call
<code>determinant</code> with (new) optional argument <code>sqrt</code> set to
<code>TRUE</code> or <code>FALSE</code> explicitly, to not rely on the current
default value.  See <code>help("CHMfactor-class")</code> for details.
</p>
</li>
<li><p> Generic function <code>diag</code> gains methods for
<code>p?Cholesky</code> and <code>CHMfactor</code>.  The result
is a numeric vector containing the diagonal entries
of the diagonal matrix <code class="reqn"><span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>D</mi></mrow><annotation encoding="application/x-tex">D</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="base"><span class="strut" style="height: 0.6833em;"></span><span style="margin-right: 0.0278em;" class="mord mathnormal">D</span></span></span></span></code>, as defined in
<code>help("Cholesky-class")</code> and <code>help("CHMfactor-class")</code>.
</p>
</li>
<li><p> The <code>lu</code> and <code>qr</code> methods for class
<code>dgCMatrix</code> now admit an <code>order</code> argument with
value in <code>0:3</code>, allowing the expert user to choose
among all ordering methods made available by the CSparse
library.
</p>
</li>
<li> <p><code>solve(&lt;dgCMatrix&gt;, b, sparse = TRUE)</code> is now
handled entirely in C code via <code>cs_spsolve</code> from the
CSparse library.
</p>
</li>
<li><p> New utilities <code>invertPerm</code>, <code>signPerm</code>,
<code>isPerm</code>, and <code>asPerm</code> for computing the inverse
and sign of a permutation vector, testing if an integer vector
is a permutation vector, and coercing a transposition vector
to a permutation vector.  <code>invertPerm</code> is a more general
version of the already exported function <code>invPerm</code>,
which is retained as a wrapper around <code>invertPerm</code> for
backwards compatibility.
</p>
</li>
<li><p> The <code>qr.R</code> method for class <code>sparseQR</code>
gains a <code>backPermute</code> argument with default <code>FALSE</code>,
for compatibility with <span class="pkg">base</span>.  Function <code>qrR</code>,
which existed primarily to provide a back-permuting option,
is retained for backwards compatibility.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>x[integer(0), ]</code> and <code>x[, integer(0)]</code> now
give a <code>generalMatrix</code> result when <code>x</code> is a 0-by-0
<code>diagonalMatrix</code>, for consistency with all other cases
of <code>x[seq_len(n), ]</code> and <code>x[, seq_len(n)]</code>, where
<code>x</code> is an <code>n</code>-by-<code>n</code> triangular, symmetric,
or diagonal matrix.
</p>
</li>
<li><p> For <code>x</code> inheriting from <code>RsparseMatrix</code>,
subassignment of the form <code>x[i, ] &lt;- value</code> is now
correctly distinguished from <code>x[i] &lt;- value</code>.
</p>
</li>
<li> <p><code>rownames(x[integer(0), , drop = FALSE])</code> and
<code>colnames(x[, integer(0), drop = FALSE])</code> are now always
<code>NULL</code> and never <code>character(0)</code>, consistent with
the implementation in <span class="pkg">base</span>.
</p>
</li>
<li><p> Subscript operations on <code>Matrix</code> now correctly
error whenever the formal argument ... is matched, as
in <code>x[i, j, drop]</code>, where <code>x[i, j, drop = drop]</code>
is almost always intended.
</p>
</li>
<li> <p><code>x[i, ]</code> now correctly drops dimensions when
<code>x</code> is a 1-by-<code>n</code> <code>Matrix</code> and <code>i</code> is
<code>TRUE</code>.
</p>
</li>
<li><p> Methods for <code>solve</code> now obey the following rules
much more strictly:
</p>

<ul>
<li> <p><code>solve(a=&lt;Matrix&gt;, b=&lt;vector&gt;)</code> must return a vector.
</p>
</li>
<li> <p><code>solve(a=&lt;denseMatrix&gt;, b=&lt;Matrix&gt;)</code> must return
a <code>denseMatrix</code>.
</p>
</li>
<li> <p><code>solve(a=&lt;sparseMatrix&gt;, b=&lt;Matrix&gt;, sparse=FALSE)</code>
must return a <code>denseMatrix</code>.
</p>
</li>
<li> <p><code>solve(a=&lt;sparseMatrix&gt;, b=&lt;Matrix&gt;, sparse=TRUE)</code>
must return a <code>sparseMatrix</code>.
</p>
</li></ul>

<p>resolving some longstanding incompatibilities with <span class="pkg">base</span>.
<br>
Note that methods for sparse <code>a</code> and missing or sparse
<code>b</code> have default <code>sparse = TRUE</code>, while methods
for sparse <code>a</code> and dense <code>b</code> have default
<code>sparse = FALSE</code>.
</p>
</li>
<li> <p><code>solve(&lt;symmetricMatrix&gt;)</code> now always gives a
<code>symmetricMatrix</code> result.  <code>solve(&lt;dpoMatrix&gt;)</code>
and <code>solve(&lt;dppMatrix&gt;)</code> preserve formal positive
definiteness, giving a <code>dpoMatrix</code> and <code>dppMatrix</code>,
respectively.
</p>
</li>
<li><p> The prototype of the <code>Dim</code> slot of virtual class
<code>MatrixFactorization</code> is now <code>integer(2L)</code>.
Previously it was <code>integer(0L)</code>, with the result that
<code>validObject(new("&lt;nonvirtual subclass&gt;"))</code> was always
an error.
</p>
</li>
<li><p> The prototype of the <code>L</code> slot of class
<code>sparseLU</code> is now formally lower triangular, so that
<code>validObject(new("sparseLU"))</code> is not an error.
</p>
</li>
<li><p> The prototypes of the <code>Q</code> and <code>T</code> slots
of class <code>Schur</code> are now 0-by-0 <code>dgeMatrix</code>,
so that <code>validObject(new("Schur"))</code> is not an error.
</p>
</li>
<li> <p><code>BunchKaufman(&lt;matrix&gt;)</code> now works when argument
<code>uplo</code> (documented to be optional) is missing.
</p>
</li>
<li><p> The validity method for class <code>corMatrix</code> now
tolerates nonfinite elements in the <code>sd</code> slot.
It no longer tolerates nonunit diagonal elements in the
<code>x</code> slot.
</p>
</li>
<li><p> Coercions to <code>corMatrix</code> now set the diagonal
elements of the result to 1, consistent with <code>cov2cor</code>.
</p>
</li>
<li> <p><code>dimnames(x) &lt;- value</code> now validates <code>x@Dim</code>
before <code>value</code> to avoid undefined behaviour in C-level
check.
</p>
</li>
<li> <p><code>invPerm(p)</code> no longer segfaults for <code>p</code>
that are not valid permutation vectors.  (<code>invPerm(NA)</code>
was enough to trigger a segfault.)
</p>
</li>
<li> <p><code>chol2inv(x)</code> now ignores the lower triangular part
of <code>x</code> not inheriting from <code>triangularMatrix</code>.
</p>
</li>
<li> <p><code>chol2inv(x)</code> now computes <code>crossprod(solve(x))</code>
instead of <code>tcrossprod(solve(x))</code> for all formally lower
triangular <code>x</code>.  Previously, <code>crossprod</code> was used only
for dense <code>x</code>.
</p>
</li>
<li> <p><code>rcond(x, norm)</code> throws a nicer error for <code>x</code>
of length 0.
</p>
</li>
<li><p> Error messages due to invalid <code>norm</code> in
<code>rcond(x, norm)</code> now refer to the argument as <code>norm</code>
rather than <code>type</code>.
</p>
</li>
<li> <p><code>rcond(x, norm)</code> now validates <code>norm</code> also
for <code>x</code> of class <code>d(sy|sp|po|pp)Matrix</code>, even if
for such <code>x</code> all valid <code>norm</code> give the same result.
</p>
</li>
<li> <p><code>which(&lt;[RT]sparseMatrix&gt;, ...)</code> now gives indices
in column-major order in all cases, to be consistent with
<code>help("which")</code>.
</p>
</li>
<li><p> Factorizations inheriting from virtual class <code>LU</code>
are now cached under the name <code>denseLU</code> or <code>sparseLU</code>,
depending on the nonvirtual class, rather than always under
the name <code>LU</code>.  Note that user code should <em>not</em> rely
on the details of the cache and should instead rely on functions
such as <code>lu</code> to retrieve cached factorizations.
</p>
</li>
<li><p> Errors signaled by <code>as(&lt;dsyMatrix&gt;, "dpoMatrix")</code>
and <code>as(&lt;dspMatrix&gt;, "dppMatrix")</code> now clarify that the
coercions do not attempt to test for positive semidefiniteness
when the matrix is not positive definite.
</p>
</li></ul>




<h4>Misc</h4>


<ul>
<li><p> Help pages for matrix factorization classes and methods
have been broadly expanded and updated to use consistent notation.
</p>
</li>
<li><p> C code interfacing the CSparse library now checks in more
places for failed allocations inside of <code>cs_*()</code>.
</p>
</li>
<li><p> The length of the <span class="pkg">Matrix</span> namespace has been reduced
by ~15%.  More than 100 unused symbols have been removed.
</p>
</li>
<li><p> The following dependencies, needed only for a small number
of <code>Rd</code> cross references, have been removed:
<span class="pkg">MatrixModels</span>, <span class="pkg">expm</span>, <span class="pkg">igraph</span>, <span class="pkg">maptools</span>,
<span class="pkg">sp</span>, <span class="pkg">spdep</span>.  Links to CRAN and Bioconductor in
‘<span class="file">.Rd</span>’ files are preserved throughout.
</p>
</li>
<li> <p><span class="pkg">sfsmisc</span> has been moved from <code>Enhances</code> to
<code>Suggests</code>, as <span class="pkg">Matrix</span> does not formally enhance it
by providing methods, etc.
</p>
</li>
<li> <p><span class="pkg">grDevices</span> and <span class="pkg">datasets</span> have been added
to <code>Imports</code> and <code>Suggests</code>, respectively,
as ‘<span class="file">NAMESPACE</span>’ does import from <span class="pkg">grDevices</span>
and vignettes do load data (albeit <em>un</em>conditionally)
from <span class="pkg">datasets</span>.
</p>
</li>
<li><p> Example, test, and vignette code no longer fails when
<span class="env">R_DEFAULT_PACKAGES</span> is set to <code>NULL</code>, thanks to
additional “invisible” <code>library</code> calls in the
problematic source files.
</p>
</li>
<li><p> Examples now use <code>requireNamespace</code> instead of
<code>require</code>, preserving the user search path in more cases.
</p>
</li>
<li><p> Updates to ‘<span class="file">po/*.{po,pot}</span>’ and ‘<span class="file">inst/po/*</span>’ for
translators.
</p>
</li></ul>




<h3>Changes in version 1.5-4.1 (2023-05-16)</h3>




<h4>Misc</h4>


<ul>
<li><p> Use <code>#ifdef PR18534fixed</code> to adapt to <span class="rlang"><b>R</b></span>'s Lapack
header fix for <a href="https://bugs.r-project.org/show_bug.cgi?id=18534">PR#18534</a>.
</p>
</li></ul>




<h3>Changes in version 1.5-4 (2023-04-02 r3837)</h3>



<h4>Deprecated and Defunct</h4>


<ul>
<li><p> The following low level coercion utilities, which were
previously exported but always “hidden” and undocumented,
are now deprecated:
<code>..2dge</code>, <code>.C2nC</code>, <code>.T2Cmat</code>, <code>.asmatrix</code>,
<code>.dense2sy</code>, <code>.diag2mat</code>, <code>.diag2sT</code>,
<code>.diag2tT</code>, <code>.dsy2dsp</code>, <code>.dsy2mat</code>, <code>.dxC2mat</code>,
<code>.m2dgC</code>, <code>.m2lgC</code>, <code>.m2ngC</code>, <code>.m2ngCn</code>,
<code>.m2ngTn</code>, <code>.n2dgT</code>, <code>.nC2d</code>, <code>.nC2l</code>.
<br>
The deprecations follow efforts to define more general and more
systematic (but still fast) coercion utilities, to allow expert
users to bypass S4 dispatch in more cases.  The subset of these
currently exported is documented under <code>help("fastMisc")</code>.
Deprecation warnings will suggest an appropriate replacement,
mostly from that list.
<br>
It is not always the case that the replacement can be
“dropped in”, hence users should consult the relevant
documentation when changing their code.
</p>
</li>
<li><p> Warnings signaled by coercion methods deprecated
in <span class="pkg">Matrix</span> 1.5-0 now correctly inherit from class
<code>deprecatedWarning</code>.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> Defining <code>sequence.default</code> for <span class="rlang"><b>R</b></span> <code>&lt; 4.0.0</code>,
so that <code>kronecker(&lt;CsparseMatrix&gt;, &lt;CsparseMatrix&gt;)</code>,
<code>kronecker(&lt;CsparseMatrix&gt;, &lt;diagonalMatrix&gt;)</code>, and
<code>&lt;diagonalMatrix&gt; %*% &lt;denseMatrix&gt;</code> continue to work
there.
</p>
</li></ul>




<h4>Misc</h4>


<ul>
<li><p> C-level utilities <code>Matrix_memset()</code> and
<code>Matrix_memcpy()</code>, both new, are now used in many places
instead of API macros <code>Memzero()</code> and <code>Memcpy()</code>
which never check for overflow.  C-level macro <code>AZERO()</code>
is no longer defined.
</p>
</li>
<li><p> C-level macro <code>Calloc_or_Alloca_TO()</code> now
zero-initializes also in the <code>alloca</code>-using case.
</p>
</li>
<li><p> Replace deprecated <code>Rdefines.h</code> with
<code>Rinternals.h</code> and move inclusion outside of
<code>extern "C"</code> wrapper in API header
‘<span class="file">inst/include/Matrix.h</span>’.
</p>
</li>
<li><p> Replace <code>sprintf</code> with <code>snprintf</code> globally
to avoid potential buffer overflows.
</p>
</li></ul>




<h3>Changes in version 1.5-3 (2022-11-10 r3772)</h3>



<h4>Bug Fixes</h4>


<ul>
<li> <p><code>dimScale(x)</code> with argument <code>d1</code> missing is no
longer an error.  (The default value had <code>diag(x, FALSE)</code>
instead of <code>diag(x, names = FALSE)</code>.)
</p>
</li>
<li> <p><code>(dim|row|col)Scale(x)</code> is no longer an error for
traditional matrices <code>x</code> without a <code>dimnames</code> attribute.
</p>
</li>
<li><p> Our <code>cov2cor()</code> methods now again preserve (symmetrized!)
<code>dimnames</code>, fixing Matrix bug #6783 reported by Ben Bolker.
</p>
</li>
<li> <p><code>colSums()</code> and friends now always give a <em>named</em>
result when the marginal <code>Dimnames</code> are non-<code>NULL</code>.
(Names were “forgotten” for <code>diagonalMatrix</code> and
<code>indMatrix</code> arguments.)
</p>
</li>
<li> <p><code>colSums()</code> and friends now respect <code>na.rm</code> when
handling <code>diagonalMatrix</code> with <code>NA</code> diagonal entries.
</p>
</li>
<li> <p><code>expand(&lt;denseLU&gt;)</code> now “copies-on-modify”,
no longer duplicating the <code>m*n</code>-length <code>x</code> slot in
the <code>m == n</code> case, when it can be used directly.
</p>
</li>
<li> <p><code>lu(&lt;m-by-0&gt;)</code>, <code>lu(&lt;0-by-n&gt;)</code>, and
<code>BunchKaufman(&lt;0-by-0&gt;)</code> now give sensible (0-extent)
results, rather than a LAPACK error, for <code>denseMatrix</code>.
</p>
</li></ul>




<h4>New Features</h4>


<ul>
<li> <p><code>Diagonal()</code> gets a new optional <code>names</code> argument.
</p>
</li>
<li> <p><code>diag(x) &lt;- value</code> is now done in C also for
<code>[CRT]sparseMatrix</code>.
</p>
</li>
<li> <p><code>.diagU2N()</code> gets fast counterpart <code>.diagN2U()</code>.
</p>
</li>
<li> <p><code>colSums()</code> and friends are now implemented more
efficiently for <code>denseMatrix</code> and <code>[CRT]sparseMatrix</code>.
Notably, methods for triangular and symmetric matrices no longer
go via <code>generalMatrix</code>, and methods for
<code>[CRT]sparseMatrix</code> now handle nonzero pattern and logical
matrices directly (no longer coercing to double, a constraint
of the earlier implementation using CHOLMOD).
</p>
</li>
<li> <p><code>determinant(&lt;ds[yp]Matrix&gt;)</code> is now computed via
the Bunch-Kaufman factorization.  Factorizations are cached in
the <code>factors</code> slot for future reuse.
</p>
</li></ul>




<h4>Misc</h4>


<ul>
<li><p> Package <span class="pkg">methods</span> has been moved from <code>Imports</code>
to <code>Depends</code>, as suggested in the WRE manual.  Now
<code>as()</code> and other basic S4 machinery are available whenever
<span class="pkg">Matrix</span> is attached.  This change affects R processes
started with environment variable <span class="env">R_DEFAULT_PACKAGES</span> set
to <code>NULL</code> (or some list not containing <span class="pkg">methods</span>).
</p>
</li>
<li> <p>‘<span class="file">Simple.R</span>’ test for sparse <code>"POSIXlt"</code> example
adapted to latest R-devel always having <code>"zone"</code> which is
character.
</p>
</li>
<li><p> C-level wrappers for LAPACK <code>d..trf</code> routines gain
an argument <code>warn</code> indicating how to handle <code>info &gt; 0</code>:
<code>warn &lt;= 0</code> is silent, <code>warn = 1</code> is a warning, and
<code>warn &gt; 1</code> is an error.  In the case of <code>dp[op]trf</code>,
for which <code>info &gt; 0</code> implies an incomplete factorization,
<code>info</code> is now returned as a length-1 integer.
</p>
</li></ul>




<h3>Changes in version 1.5-2 (2022-10-21 r3702)</h3>



<h4>Bug Fixes</h4>


<ul>
<li><p> C-level functions now <code>PROTECT()</code> the result of
<code>R_do_slot()</code>, <code>getAttrib()</code>, <code>mkString()</code>, etc.
in many more (but not yet all) places, resolving many new
and some old <code>rchk</code> warnings.
</p>
</li>
<li> <p><code>lu(x)@L@uplo</code> is now <code>"L"</code>, not <code>"U"</code>,
for 0-by-0 and 1-by-1 <code>dgCMatrix</code> <code>x</code>.
</p>
</li>
<li><p> The validity methods for classes <code>l[ts]CMatrix</code>
now correctly test for structurally nonzero entries on the
wrong side of the diagonal, and fail in that case.  This test
was previously only performed for <code>d[ts]Matrix</code>.
</p>
</li>
<li><p> The validity and initialization methods for virtual class
<code>sparseVector</code> are more diligent, i.e., catching more edge
cases such as <code>NA</code> in the <code>length</code> or <code>i</code> slot.
</p>
</li>
<li><p> The validity method for <code>corMatrix</code> now throws a better
error when the <code>sd</code> slot is of type <code>"integer"</code> rather
than <code>"double"</code>.
</p>
</li>
<li> <p><code>.sparseDiagonal()</code> now agrees with <code>Diagonal()</code>
when called with no arguments, returning a 0-by-0 (rather than
1-by-1) diagonal <code>Matrix</code>.
</p>
</li>
<li> <p><code>sparseMatrix(i, j)</code> with 0-length <code>i</code> and
<code>j</code> now returns a 0-by-0 matrix rather than throwing a
perplexing error.
</p>
</li>
<li> <p><code>sparseMatrix(dims = &lt;list&gt;)</code> and
<code>sparseMatrix(x = &lt;dMatrix&gt;)</code> now produce errors.
</p>
</li>
<li> <p><code>diag(x) &lt;- value</code> now coerces <code>diagonalMatrix</code>
<code>x</code> if <code>typeof(value)</code> is “higher” than
<code>typeof(x@x)</code> in the usual hierarchy, for consistency with
methods for <code>denseMatrix</code> and with <code>base::`diag&lt;-`</code>.
</p>
</li>
<li><p> Methods for <code>kronecker()</code> no longer ignore the
<code>make.dimnames</code> argument.
</p>
</li>
<li><p> Printing a <code>sparseMatrix</code> with <code>NA</code> row or column
names is no longer an error.
</p>
</li>
<li><p> Products of two <code>pMatrix</code> objects <code>x</code> and <code>y</code>
are now computed correctly.  Previously, <code>y %*% x</code> was
returned instead of <code>x %*% y</code>!
</p>
</li>
<li><p> Products <code>x %*% y</code> with <code>x</code> a
<code>diagonalMatrix</code> or <code>indMatrix</code> and <code>y</code> a
traditional matrix or vector, or with <code>x</code> a traditional
matrix or vector and <code>y</code> a <code>diagonalMatrix</code>
or <code>pMatrix</code>, now treat the unclassed argument as a
<code>.geMatrix</code> and return a <code>.geMatrix</code>, for greater
consistency with other products involving one <code>Matrix</code>
and one non-<code>Matrix</code>.
</p>
</li>
<li><p> Similarly, <code>kronecker(x, y)</code> with one of <code>x</code> and
<code>y</code> a <code>Matrix</code> and the other a traditional matrix or
vector now treats the unclassed argument as a <code>.geMatrix</code>.
</p>
</li>
<li> <p><code>dimnames(solve(x))</code> is now <code>rev(dimnames(x))</code>
for <code>denseMatrix</code> <code>x</code>, consistent with the handling
of <code>dimnames</code> by <code>solve.default</code>.  Methods for
<code>sparseMatrix</code> <code>x</code> have not been addressed (yet).
</p>
</li></ul>




<h4>New Features</h4>


<ul>
<li> <p><code>is.nan(x)</code> is now implemented for all <code>x</code>
inheriting from virtual class <code>Matrix</code> or <code>sparseVector</code>.
</p>
</li>
<li><p> New C-level validity methods for <code>n[ts][CRT]Matrix</code>,
<code>p?Cholesky</code>, <code>p?BunchKaufman</code>, <code>Schur</code>,
<code>denseLU</code>, <code>sparseLU</code>, and <code>sparseQR</code>.
Notably, in the <code>MatrixFactorization</code> cases, the following
properties are now checked: the dimensions of each factor,
the orientation of each triangular (or trapezoidal) factor, and
the validity of each permutation vector.
</p>
</li>
<li> <p><code>Diagonal(n=, x=)</code> now recycles <code>x</code> of any
positive length to length <code>n</code>.  Previously, recycling was
supported only for <code>x</code> of length 1.
</p>
</li>
<li><p> Products involving <code>diagonalMatrix</code> or <code>indMatrix</code>
have been broadly improved as follows:
</p>

<ul>
<li> <p><code>dimnames(A %*% B)</code> is now always
<code>c(dimnames(A)[1], dimnames(B)[2])</code>.
</p>
</li>
<li> <p><code>t?crossprod()</code> methods involving <code>indMatrix</code>
or its subclass <code>pMatrix</code> gain a <code>boolArith</code> argument.
</p>
</li>
<li><p> Numeric and boolean products are always returned as
<code>dMatrix</code> and <code>nMatrix</code>, respectively, except in
a few special cases where the product can be represented
as an <code>indMatrix</code>.  (Previously, coercions were skipped
when one of the operands was unit diagonal.)
</p>
</li>
<li><p> Products of <code>diagonalMatrix</code> with dense
<code>triangularMatrix</code> now correctly give a
<code>triangularMatrix</code> result (and without unpacking).
</p>
</li>
<li><p> Products of <code>diagonalMatrix</code> with
<code>[RT]sparseMatrix</code> now preserve storage, no longer
coercing to <code>CsparseMatrix</code>.
</p>
</li>
<li> <p><code>crossprod(x, y)</code> no longer requires the product of
<code>ncol(x)</code> and <code>ncol(y)</code> to be less than <code>2^31</code>
when both <code>x</code> and <code>y</code> are <code>indMatrix</code>.  (The
new implementation now always gives a <code>dgTMatrix</code> result,
whereas previously the result would typically but not always
be a <code>dgCMatrix</code>.)
</p>
</li></ul>

</li>
<li> <p><code>kronecker(&lt;Matrix&gt;, &lt;Matrix&gt;)</code> now gives the correct
“shape” (general, [unit] triangular, symmetric, diagonal)
in all cases where it can be known without checking.
</p>
</li>
<li> <p><code>kronecker(&lt;[CR]sparseMatrix&gt;, &lt;Matrix&gt;)</code> now retains
the storage of the first argument, no longer coercing to
<code>TsparseMatrix</code>.
</p>
</li>
<li><p> New exported functions <code>dimScale</code>, <code>rowScale</code>, and
<code>colScale</code>, for scaling rows and columns of a <code>[mM]atrix</code>
without losing <code>dimnames</code> and where appropriate without
losing symmetry.
</p>
</li></ul>




<h3>Changes in version 1.5-1 (2022-09-12 r3642)</h3>



<h4>Bug Fixes</h4>


<ul>
<li><p> ASAN-detected bugs fixed in C-level functions
<code>Tsparse_as_CRsparse()</code>
(triggered by <code>.T2C(&lt;0-by-0&gt;)</code>)
and <code>pMatrix_validate()</code>
(triggered by <code>as(&lt;length-10000 integer&gt;, "pMatrix")</code>).
</p>
</li></ul>




<h3>Changes in version 1.5-0 (2022-09-09 r3636)</h3>



<h4>Deprecated and Defunct</h4>


<ul>
<li><p> With a few exceptions, direct coercions to non-virtual subclasses
of <code>Matrix</code> (e.g., <code>dsCMatrix</code>) have been formally deprecated.
For now, these will continue to work as before, but with a warning
indicating how to accomplish the desired coercion via virtual classes
(e.g., <code>symmetricMatrix</code>) alone.  How such warnings are signaled
is controlled by the global option <code>Matrix.warnDeprecatedCoerce</code>.
</p>

<dl>
<dt><code>0</code> or less</dt><dd><p>is to be silent.</p>
</dd>
<dt><code>1</code></dt><dd><p>is to signal a warning with each deprecated coercion.</p>
</dd>
<dt><code>2</code> or greater</dt><dd><p>is to signal an error with each
deprecated coercion.</p>
</dd>
<dt><code>NA</code></dt><dd><p>is to signal a message or warning (see below)
with the next deprecated coercion and be silent after that.</p>
</dd>
</dl>

<p>If unset or invalid, then the value of the environment variable
<span class="env">R_MATRIX_WARN_DEPRECATED_COERCE</span> (<code>NA</code> if unset) is
used.  This is cached when the <span class="pkg">Matrix</span> namespace is loaded.
<br>
Option values are coerced to integer before use.
<br>
To reduce disruption to existing code, the <code>NA</code> case signals
messages rather than warnings with coercions to the most-used
non-virtual subclasses of <code>Matrix</code>, namely <code>dg.Matrix</code>
and <code>d.CMatrix</code>.  This may change in the future.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> Symmetrization of <code>&lt;Matrix&gt;@Dimnames</code> and
<code>dimnames(&lt;matrix&gt;)</code> now goes through C utility <code>symmDN()</code>
in most places, resolving some earlier inconsistencies.
</p>
</li>
<li><p> Many more validity methods now correctly operate under the
assumption that methods for superclasses have already been called,
eliminating many redundant checks.
</p>
</li>
<li><p> Validation of <code>&lt;Matrix&gt;@Dim</code> now looks at type
<em>before</em> length, avoiding a misleading error message.
</p>
</li>
<li><p> Validation of <code>&lt;Matrix&gt;@Dimnames</code> now avoids
<code>isNewList</code>, which had allowed an error message suggesting
that <code>NULL</code> is a list.
</p>
</li>
<li><p> Setting a factor on a <code>compMatrix</code> is now to install
the factor itself, not a copy, for efficiency and consistency
with the semantics of <code>&lt;compMatrix&gt;@factors[[name]] &lt;- value</code>.
</p>
</li>
<li><p> Long vector support in methods for packing and unpacking
<code>denseMatrix</code>, and others.
</p>
</li>
<li> <p><code>diag&lt;-</code> incorrectly preserved the class of dense matrices,
so that, e.g., <code>`diag&lt;-`(x=&lt;dpoMatrix&gt;, value=-1)</code> was still a
<code>dpoMatrix</code>.  Now the result is always one of the more general
<code>.(ge|tr|sy|tp|sp)Matrix</code>.
</p>
</li>
<li> <p><code>t(&lt;corMatrix&gt;)</code> no longer clears the <code>sd</code> slot.
<code>t(&lt;p?BunchKaufman&gt;)</code> now returns one of the more general
<code>dt[rp]Matrix</code>, rather than preserving class and clearing
the <code>perm</code> slot.
</p>
</li>
<li> <p><code>t(&lt;symmetricMatrix&gt;)</code> no longer reverses the
<code>Dimnames</code> slot.  Symmetrization of <code>dn &lt;- x@Dimnames</code>
and <code>t(x)@Dimnames</code> had given different results when
<code>dn[[1]]</code> and <code>dn[[2]]</code> were non-<code>NULL</code> and
asymmetric.
</p>
</li>
<li> <p><code>isTriangular(x, upper)</code> had incorrectly returned
<code>FALSE</code> for <code>x</code> of class <code>triangularMatrix</code>
when <code>upper = TRUE</code> and <code>x@uplo = "L"</code> or when
<code>upper = FALSE</code> and <code>x@uplo = "U"</code>.
<code>isTriangular</code> is now equivalent to <code>isDiagonal</code>
in those cases.
</p>
</li>
<li> <p><code>isSymmetric()</code> was equivalent to <code>isDiagonal()</code>
for triangular matrices, <em>not</em> allowing numerical fuzz via an
argument <code>tol</code>.  A <code>tol</code> argument is now implemented
for all subclasses of <code>dMatrix</code> except for those inheriting
from <code>symmetricMatrix</code> or <code>diagonalMatrix</code>.
</p>
</li>
<li><p> Methods for <code>isSymmetric</code> now also look at
<code>Dimnames</code> and <code>names(Dimnames)</code>, following
<code>isSymmetric.matrix</code> from <span class="pkg">base</span>.  See also
New Features.
</p>
</li>
<li> <p><code>band(x, -k, k)</code> for sparse <code>x</code> used
<code>isSymmetric(x)</code> (which tolerates numerical fuzz) to test
for symmetry, resulting in loss of information in some cases.
Now it tests that <code>x</code> inherits from <code>symmetricMatrix</code>,
and so returns <code>symmetricMatrix</code> in fewer cases.
</p>
</li>
<li> <p><code>triu(x, k)</code> and <code>tril(x, k)</code> incorrectly
required <code>k &lt;= m</code> (instead of <code>k &lt;= n</code>),
for <code>m</code>-by-<code>n</code> sparse <code>x</code>.  They now accept
all <code>k</code> from <code>-m</code> to <code>n</code>, with fewer errors
in the <code>m &lt; n</code> case.
</p>
</li>
<li> <p><code>crossprod(&lt;Rsparse&gt;, &lt;Tsparse&gt;)</code> and similar now work
again (optional <code>boolArith</code> was not passed on), fixing Matrix
bug #6766 by David Cortes.
Ditto for <code>tcrossprod()</code>, where the old result was even wrong
when it had “worked”, before Matrix 1.2-0.
</p>
</li>
<li> <p><code>as(&lt;matrix&gt;, "nMatrix")</code> can now be sparse <em>or</em>
dense, going via <code>Matrix()</code>, for greater consistency with
coercions to <code>dMatrix</code> and <code>lMatrix</code>.
(Previously, the result was always an <code>ngTMatrix</code>.)
</p>
</li>
<li> <p><code>forceSymmetric(&lt;[RT]sparseMatrix&gt;)</code> are now more
efficient, returning symmetric <code>[RT]sparseMatrix</code> without
intermediate coercions to <code>CsparseMatrix</code>.
</p>
</li>
<li> <p><code>tcrossprod(a, b)</code> for unit triangular sparse matrices
now works correctly.
</p>
</li>
<li> <p><code>!&lt;ltrMatrix&gt;</code> is no longer an error in the 0-by-0
unit diagonal case.
</p>
</li>
<li><p> Coercions among <code>[CRT]sparseMatrix</code> preserve the
<code>factors</code> slot in more cases.
</p>
</li>
<li><p> Coercions of overallocated <code>l.TMatrix</code> to
<code>denseMatrix</code> or <code>CsparseMatrix</code> now give <code>TRUE</code>
instead of <code>NA</code> in the <code>NA || TRUE</code> case, following
conventional logic.
</p>
</li>
<li><p> Methods for unpacking and indexing <code>packedMatrix</code> and
for coercing from <code>[CRT]sparseMatrix</code> to <code>denseMatrix</code>
now check more consistently for overflow of <code>R_XLEN_T_MAX</code>.
</p>
</li>
<li> <p><code>solve(&lt;ddenseMatrix&gt;, &lt;ANY&gt;)</code> is removed from
the method list.  It had allowed infinite recursion, e.g.,
with <code>solve(new("dgeMatrix"), NULL)</code>.
</p>
</li>
<li> <p><code>is.na(&lt;ndenseMatrix&gt;)</code> gave <code>TRUE</code> where
the <code>x</code> slot had <code>NA</code>.  Now the result is always
a zero matrix.
</p>
</li>
<li> <p><code>is.na(&lt;.t[rp]Matrix&gt;)</code> and
<code>is.infinite(&lt;.t[rp]Matrix&gt;)</code> ignored the <code>diag</code> slot,
behaving always as though <code>diag == "N"</code>.  They now give
<code>FALSE</code> on the diagonal in the <code>diag != "N"</code> case.
</p>
</li>
<li><p> Now only “nontrivial” matrix elements determine
whether <code>is.na(&lt;denseMatrix&gt;)</code> is an <code>ndenseMatrix</code>
or an <code>nsparseMatrix</code>.
</p>
</li>
<li> <p><code>is.na(&lt;ddenseMatrix&gt;)</code> coerced to <code>lMatrix</code>.
This unnecessary step is avoided now, saving a potentially
nontrivial allocation.
</p>
</li>
<li> <p><code>solve(&lt;ddenseMatrix&gt;, b)</code> coerced the first argument
to <code>dgeMatrix</code> when <code>b</code> was not a <code>ddenseMatrix</code>
or traditional <code>matrix</code>.  This unnecessary step is avoided now,
so that specialized methods for <code>d(tr|sy|po|tp|sp|pp)Matrix</code>
are used where possible (including for <code>b</code> inheriting from
<code>[ln]denseMatrix</code>, <code>sparseMatrix</code>, or <code>numLike</code>).
</p>
</li>
<li> <p><code>`dim&lt;-`(x, -x@Dim)</code> is now an error, no longer
yielding an invalid <code>Matrix</code> object.
</p>
</li>
<li> <p><code>`dim&lt;-`(x, x@Dim)</code> is now faster, returning <code>x</code>
without allocation in all cases.
</p>
</li>
<li> <p><code>`dim&lt;-`(x, value)</code> gives a better error when
<code>value</code> contains <code>NA</code> or elements exceeding
<code>INT_MAX</code>.
</p>
</li>
<li> <p><code>`dim&lt;-`(&lt;RsparseMatrix&gt;, value)</code> is now an
<code>RsparseMatrix</code>, rather than a <code>TsparseMatrix</code>.
</p>
</li>
<li><p> For consistency with other methods,
<code>symmpart(&lt;diagonalMatrix&gt;)</code> now always inherits from
both <code>dMatrix</code> and <code>symmetricMatrix</code>, and
<code>skewpart(&lt;diagonalMatrix&gt;)</code> now always has symmetric
<code>Dimnames</code>.
</p>
</li>
<li><p> Zeros on the diagonal of <code>skewpart(&lt;[CRT]sparseMatrix&gt;)</code>
are now <em>structural</em>.
</p>
</li>
<li> <p><code>as(&lt;ndenseMatrix&gt;, "(vector|matrix|[dl]Matrix)")</code>
and <code>nnzero(&lt;ndenseMatrix&gt;)</code> now correctly treat <code>NA</code>
in the <code>x</code> slot as <code>TRUE</code>.
</p>
</li>
<li> <p><code>as(&lt;[nl].TMatrix&gt;, "dMatrix")</code> now correctly handles
the overallocated case: data for each unique <code>[i,j]</code>
pair are aggregated logically (<code>x1 || ... || xn</code>) rather than
arithmetically (<code>x1 + ... + xn</code>), so that elements of the
result are restricted to the set <code>c(0, 1, NA)</code>.
This bug had also affected the result of <code>sum(&lt;[nl].TMatrix&gt;)</code>.
</p>
</li>
<li> <p><code>dimnames(as(x, "matrix"))</code> is now <code>NULL</code>
for <em>all</em> <code>x</code> inheriting from <code>Matrix</code>,
when <code>x@Dimnames</code> is the trivial <code>list(NULL, NULL)</code>.
</p>
</li>
<li> <p><code>.bdiag(&lt;named list&gt;)</code> no longer propagates names
to the <code>Dim</code> slot of the result.
</p>
</li>
<li> <p><code>as(&lt;named vector&gt;, "denseMatrix")</code> now correctly
propagates <code>names</code> to the result.
</p>
</li>
<li> <p><code>as(&lt;d.[CR]Matrix&gt;, "lMatrix")</code> no longer drops
non-structural zeros, for greater consistency with analogous
coercions.
</p>
</li>
<li> <p><code>Matrix(x, doDiag)</code> now behaves as documented
for diagonal matrices <code>x</code> with asymmetric <code>dimnames</code>,
returning a <code>diagonalMatrix</code> when <code>doDiag = TRUE</code>,
rather than a <code>triangularMatrix</code>.
</p>
</li>
<li><p> Matrix(&lt;n-dimensional table&gt;) now works for <code>n != 2</code>.
</p>
</li>
<li> <p><code>Matrix(&lt;sparseVector&gt;)</code> now works for vector lengths
other than 1, no longer giving an error about length mismatch
when neither of <code>nrow</code> and <code>ncol</code> are supplied.
</p>
</li>
<li> <p><code>Matrix(&lt;diagonalMatrix&gt;, doDiag = FALSE)</code>
is now a <code>symmetricMatrix</code>, not a <code>diagonalMatrix</code>,
matching the documentation of <code>doDiag</code>.
</p>
</li>
<li> <p><code>Matrix(&lt;.geMatrix&gt;, sparse = TRUE, forceCheck)</code>
and <code>Matrix(&lt;.g[CRT]Matrix&gt;, sparse = FALSE, forceCheck)</code>
now respect <code>forceCheck = FALSE</code> by always returning
<code>generalMatrix</code>, i.e., <em>not</em> testing for symmetric
or triangular structure.
</p>
</li>
<li> <p><code>Matrix(0, nrow, )</code>, <code>Matrix(0, , ncol)</code> now
throw (correct) errors for <code>nrow</code>, <code>ncol</code> in the
interval <code class="reqn"><span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mo stretchy="false">[</mo><mn>0</mn><mo separator="true">,</mo><mn>1</mn><mo stretchy="false">)</mo></mrow><annotation encoding="application/x-tex">[0,1)</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="base"><span class="strut" style="height: 1em; vertical-align: -0.25em;"></span><span class="mopen">[</span><span class="mord">0</span><span class="mpunct">,</span><span class="mspace" style="margin-right: 0.1667em;"></span><span class="mord">1</span><span class="mclose">)</span></span></span></span></code>, consistent with <code>base::matrix()</code>.
</p>
</li>
<li> <p><code>sparseDefault(&lt;sparseMatrix&gt;)</code> now counts zeros
without coercing to <code>matrix</code>,
making <code>Matrix(&lt;sparseMatrix&gt;, sparse = NULL)</code> much more
efficient.
</p>
</li>
<li><p> Methods for group generic <code>Math</code> no longer
preserve <code>x@diag == "U"</code> or lose <code>x@Dimnames</code>
when <code>f(0) == 0</code> and <code>f(1) != 1</code>.
(The former happened for <code>triangularMatrix</code> <code>x</code>
and the latter for <code>diagonalMatrix</code> <code>x</code>.)
</p>
</li>
<li> <p><code>image(Z)</code> for a completely “empty” (all 0)
<code>sparseMatrix</code> works again (?!).
</p>
</li>
<li> <p><code>x[i, ] &lt;- value</code> and <code>y[, j] &lt;- value</code>
is now an error in more cases
for <code>m</code>-by-0 <code>CsparseMatrix</code> <code>x</code>
and 0-by-<code>n</code> <code>CsparseMatrix</code> <code>y</code>.
In these cases, subassignment gave a (formally) invalid result.
</p>
</li>
<li> <p><code>chol(&lt;ds[yp]Matrix&gt;)</code> now calls the underlying
C-level routine exactly once.  Previously, it was called
an extra time in order to test for positive definiteness,
with the result thrown away (!).  Hence these methods should
become approximately two times faster.
</p>
</li>
<li> <p><code>dimnames(chol(x))</code> is identical to <code>dimnames(x)</code>
in all cases, now even when <code>chol(x)</code> is constructed from a
cached <code>MatrixFactorization</code>, for greater consistency with
<code>base::chol.default()</code>.
</p>
</li>
<li> <p><code>chol(&lt;generalMatrix&gt;)</code> no longer looks at
<code>Dimnames</code> when testing for symmetry.
</p>
</li>
<li> <p><code>lu(&lt;dtCMatrix&gt;)</code> no longer returns an invalid
<code>sparseLU</code> object in the lower triangular case.
</p>
</li>
<li> <p><code>lu(x)</code> had sometimes incorrectly cached its
return value as element <code>"lu"</code> (rather than <code>"LU"</code>)
of <code>x@factors</code>.  Now it is always <code>"LU"</code>.
</p>
</li>
<li> <p><code>"Compare"</code> operators, e.g., <code>a &gt; b</code>, <code>x != y</code>,
now work correctly in more dense unitriangular and sparse 0-extent
cases.
</p>
</li>
<li> <p><code>!&lt;nMatrix&gt;</code> is now always an <code>nMatrix</code>, never
an <code>lMatrix</code>.
</p>
</li>
<li> <p><code>!&lt;ndenseMatrix&gt;</code> and <code>which(&lt;ndenseMatrix&gt;)</code>
now correctly handle <code>NA</code> as <code>TRUE</code>.
</p>
</li>
<li> <p><code>anyNA(&lt;denseMatrix&gt;)</code> had incorrectly returned
<code>anyNA(.@x)</code> in many cases, giving false positives
for some <code>.(tr|sy)Matrix</code> and <code>ndenseMatrix</code>.
Now methods respect the “rules” of these classes.
</p>
</li>
<li><p> The boolean arithmetic product <code>A %&amp;% B</code> and e.g.,
<code>crossprod(A, B, boolArith=TRUE)</code> now should behave as if
<code>drop0(A)</code> and <code>drop0(B)</code> were used, i.e., for formally
sparse matrices, the boolean product results should be stable with
respect to non-structural vs structural zeros.
</p>
</li>
<li> <p><code>t(&lt;symmetricMatrix&gt;)</code> now retains the <code>factors</code>
slot, avoiding recomputation.
</p>
</li>
<li> <p><code>qr(&lt;large sparse&gt;)</code> no longer segfaults in some cases,
but now warns about “Out of memory” and stops, fixing Matrix
bug #6610 reported by Benjamin Tyner.
</p>
</li>
<li><p> Fixed <code>&lt;sparse&gt; %*% &lt;dense&gt;</code> possible memory corruption,
visible via valgrind, fixing Matrix bug #6726 reported by David Cortes.
</p>
</li>
<li><p> Fixed the (quite <em>long standing</em>) Matrix bug #6777,
reported by Manuel Koller: <code>tcrossprod(&lt;matrix&gt;, &lt;[dln]sCMatrix&gt;)</code>
has been wrong in some cases.
</p>
</li></ul>




<h4>New Features</h4>


<ul>
<li> <p><code>KhatriRao()</code> gets new <code>sparseY = TRUE</code> option and
also works for more <code>Matrix</code> classes.
</p>
</li>
<li><p> Virtual class <code>packedMatrix</code> gains methods for
<code>pack</code>, <code>unpack</code>, <code>isSymmetric</code>,
<code>isTriangular</code>, and <code>isDiagonal</code> implemented in C,
replacing those defined for many subclasses individually.
</p>
</li>
<li><p> New virtual class <code>unpackedMatrix</code> containing
<code>denseMatrix</code> _without_ <code>packedMatrix</code>, with methods
for <code>pack</code>, <code>unpack</code>, <code>isSymmetric</code>,
<code>isTriangular</code>, <code>isDiagonal</code>, <code>t</code>, <code>diag</code>,
and <code>diag&lt;-</code> implemented in C, replacing those defined for
many subclasses individually.
</p>
</li>
<li> <p><code>isTriangular</code> and <code>isDiagonal</code> are now
implemented in C also for <code>[CRT]sparseMatrix</code> and standard
<code>matrix</code>.  <code>isSymmetric</code> is now implemented in C
for all <code>denseMatrix</code> and all <code>[CRT]sparseMatrix</code>,
though these C routines are currently only called when testing
for <em>exact</em> symmetry (always for <code>[ln]Matrix</code>,
only when <code>tol = 0</code> for <code>dMatrix</code>).
</p>
</li>
<li><p> Methods for <code>isSymmetric</code> gain an argument
<code>checkDN = TRUE</code> indicating whether symmetry of
<code>Dimnames</code> should be checked.  For backwards compatibility
and consistency with <code>isSymmetric.matrix</code> from <span class="pkg">base</span>,
the actual condition is <code>checkDN &amp;&amp; check.attributes</code>.
</p>
</li>
<li> <p><code>isTriangular(x, upper)</code> now has a <code>kind</code>
attribute <em>if and only if</em> <code>x</code> is triangular and
<code>upper</code> is <code>NA</code>.
</p>
</li>
<li> <p><code>diag(&lt;unpackedMatrix&gt;) &lt;- value</code> now behaves like
<code>diag(&lt;packedMatrix&gt;) &lt;- value</code>, supporting coercions
depending on <code>typeof(value)</code>, consistent with <code>diag&lt;-</code>
from <span class="pkg">base</span>.
</p>
</li>
<li> <p><code>pack</code> and <code>unpack</code> are now identity functions
for <code>packedMatrix</code> and <code>unpackedMatrix</code> arguments,
respectively (previously an error).  <code>pack(&lt;.geMatrix&gt;)</code>
(previously an error) now behaves as <code>pack(&lt;matrix&gt;)</code>,
i.e., by checking for symmetry or triangularity before packing.
<code>unpack(&lt;matrix&gt;)</code> now works and is equivalent to
<code>as(&lt;matrix&gt;, "unpackedMatrix")</code>, with result inheriting
from <code>.(ge|tr|sy)Matrix</code>, as appropriate.
</p>
</li>
<li><p> Many more validity methods implemented in C, for efficiency,
including methods for <code>Matrix</code>, <code>compMatrix</code>,
<code>diagonalMatrix</code>, <code>indMatrix</code>, <code>pMatrix</code>,
<code>corMatrix</code>, <code>[liz]Matrix</code>, and <code>ndenseMatrix</code>.
</p>
</li>
<li><p> The validity method of <code>dppMatrix</code> now follows
the validity method of <code>dpoMatrix</code>, requiring non-negative
diagonal elements.
</p>
</li>
<li><p> Validation of <code>&lt;Matrix&gt;@Dimnames[[i]]</code> now tolerates
vector types other than character, which are coerced to character
in C via the new <code>R_DimNames_fixup()</code>, for greater
consistency with base <code>matrix()</code>.
</p>
</li>
<li> <p><code>band(x, k1, k2)</code> is optimized further for both
dense and sparse <code>x</code>, returning <code>triangularMatrix</code>,
<code>symmetricMatrix</code>, and <code>packedMatrix</code> in more cases.
</p>
</li>
<li> <p><code>band()</code> is now implemented also for
<code>diagonalMatrix</code> (only <code>tri[ul]()</code> worked before).
</p>
</li>
<li><p> Coercions <code>.ge&lt;-&gt;.g[CRT]</code>, <code>.t[rp]&lt;-&gt;.t[CRT]</code>,
<code>.s[yp]&lt;-&gt;.s[CRT]</code>, and <code>..[CRT]&lt;-&gt;matrix</code> are now
fully implemented and optimized, with minimal intermediate
allocations.  These (and others) no longer rely on CHOLMOD,
which had handled integer types as double and required
preprocessing in many cases (with <code>diagU2N()</code>, etc.).
</p>
</li>
<li><p> Fixes in group methods (e.g., <code>&gt;</code>, <code>&amp;</code>, <code>|</code>),
notably for matrices inheriting from class <code>symmetricMatrix</code>,
<code>triangularMatrix</code>, <code>lMatrix</code>, or <code>nMatrix</code>.
</p>
</li>
<li> <p><code>as.vector</code>, <code>as.numeric</code>, and <code>as.logical</code>
are now implemented for all <code>Matrix</code>.
</p>
</li>
<li><p> Subassignment to <code>indMatrix</code> is no longer prohibited,
now going via <code>TsparseMatrix</code>.
</p>
</li>
<li> <p><code>indMatrix</code> gains methods for <code>isTriangular</code>,
<code>isDiagonal</code>, <code>diag</code>, <code>diag&lt;-</code>, <code>band</code>,
<code>tri[ul]</code>, and <code>forceSymmetric</code>.  It also gains
coercions to more virtual classes (notably <code>denseMatrix</code>)
and a coercion to <code>pMatrix</code>.
</p>
</li>
<li> <p><code>solve(&lt;ddenseMatrix&gt;, &lt;numLike&gt;)</code> now works in all
cases.
</p>
</li>
<li> <p><code>determinant(&lt;ds[yp]Matrix&gt;)</code> is now much faster
in the positive definite case, no longer going via <code>dgeMatrix</code>.
</p>
</li>
<li> <p><code>diag(&lt;[CRT]sparseMatrix&gt;)</code> is now done in C
and is highly optimized in the <code>.[ts][CR]Matrix</code> case.
</p>
</li>
<li> <p><code>symmpart</code> and <code>skewpart</code> are now done in C
for all <code>denseMatrix</code> and all <code>[CRT]sparseMatrix</code>.
Both now more faithfully preserve the “storage” of
their argument.  (Previously, <code>symmpart(&lt;packedMatrix&gt;)</code>
was an <code>unpackedMatrix</code>,
and <code>(symm|skew)part(&lt;[RT]sparseMatrix&gt;)</code>
was a <code>CsparseMatrix</code>.)
</p>
</li>
<li> <p><code>as(&lt;vector|matrix&gt;, "([dln]?dense|[dlnCRT]?sparse)Matrix")</code>
are now fully and more consistently implemented.  In the vector case,
the result is now always a <code>length</code>-by-1 <code>generalMatrix</code>.
In the matrix case, structure is now always examined, hence the result
is a <code>symmetricMatrix</code> or <code>triangularMatrix</code> in more cases.
</p>
</li>
<li> <p><code>Matrix(&lt;classed matrix&gt;)</code> now works for classes
other than <code>table</code>.
</p>
</li>
<li> <p><code>lu(&lt;dt[rpCRT]Matrix&gt;)</code> and <code>lu(&lt;ddiMatrix&gt;)</code>
now behave more consistently.  In the diagonal, upper triangular,
and unit lower triangular cases, the result is obtained
“directly”, i.e., without pivoting.  In the non-unit
lower triangular case, it is obtained with pivoting.
(Previously, pivoting was never done for <code>dtCMatrix</code>
and always done for <code>dt[rpRT]Matrix</code> and <code>ddiMatrix</code>.)
</p>
</li>
<li> <p><code>lu(x)</code> now caches its return value also for all
<code>ds.Matrix</code> <code>x</code> (by default).
</p>
</li>
<li> <p><code>readMM()</code> now warns if the number of entries found
is less than number reported in the header.
</p>
</li>
<li> <p><code>x[i]</code> now works for <code>nMatrix</code> <code>i</code>,
just as for <code>lMatrix</code> <code>i</code>.  This supports constructions
such as <code>x[is.na(x)]</code>, where the logical operation
produces an <code>nMatrix</code> because it is never <code>NA</code>.
</p>
</li></ul>




<h4>Misc</h4>


<ul>
<li> <p><code>AZERO()</code> and friends gain an argument specifying
a zero constant (0 for <code>int</code> arrays, 0.0 for <code>double</code>
arrays).
</p>
</li>
<li><p> C-level utilities <code>(R_)?[gs]et_factors()</code> have been
renamed <code>(R_)?[gs]et_factor()</code>, as they only ever get and
set <em>one</em> factor.
</p>
</li>
<li><p> The signature of <code>set_factor()</code> has been changed to
match other <code>set*()</code> functions:
to <code>(object,name,value)</code> from <code>(object,value,name)</code>.
</p>
</li>
<li><p> For clarity, <code>set_factor()</code> now returns <code>void</code>
and is used like other <code>set*()</code> functions (i.e., for its
side effect).  The R interface is unchanged: <code>R_set_factor()</code>
continues to return the value being set.
</p>
</li>
<li><p> C-level utilities
<code>make_[di]_matrix_(triangular|symmetric)()</code>,
<code>packed_to_full_(double|int)()</code>,
<code>full_to_packed_(double|int)()</code>, and
<code>install_diagonal(_int)?()</code>
are replaced by safer, more consistently named ones.
Previous versions allowed integer overflow.
</p>
</li>
<li><p> C-level utilities <code>dup_mMatrix_as_d?geMatrix()</code> are
replaced by the more general <code>dense_as_general()</code>, which
takes arguments controlling memory allocation and the
“kind” of the <code>.geMatrix</code> result.
</p>
</li>
<li><p> New C-level utility <code>DimNames_is_symmetric()</code>
with R interface <code>isSymmetricDN()</code>, which should be
used consistently to test for symmetry of <code>[dD]imnames</code>.
Note that these are intended to behave consistently with
<code>symmetricMatrix_validate()</code>,
by allowing, e.g., <code>list(NULL, nms)</code>,
but not, e.g., <code>list(A = NULL, B = nms)</code>.
</p>
</li>
<li><p> Coercions to <code>triangularMatrix</code> and
<code>symmetricMatrix</code> are now almost all inherited from
<code>Matrix</code>, whose methods simply call <code>tri[ul]()</code>
and <code>forceSymmetric()</code> if <code>isTriangular()</code> and
<code>isSymmetric()</code>, respectively, return <code>TRUE</code>.
</p>
</li>
<li><p> Many of the exported <code>.*2*</code> utilities have been
redefined as aliases or wrappers of new, more general functions
(see below).  These not-yet-deprecated functions have been
centralized in ‘<span class="file">R/denseMatrix.R</span>’ and ‘<span class="file">R/sparseMatrix.R</span>’.
</p>
</li>
<li><p> New C-level utilities
<code>R_(dense|sparse)_as_kind()</code>
for coercion from one “kind” to another;
<code>R_(dense|sparse)_as_general()</code>
for coercion from triangular and symmetric to general;
<code>R_(dense|sparse)_band()</code>
for coercion to triangular (and other banded);
<code>R_(unpacked*|packed*|sparse)_force_symmetric()</code>
for coercion to symmetric;
<code>R_(dense|sparse)_as_(sparse|dense)()</code>
for coercion between dense and sparse of the same “kind”
and “structure”;
<code>R_diagonal_as_sparse()</code>
for coercion from <code>diagonalMatrix</code> to any
<code>[CRT]sparseMatrix</code>;
<code>R_(dense|sparse|geMatrix)_as_(matrix|vector)()</code>
for coercion to base matrix and vector; and
<code>tCRsparse_as_RCsparse()</code> for the idioms
<code>as(t(&lt;[CR]sparseMatrix&gt;), "[RC]sparseMatrix")</code>.
These all have not-yet-exported R wrappers.
</p>
</li>
<li> <p><code>indTri()</code> and <code>indDiag()</code> now in C,
with a new argument <code>packed</code> for efficiently indexing
<code>packedMatrix</code>.  <code>indDiag()</code> now behaves sensibly
in the <code>n = 0</code> case.
</p>
</li>
<li> <p><code>.M.kind()</code>, <code>.M.shape()</code>, and (new)
<code>.M.repr()</code> are now done in C via <code>R_check_class_etc()</code>,
requiring a class definition only in “rare” cases.
</p>
</li></ul>




<h3>Changes in version 1.4-1 (2022-03-21 r3446)</h3>



<h4>Bug Fixes</h4>


<ul>
<li> <p><code>diag(x)</code> methods now mostly also keep <code>names</code> from
<code>dimnames(x)</code> by default and obey <code>names=*</code> more generally.
</p>
</li></ul>




<h4>New Features</h4>


<ul>
<li><p> New virtual class <code>packedMatrix</code> containing packed (dense)
symmetric and triangular matrices.  Methods for subscripting,
including <code>diag()</code>, notably keeping names by default and for
<code>t()</code> which are memory efficient, i.e., do not work via
unpacking, thanks to Mikael Jagan.
</p>
</li>
<li><p> New <code>dmperm()</code> implementing a Dulmage-Mendelsohn
decomposition, thanks to the persistency of Mauricio Vargas (@uc.cl).
</p>
</li>
<li><p> Export more low-level conversion utilities:
<code>.n2dgT</code>, <code>.m2ngCn</code>, <code>.m2ngTn</code>.
</p>
</li>
<li><p> Provide some matrix multiplication methods for <code>"RsparseMatrix"</code>.
</p>
</li></ul>




<h4>Misc</h4>


<ul>
<li><p> Our C sources now use <code>R_Calloc()</code>, <code>R_Free()</code>
etc, instead of the shorter versions without 'R_'. Consequently,
we get closer to <code>STRICT_R_HEADERS</code>.
Also, include <code>&lt;float.h&gt;</code> for <code>DBL_EPSILON</code>.
</p>
</li>
<li> <p><code>PROTECT()</code> 3 more; as from ‘<span class="samp">⁠rchk⁠</span>’ for Matrix 1.4-0.
</p>
</li>
<li><p> Slightly better patch notably for Windows,
for ‘<span class="file">src/SuiteSparse_config/SuiteSparse_config.h</span>’
</p>
</li>
<li><p> Fix to continue working for <span class="rlang"><b>R</b></span> 3.5.0 and newer, providing
<code>tryInvokeRestart()</code> for older versions of <span class="rlang"><b>R</b></span>, thanking
Michael Chirico for the heads up.
</p>
</li>
<li><p> Modified <code>AZERO()</code> to work with <code>R_xlen_t</code> and new
<code>AZEROs()</code> for <code>size_t</code>; other tweaks to evade
<code>-Wconversion</code> warnings.
</p>
</li></ul>




<h3>Changes in version 1.4-0 (2021-12-08 r3419)</h3>



<h4>Bug Fixes</h4>


<ul>
<li><p> Update many ‘<span class="file">src/*.c</span>’ preventing integer overflow in
“pointer” and index computations for large (dense) matrices;
prompted by Dario Strbenac's post to R-devel.
</p>
</li>
<li> <p><code>sparse.model.matrix(.., contrasts.arg = &lt;.. ddiMatrix ..&gt;)</code>
now works correctly, fixing R-forge Matrix bug #6673 by Davor Josipovic.
</p>
</li>
<li> <p><code>sparse.model.matrix(..)</code> now also works in cases the
contrast matrix has become a <code>"denseMatrix"</code>; e.g., in a case
using <code>poly(.)</code> in the formula; now works correctly, fixing
R-forge Matrix bug #6657 and useful suggestions by Nick Hanewinckel.
</p>
</li>
<li><p> Fixed the internal <code>attr.all_Mat()</code> auxiliary for
<code>all.equal()</code>, notably for the case when exactly one of the
matrices is a base <code>matrix</code>.
</p>
</li>
<li><p> Fixed long-standing bug in the <code>rbind2()</code> method for
logical dense matrices, specifically <code>"lgeMatrix"</code>, thanks to
the notice by Aaron Lun.
</p>
</li>
<li><p> fix leak in C-level <code>Csparse_to_dense()</code> thanks to Bill
Dunlap in <span class="rlang"><b>R</b></span>'s <a href="https://bugs.r-project.org/show_bug.cgi?id=18204">PR#18204</a> and <code>install_lu()</code>
called from <code>solve(&lt;dgCMatrix&gt;)</code> in <a href="https://bugs.r-project.org/show_bug.cgi?id=18206">PR#18206</a>.
</p>
</li>
<li><p> fix leak in crossprod(&lt;dsTMatrix&gt;), thanks to report and patch
in <a href="https://bugs.r-project.org/show_bug.cgi?id=18205">PR#18205</a> by Bill Dunlap.
</p>
</li>
<li> <p><code>band(M, k1, k2)</code> now also works when <code>k1 * k2</code> is
larger than 2^31-1, the maximal integer, fixing R-forge Matrix bug
#6743 by Ariel Paulson.  Further, it works when <code>M</code> is a sparse
<code>"symmetricMatrix"</code> but the band is not symmetric, <code>k1 != -k2</code>.
</p>
</li>
<li><p> fix leak in C-level code for <code>cbind(m1,m2)</code> or
<code>rbind(*)</code> when <code>m1</code> is <code>"n.Csparse"</code> and <code>m2</code> is
not, thanks to Bill Dunlap's diagnosis and patch in <span class="rlang"><b>R</b></span>'s <a href="https://bugs.r-project.org/show_bug.cgi?id=18210">PR#18210</a>.
</p>
</li>
<li> <p><code>sparseVector(i=integer(), length=2^33)</code> now does show/print,
after fixing a bug in the <code>head()</code> method for <em>empty</em>
sparseVectors.  Reported by David Cortes as Matrix bug #6745.
</p>
</li>
<li><p> inverting or solving <code>dsCMatrix</code> no longer catches C level
warnings too early which would not free, but rather leak memory;
thanks to Bill Dunlap's analysis and patch in <span class="rlang"><b>R</b></span>'s <a href="https://bugs.r-project.org/show_bug.cgi?id=18214">PR#18214</a>.
Additionally, such warnings and error are <code>message()</code>d when
<code>getOption("Matrix.verbose")</code> is <code> &gt;= 1</code>.
</p>
</li>
<li> <p>‘<span class="file">test-tools-1.R</span>’: <code>Sys.memGB()</code> can no longer use
<code>memory.limit()</code> on Windows; no returns <code>NA.value = 2.10201</code>
in such cases.
</p>
</li>
<li> <p><code>ss &lt;-  &lt;sparseVector&gt;[i]</code> gave an invalid sparseVector
<code>ss</code> as <code>ss@i</code> was not necessarily sorted; thanks to a
report by Quran Wu.
</p>
</li>
<li> <p><code>as(&lt;dsyMatrix&gt;, "generalMatrix")</code> and similar, sometimes
did <em>not</em> use (C-level) <code>symmetric_Dimnames()</code> etc; report
(to <span class="rlang"><b>R</b></span>'s <a href="https://bugs.r-project.org/show_bug.cgi?id=18250">PR#18250</a> by  Mikael Jagan); fixed all on C level.  As a
consequence, you will now see <em>more</em> preserved dimnames after
matrix transformations or operations which involved symmetric matrices.
</p>
</li>
<li> <p><code>as(&lt;ddiMatrix&gt;, "matrix")</code> no longer loses dimnames,
thanks to Mikael Jagan's report as Matrix bug #6751.
</p>
</li></ul>




<h4>Misc</h4>


<ul>
<li><p> No longer include ‘<span class="file">Rdefines.h</span>’ as it is somewhat deprecated.
</p>
</li></ul>




<h3>Changes in version 1.3-4 (2021-05-24 r3392)</h3>



<h4>Misc</h4>


<ul>
<li><p> Update <code>matrix(&lt;data&gt;, n,m)</code> in ‘<span class="file">tests/*</span>’ to work with
<code>R-devel CMD check --as-cran</code>
</p>
</li></ul>




<h3>Changes in version 1.3-3 (2021-05-01 r3390)</h3>



<h4>Deprecated and Defunct</h4>


<ul>
<li> <p><code>cBind()</code> and <code>rBind()</code> are now defunct:
simply use <code>cbind()</code> and <code>rbind()</code> instead.
</p>
</li></ul>




<h4>Dependency</h4>


<ul>
<li><p> For now revert to <code>R (&gt;= 3.5.0)</code> dependency to accomodate
users on older R installations.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> Fixed a thinko (in 1.3-2): Now direct coercion from
<code>"ddiMatrix"</code> to <code>"dgCMatrix"</code>, and hence, e.g.,
<code>as(Matrix(1, sparse=TRUE), "dgCMatrix") now works.</code>
</p>
</li>
<li><p> Fixed error message in &lt;dtrMatrix&gt; multiplication.
</p>
</li>
<li><p> Fixed long-standing bug in <code>R[,j] &lt;- v</code> when <code>R</code> is "Rsparse*",
R-forge Matrix bug #6709 by David Cortes.
</p>
</li>
<li> <p>‘<span class="file">./include/cholmod.h</span>’ and ‘<span class="file">./include/Matrix_stubs.h</span>’
needed updating from SparseSuite update; R-forge Matrix bug #6714 by
Kasper Kristensen (TMB pkg).
</p>
</li>
<li> <p><code>as.matrix()</code> and <code>as.array()</code> now work for
<code>"sparseVector"</code>s as expected; see Matrix bug #6708.
</p>
</li>
<li> <p><code>M[,]</code> (and similar) now work as in base <span class="rlang"><b>R</b></span>;
R-forge Matrix bug #6720 by David Cortes.
</p>
</li>
<li> <p><code>-S</code> now works also when <code>S</code> has no 'factors' slot.
It signalled an error, e.g., for sparse triangular matrices <code>S</code>;
R-forge Matrix bug #6656, reported by Chun Fung (Jackson) Kwok.
</p>
</li>
<li> <p><code>M*2</code> and similar no longer keep cached factorizations (in
'factors' slot), but drop them via internal new <code>.empty.factors()</code>.
R-forge Matrix bug #6606, reported by Tomas Lumley.
</p>
</li>
<li><p> removed the nowhere used (and unexported but still active)
class union <code>"Mnumeric"</code> which actually trickled into many base
classes properties.  Notably would it break validity of <code>factor</code>
with a proposed change in validity checking, as factors were also
<code>"Mnumeric"</code> but did not fulfill its validity method.
Similarly removed (disabled) unused class union <code>"numericVector"</code>.
</p>
</li>
<li><p> removed a few duplicated <code>.alias{.}</code> from ‘<span class="file">man/*.Rd</span>’.
</p>
</li></ul>




<h4>Misc</h4>


<ul>
<li><p> translation updates (of outlines only); finally added Italian
(by Daniele Medri) to svn; updated French (by Philippe Grosjean),
forgotten (R part of) Korean.
New Lithuanian translations by Gabriele Stupuriene &amp; Rimantas Zakauskas.
</p>
</li>
<li><p> In internal <code>diagOdiag()</code> method, no longer use
<code>matrix(x, n,n)</code> when <code>x</code> is longer than n*n.
</p>
</li>
<li><p> Update tests/*.R to future <code>matrix(x, n,k)</code> warning in more
mismatch cases.
</p>
</li>
<li><p> Eliminating the need for ‘<span class="file">ftp://*</span>’, add the very small
<code>jgl009</code> MatrixMarket example to our ‘<span class="file">external/</span>’ files.
</p>
</li></ul>




<h3>Changes in version 1.3-2 (2021-01-05 r3362)</h3>



<h4>Bug Fixes</h4>


<ul>
<li> <p><code>rankMatrix()</code> tweaks for the singular values based methods,
notably <code>method = "maybeGrad"</code>.
</p>
</li>
<li> <p><code>as(new("dtCMatrix", diag="U"), "matrix")</code> now works, as
C-level <code>diagU2N()</code> now also works for 0-dimensional triangular
matrices; this also fixes a subsetting (“indexing”) bug of
such 0-dimensional matrices, thanks to a report by Aaron Lun.
</p>
</li>
<li><p> logical subsetting of 0-dim. (diagonal/triangular) matrices
fixes.
</p>
</li>
<li><p> The new <code>FCONE</code> macros added for newer Fortran/C compiler
combinations are now defined back compatibly with R &gt;= 3.6.0.
</p>
</li>
<li> <p><code>chol(&lt;diagonal dt[CRT]Matrix&gt;)</code> now works.
</p>
</li>
<li> <p>‘<span class="file">rchk</span>’: fix potentially un<code>PROTECT</code>ed vars in
‘<span class="file">src/dsyMatrix.c</span>’
</p>
</li></ul>




<h3>Changes in version 1.3-1 (2020-12-23 r3352)</h3>



<h4>Bug Fixes</h4>


<ul>
<li> <p><code>rankMatrix(&lt;dense&gt;, method="qr.R")</code> no longer assumes
non-negative diagonal entries of the <code class="reqn"><span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>R</mi></mrow><annotation encoding="application/x-tex">R</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="base"><span class="strut" style="height: 0.6833em;"></span><span style="margin-right: 0.0077em;" class="mord mathnormal">R</span></span></span></span></code> matrix.
</p>
</li></ul>




<h3>Changes in version 1.3-0 (2020-12-15 r3351)</h3>



<h4>Significant User-Visible Change</h4>


<ul>
<li> <p><code>Matrix(*, doDiag=TRUE)</code> where <code>doDiag=TRUE</code> has
always been the <em>default</em> is now obeyed also in the sparse
case, as all <code>"diagonalMatrix"</code> are also <code>"sparseMatrix"</code>.
</p>
<p><code>Matrix(0, 3,3)</code> returns a <code>"ddiMatrix"</code> instead of a
<code>"dsCMatrix"</code> previously.  The latter is still returned from
<code>Matrix(0, 3,3, doDiag=FALSE)</code>, and e.g., <code>.symDiagonal(3,pi)</code>.
</p>
<p>Also a triangular matrix, e.g., <code>"dtrMatrix"</code> is detected now in
cases with <code>NA</code>s.
</p>
<p>This is both a bug fix <em>and</em> an API change which breaks code
that assumes <code>Matrix(.)</code> to return a <code>"CsparseMatrix"</code> in
cases where it now returns a <code>"diagonalMatrix"</code> (which does
extend <code>"sparseMatrix"</code>).
</p>
</li></ul>




<h4>New Features</h4>


<ul>
<li><p> Subassignment to <code>"diagonalMatrix"</code> now returns
sparse <code>"triangularMatrix"</code> more often; also (sparse)
<code>"symmetricMatrix"</code>.
</p>
</li>
<li> <p><code>nearPD()</code> gets new option: If <code>base.matrix = TRUE</code>,
the resulting <code>mat</code> component is a <span class="pkg">base</span> <code>matrix</code>, as
often used desired when <code>nearPD()</code> is used outside the
<span class="pkg">Matrix</span> package context.
</p>
</li>
<li><p> Factored out new <code>qr2rankMatrix()</code> utility from
<code>rankMatrix()</code>.
</p>
</li>
<li><p> New <code>BunchKaufman(&lt;matrix&gt;)</code> method.
</p>
</li>
<li><p> Added <code>wrld_1deg</code> sparse matrix example to
<em>distributed</em> version of <span class="pkg">Matrix</span> (no longer excluding it
via ‘<span class="file">.Rbuildignore</span>’).
</p>
</li>
<li><p> New (simple) <code>mat2triplet()</code> function to be used instead
of <code>summary(&lt;sparseMatrix&gt;)</code> in code.
</p>
</li>
<li><p> Internal <code>.diag2tT()</code> gains new option <code>drop0 = TRUE</code>
and hence now by default drops zero diagonal entries.  Consequently,
e.g., <code>as(&lt;diagonalMatrix&gt;, "CsparseMatrix")</code> now drops such
zeros, too.
</p>
</li>
<li><p> Updated the crucial underlying C libraries from SuiteSparse,
from 4.2.1 to 5.7.1 (from 2020-02-20), visible in <code>.SuiteSparse_version()</code> .
</p>
</li>
<li> <p><code>sparseMatrix()</code> gets new argument <code>repr = "C"</code>,
superseding the (now deprecated) <code>giveCsparse = TRUE</code>.  Allows
to return <code>"RsparseMatrix"</code> matrices.
</p>
<p>Similarly, <code>rsparsematrix()</code>, <code>fac2sparse()</code> and <code>fac2Sparse()</code>
get the new <code>repr</code> argument and their <code>giveCsparse</code> is
deprecated, sometimes only informally for now.
</p>
</li>
<li> <p><code>sparse.model.matrix()</code> gets option <code>sep = ""</code>, with,
e.g., <code>sep = ":"</code> allowing to get easier column names; from
R-forge Matrix (non-)bug #6581, by Vitalie Spinu.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>rankMatrix(&lt;sparse&gt;, method="qr")</code> now returns <code>NA</code>
(or <code>NaN</code>) instead of signalling an error in the case the sparse
<code class="reqn"><span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>Q</mi><mi>R</mi></mrow><annotation encoding="application/x-tex">Q R</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="base"><span class="strut" style="height: 0.8778em; vertical-align: -0.1944em;"></span><span style="margin-right: 0.0077em;" class="mord mathnormal">QR</span></span></span></span></code> decomposition gave <code>NA</code>s in <code>diag(R)</code>.
</p>
</li>
<li><p> Coercion (<code>as(., .)</code>) from e.g., <code>"lsyMatrix"</code> to
<code>"CsparseMatrix"</code> silently made asymmetric dimnames symmetric,
as did the <em>internal</em> <code>forceCspSymmetric(*, dimNames)</code>
which may be called from <code>forceSymmetric()</code>.
</p>
</li>
<li><p> Adapt code to new Fortran requirements of passing length of
character arguments, thanks to Brian Ripley.
</p>
</li>
<li><p> (R-forge Matrix bug #6659, reported by Georg Kindermann):
<code>&lt;sparseVector&gt;[i] &lt;- val</code> bug fixed.
</p>
</li>
<li><p> (R-forge Matrix bug #6666, reported by Ezra Tucker):
<code>which(&lt;ldiMatrix&gt;, array.ind=TRUE)</code> thinko fixed.
</p>
</li>
<li><p> For R-devel Dec 4, 2020: adapt all.equal() check of sparse
matrix images (which contain panel functions with environments ..).
</p>
</li>
<li><p> tried fixing warning <em>'cholmod_factorize_p' accessing 16
bytes in a region of size 8 [-Wstringop-overflow=]</em> in
‘<span class="file">src/dsCMatrix.c</span>’ (in two places); seen by pre-release-gcc11 compilation.
</p>
</li></ul>




<h3>Changes in version 1.2-18 (2019-11-26, manually picked from svn)</h3>



<h4>Bug Fixes</h4>


<ul>
<li><p> Fix last(?) <code>PROTECT()</code> warning found by <code>rchk</code> in
‘<span class="file">src/dense.c</span>’'s <code>ddense_skewpart()</code>.
</p>
</li>
<li> <p><code>as(m, "dgTMatrix")</code> does not lose <code>dimnames</code> anymore
when <code>m</code> is a (traditional) <code>matrix</code>.
</p>
</li>
<li> <p><code>M[logical(0), ]</code> now has dimension <code class="reqn"><span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mn>0</mn><mi>x</mi><mi>k</mi></mrow><annotation encoding="application/x-tex">0 x k</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="base"><span class="strut" style="height: 0.6944em;"></span><span class="mord">0</span><span class="mord mathnormal">x</span><span style="margin-right: 0.0315em;" class="mord mathnormal">k</span></span></span></span></code> for sparse
<code>M</code> as for base matrices.
</p>
</li>
<li> <p><code>log(M, base)</code> (the 2-argument version of <code>log()</code>)
wrongly gave the result for <code>base = exp(1)</code>, i.e., the 1-argument default.
</p>
</li>
<li> <p>‘<span class="file">test-tools-Matrix.R</span>’: <code>Qidentical()</code> no longer assumes
<code>class(&lt;matrix&gt;)</code> to be of length 1.
</p>
</li>
<li> <p>‘<span class="file">test-tools-1.R</span>’: provide bug-fixed <code>canCoerce()</code> in
old R versions.
</p>
</li></ul>




<h3>Changes in version 1.2-17 (2019-03-20, svn r3294)</h3>



<h4>New Features</h4>


<ul>
<li><p> (none)
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> Fix new <code>PROTECT()</code> warnings (bugs?) found by <code>rchk</code>.
</p>
</li>
<li><p> Provide <code>isFALSE()</code> for <span class="rlang"><b>R</b></span> &lt; 3.5.0 as now need it for
sparseMatrix printing.
</p>
</li></ul>




<h3>Changes in version 1.2-16 (2019-03-04, svn r3291)</h3>



<h4>New Features</h4>


<ul>
<li><p> regression tests depending on <code>sample()</code> now are future
proof reproducible, via <code>RNGversion(.)</code>.
</p>
</li>
<li><p> give information about #{rows} and #{columns} that are
suppressed in print()ing if the matrix is larger than <code>max.print</code>.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>data(&lt;Matrix-data&gt;)</code> no longer attaches <span class="pkg">Matrix</span> to
the search path.
</p>
</li>
<li> <p><code>"Ops"</code> group methods, i.e., "Arith", "Compare" &amp; "Logic",
now should all work with 0-extent matrices as well, thanks to bug
reports by Aaron Lun, University of Cambridge.
</p>
</li>
<li><p> when printing and formatting sparse matrices, see <code>formatSpMatrix()</code>,
the <code>maxp</code> option, e.g., from <code>getOption("max.print")</code>, is
“rounded up” to 100, as very small values are very rarely appropriate.
</p>
</li></ul>




<h3>Changes in version 1.2-15 (2018-08-20, svn r3283)</h3>



<h4>New Features</h4>


<ul>
<li> <p><code>image()</code> gets new optional argument <code>border.color</code>.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>image(Matrix(0, n,m))</code> now works.
</p>
</li></ul>




<h3>Changes in version 1.2-14 (2018-04-08, svn r3278)</h3>



<h4>New Features</h4>


<ul>
<li><p> German translation updates.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> one more <code>PROTECT()</code>.
</p>
</li></ul>




<h3>Changes in version 1.2-13 (2018-03-25, svn r3275)</h3>



<h4>New Features</h4>


<ul>
<li><p> Faster <code>as(&lt;matrix&gt;, "sparseMatrix")</code> and coercion
<code>"dgCMatrix"</code>, <code>"ngCMatrix"</code>, etc, via new direct C
<code>matrix_to_Csparse()</code> which does <em>not</em> go via
<code>"dgeMatrix"</code>.  This also works for large matrices
<code>m</code>, i.e., when <code>length(m) &gt;= .Machine$integer.max</code>.
</p>
<p>Also provide low-level <span class="rlang"><b>R</b></span> functions <code>.m2dgC()</code>,
<code>.m2lgC()</code>, and <code>.m2ngC()</code> for these.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>cbind(NULL,&lt;Matrix&gt;)</code> no longer return <code>NULL</code>;
analogously for <code>rbind()</code>, <code>rbind2()</code>, <code>cbind2()</code>,
fixing very long standing typo in the corresponsing <code>cbind2()</code>
and <code>rbind2()</code> methods.
</p>
</li>
<li><p> The deprecation warning (once per session) for
<code>cBind()</code> and <code>rBind()</code> finally works (fixing a simple thinko).
</p>
</li>
<li> <p><code>cbind()</code> and <code>rbind()</code> for largish sparse
matrices no longer gives an error because of integer overflow
(in the default case where <code>sparse</code> is not been specified
hence is chosen by a <code>nnzero()</code> based heuristic).
</p>
</li>
<li> <p><code>.symDiagonal(5, 5:1)</code> and <code>.trDiagonal(x = 4:1)</code>
now work as expected.
</p>
</li>
<li> <p><code>Sp[i]</code> now is much more efficient for large sparse
matrices <code>Sp</code>, notably when the result is short.
</p>
</li>
<li> <p><code>&lt;sparseVector&gt;[ &lt;negative integer&gt; ]</code> now also gives
the correct answer when the result is “empty”, i.e., all
zero or false.
</p>
</li>
<li><p> large <code>"dspMatrix"</code> and <code>"dtpMatrix"</code> objects can
now be constructed via <code>new(*, Dim = *, x = *)</code> also when
<code>length(x)</code> is larger than 2^31 (as the C internal
validation method no longer suffers from integer overflow).
</p>
</li>
<li><p> More ‘<span class="samp">⁠PROTECT()⁠</span>’ing to be “rather safe than
sorry” thanks to Tomas Kalibera's check tools.
</p>
</li></ul>




<h3>Changes in version 1.2-12 (2017-11-10, svn r3239)</h3>



<h4>New Features</h4>


<ul>
<li> <p><code>crossprod(x,y)</code> and <code>kronecker(x,y)</code> have become
considerably more efficient for large <code>"indMatrix"</code> objects
<code>x, y</code>, thanks to private nudging by Boris Vaillant.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> (R-forge Matrix bug #6185): <code>c &lt; 0</code> now also works for
derived sparse Matrices (which only <em>contain</em> Matrix
classes); via improving hidden <code>MatrixClass()</code>.   Part of
such derived matrices only work in R &gt;= 3.5.0.
</p>
</li>
<li><p> using <code>Authors@R</code> in ‘<span class="file">../DESCRIPTION</span>’ to list all
contributors.
</p>
</li>
<li> <p><code>solve(-m)</code> no longer should use a cached Cholesky
factorization (of <code>m</code>).
</p>
</li></ul>




<h3>Changes in version 1.2-11 (2017-08-10, svn r3225)</h3>



<h4>New Features</h4>


<ul>
<li><p> S4 method dispatch no longer emits ambiguity
notes (by default) for everybody, apart from the package
maintainer.  You can reactivate them by
<code>options(Matrix.ambiguityNotes = TRUE)</code>
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>rankMatrix(&lt;matrix of all 0&gt;)</code> now gives zero for all
methods, as it should be.
</p>
</li>
<li><p> no longer calling <code>length(NULL) &lt;- &lt;positive&gt;</code> which
has been deprecated in R-devel since July.
</p>
</li>
<li> <p><code>qr.coef(&lt;sparseQR&gt;, y)</code> now finally has correct (row)
names (from pivot back permutation).
</p>
</li>
<li> <p><code>.trDiagonal()</code> utility is now exported.
</p>
</li></ul>




<h3>Changes in version 1.2-10 (2017-04-19, svn r3216)</h3>



<h4>Bug Fixes</h4>


<ul>
<li><p> quite a collection of new <code>PROTECT(.)</code>'s thanks to
Tomas Kalibera's ‘rprotect’ analysis.
</p>
</li></ul>




<h3>Changes in version 1.2-9 (2017-03-08, svn r3211)</h3>



<h4>New Features</h4>


<ul>
<li> <p><code>"Ops"</code> between "table", "xtabs", and our matrices now work.
</p>
</li>
<li> <p><code>as(matrix(diag(3), 3, dimnames=rep(list(c("A","b","c")),2)),
 	"diagonalMatrix")@x</code> is no longer named.
</p>
</li>
<li> <p><code>norm(x, "2")</code> now works as well (and equivalently to <code>base::norm</code>).
</p>
</li>
<li> <p><code>sparseVector()</code> now also works without <code>x</code> argument.
</p>
</li>
<li> <p><code>c.sparseVector()</code> method for <code>c()</code> of
sparseVectors (and available as regular function on purpose).
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>as(Diagonal(3), "denseMatrix")</code> no longer returns a
non-dense <code>"ddiMatrix"</code>.
</p>
</li>
<li> <p><code>S[sel,] &lt;- value</code> and similar no longer segfault, but
give a <code>"not (yet?) supported"</code> error
for sparse matrices <code>S</code> and logical <code>sel</code> when
<code>sel</code> contains <code>NA</code>s.
</p>
<p>The same error (instead of a low-level one) is signalled for
<em>indexing</em> (with NA-containing logical <code>sel</code>), i.e.,
<code>S[sel,]</code>.



</p>
</li>
<li> <p><code>which(x, arr.ind=TRUE, *)</code> (when <code>x</code> is a
<code>"lMatrix"</code> or <code>"nMatrix"</code>) now works the same as
<code>base::which</code>, obeying an optional <code>useNames</code> argument
which defaults to <code>TRUE</code>.  Previously, the resulting
two-column matrix typically had empty <code>dimnames</code>.
</p>
</li></ul>




<h3>Changes in version 1.2-8 (2017-01-16, svn r3201)</h3>



<h4>New Features</h4>


<ul>
<li><p> 0-length matrix <code>"Ops"</code> (binary operations) are now
compatible to R-devel (to be <span class="rlang"><b>R</b></span> 3.4.0).
</p>
</li>
<li><p> C-API: <code>SuiteSparse_long</code> is now defined as
<code>int64_t</code> on all platforms, and we now include (C99) ‘<span class="file">inttypes.h</span>’
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>x[.] &lt;- value</code> now also works for
<code>"sparseVector"</code>'s, both as <code>x</code> and as <code>value</code>.
</p>
</li>
<li> <p><code>x[FALSE] &lt;- value</code> now also works for <code>"sparseVector"</code>'s.
</p>
</li>
<li> <p><code>rep(x, *)</code> now works for <code>"sparseVector"</code>s and
sparse and dense <code>"Matrix"</code>-classed matrices <code>x</code>.
</p>
</li>
<li> <p><code>solve(&lt;sparse_LU&gt;)</code> no gives an error in some cases of
singular matrices, where before the C code accessed illegal memory locations.
</p>
</li></ul>




<h3>Changes in version 1.2-7.1 (2016-08-29, svn r3187)</h3>

 <ul>
<li><p> in C code, protect _POSIX_C_SOURCE by #ifdef __GLIBC__ </p>
</li></ul>



<h3>Changes in version 1.2-7 (2016-08-27, svn r3185)</h3>



<h4>New Features</h4>


<ul>
<li> <p><code>cBind()</code> and <code>rBind()</code> have been almost silently
deprecated in <span class="rlang"><b>R</b></span> <code>&gt;= 3.2.0</code> and now give a warning,
“once per session” only.
</p>
</li>
<li> <p><code>bandSparse(*, k=k, *)</code> now returns matrices inheriting from
<code>"triangularMatrix"</code> when obvious from the diagonal indices <code>k</code>.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>KhatriRao(X,Y)</code> now also works when <code>X</code> or
<code>Y</code> is completely zero.
</p>
</li></ul>




<h3>Changes in version 1.2-6 (2016-04-27, svn r3175)</h3>



<h4>Bug Fixes</h4>


<ul>
<li><p> The 0-dim. Matrix multiplication fix in 1.2-5 did trigger
wrong warnings in other diagonal matrix multiplications.
</p>
</li></ul>




<h3>Changes in version 1.2-5 (2016-04-14, svn r3170)</h3>



<h4>New Features</h4>


<ul>
<li> <p><code>isSymmetric(m)</code> now also works for <code>"indMatrix"</code> <code>m</code>.
</p>
</li>
<li> <p><code>isSymmetric(m)</code> is faster for large dense asymmetric matrices.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> Matrix multiplications (<code>A %*% B</code>) now work correctly
when one of the matrices is diagonal and the other has a zero dimension.
</p>
</li></ul>




<h3>Changes in version 1.2-4 (2016-02-29, svn r3162)</h3>



<h4>New Features</h4>


<ul>
<li> <p><code>sparseMatrix()</code> gets new argument <code>triangular</code>
and a smarter default for <code>dims</code> when <code>symmetric</code> or
<code>triangular</code> is true.
</p>
</li>
<li> <p><code>as(&lt;sparse&gt;, "denseMatrix")</code> now works in more cases
when <code>prod(dim(.))</code> is larger than <code class="reqn"><span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><msup><mn>2</mn><mn>31</mn></msup><mo>−</mo><mn>1</mn></mrow><annotation encoding="application/x-tex">2^{31} - 1</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="base"><span class="strut" style="height: 0.8974em; vertical-align: -0.0833em;"></span><span class="mord"><span class="mord">2</span><span class="msupsub"><span class="vlist-t"><span class="vlist-r"><span class="vlist" style="height: 0.8141em;"><span class="" style="top: -3.063em; margin-right: 0.05em;"><span class="pstrut" style="height: 2.7em;"></span><span class="sizing reset-size6 size3 mtight"><span class="mord mtight"><span class="mord mtight">31</span></span></span></span></span></span></span></span></span><span class="mspace" style="margin-right: 0.2222em;"></span><span class="mbin">−</span><span class="mspace" style="margin-right: 0.2222em;"></span></span><span class="base"><span class="strut" style="height: 0.6444em;"></span><span class="mord">1</span></span></span></span></code>.
Hence, e.g., <code>!S</code> now works for much larger sparse matrices
<code>S</code>.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> creating very large dense matrices, e.g., by
<code>as(&lt;sparseM.&gt;, "matrix")</code> would segfault (in case it could
allocate enough storage).
</p>
</li></ul>




<h3>Changes in version 1.2-3 (2015-11-19, svn r3155)</h3>



<h4>New Features</h4>


<ul>
<li> <p><code>MatrixClass()</code> is exported now.
</p>
</li>
<li><p> More exports of semi-internal functions (for speed, named
<code>".&lt;foo&gt;"</code>, i.e., inofficial API), such as <code>.solve.dgC.lu()</code>.
</p>
</li>
<li><p> more Korean translations
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> Packages <em>linking</em> to <span class="pkg">Matrix</span> (<code>LinkingTo:</code>
in ‘<span class="file">DESCRIPTION</span>’) now find
‘<span class="samp">⁠alloca⁠</span>’ properly defined in ‘<span class="file">Matrix.h</span>’ even for non-GNU
compilation environments such as on Solaris or AIX.
</p>
</li>
<li><p> extended "n?CMatrix" classes (e.g., from <code>setClass(.,
	contains="ngCMatrix")</code>) now can be coerced via <code>as(.)</code> to
<code>"d.CMatrix"</code>.
</p>
</li>
<li><p> The printing of largish sparse matrices is improved, notably
in the case where columns are suppressed, via new <code>fitWidth =
	TRUE</code> option in <code>printSpMatrix2()</code>. 
</p>
</li>
<li> <p><code>cbind2()</code> and <code>rbind2()</code> no longer fail to
determine <code>sparse</code> when it is unspecified and hence
<code>NA</code>, fixing R-forge bug #6259.
</p>
</li></ul>




<h3>Changes in version 1.2-2 (2015-07-03, svn r3131)</h3>



<h4>New Features</h4>


<ul>
<li><p> Explicitly import from “base” packages such as <code>"stats"</code>.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> Our <code>colSums(x)</code>, <code>rowMeans(y)</code>, ..., methods
now “keep names”, i.e., if the result is a numeric vector,
and the matrix <code>x</code> has column or row names, these become the
<code>names(.)</code> of the result, fixing R-forge bug #6018.
</p>
</li></ul>




<h3>Changes in version 1.2-1 (2015-05-30, svn r3127)</h3>



<h4>New Features</h4>


<ul>
<li> <p><code>"Matrix"</code> now has an <code>initialization()</code> method
coercing 0-length dimnames components to <code>NULL</code> and other
non-<code>NULL</code> dimnames to <code>character</code>.  Before, e.g.,
numeric dimnames components partially worked, even though it has
always been documented that non-<code>NULL</code> dimnames should be
<code>character</code>.
</p>
</li>
<li><p> For <code>symmetricMatrix</code> objects which have symmetrical
dimnames by definition, it is allowed to only set one half of the
<code>dimnames</code> to save storage, e.g., <code>list(NULL, nms)</code> is
<em>semantically</em> equivalent to <code>list(nms, nms)</code>.
</p>
</li>
<li> <p><code>as.vector(&lt;sparseVector&gt;)</code> etc, now work, too.
</p>
</li>
<li> <p><code>lu(&lt;sparseMatrix&gt;)</code> now keeps <code>dimnames</code>.
</p>
</li>
<li><p> better ‘<span class="file">NEWS.Rd</span>’ (which pleases Kurt and <code>tidy</code> ;-)
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>S[] &lt;- T</code> and <code>S[] &lt;- spV</code> now work (in more cases)
for sparse matrices S, T and sparseVector <code>spV</code>.
</p>
</li>
<li><p> Huge dense matrix multiplication did lead to segfaults, see
R-help, “does segfault mean (always) a bug?”, May 5, 2015.
Fixed by using C's Alloca() only in smallish cases.
</p>
</li>
<li><p> Optional arguments in <code>image()</code>, e.g., <code>main=
	&lt;..&gt;)</code> now also work for <code>lgCMatrix</code>, <code>nMatrix</code> etc;
thanks to a 4.5 years old report by Mstislav Elagin.
</p>
</li>
<li> <p><code>dimnames(A) &lt;- val</code> now resets the <code>factors</code> slot
to empty, as the factorizations now keep dimnames more often.
</p>
</li>
<li> <p><code>crossprod(&lt;matrix&gt;, Diagonal(&lt;n&gt;))</code> works again (and
these are tested more systematically).
</p>
</li>
<li><p> Matrix products (<code>%*%</code>, <code>crossprod</code>, and
<code>tcrossprod</code>) for <code>"dtrMatrix"</code> are correct in all
cases, including keeping dimnames.
</p>
</li>
<li> <p><code>Matrix(d)</code> (and other coercions to <code>"Matrix"</code>)
now correctly keeps <code>dimnames</code> also when <code>d</code> is a
traditional <em>diagonal</em> <code>"matrix"</code>.
</p>
</li></ul>




<h3>Changes in version 1.2-0 (2015-04-03, svn r3096)</h3>



<h4>New Features</h4>


<ul>
<li><p> New <code>%&amp;%</code> for “boolean arithmetic” matrix product.
</p>
</li>
<li><p> New argument <code>boolArith = NA</code> in <code>crossprod()</code> and
<code>tcrossprod()</code>.  <code>boolArith = TRUE</code> now forces boolean
arithmetic, where <code>boolArith = FALSE</code> forces numeric one.
</p>
<p>Several of these products are more efficient thanks to new C
functionality based on our new <code>chm_transpose_dense()</code>, and
others based on <code>geMatrix_crossprod</code>,
<code>geMatrix_matrix_mm</code>, etc.
</p>
</li>
<li><p> Most dense matrix products, also for non-<code>dgeMatrix</code>,
including <code>"l..Matrix"</code> and <code>"n..Matrix"</code> ones are now
directly handled by new <code>.Call()</code>s.
</p>
</li>
<li> <p><code>"dMatrix"</code> (numeric) and <code>"lMatrix"</code> (logical)
matrices can now be coerced to <code>"nMatrix"</code> (non-zero pattern
or “boolean”) even when they contain <code>NA</code>s, which then
become <code>TRUE</code>s.
</p>
</li>
<li><p> More thorough checking of <code>cbind2()</code> and
<code>rbind2()</code> methods, notably as they are called from <code>cbind()</code>
and <code>rbind()</code> from <span class="rlang"><b>R</b></span> version 3.2.0 on.
</p>
<p><code>rbind2(&lt;dense&gt;, &lt;dense&gt;)</code> is faster, being based on new C code.
</p>
</li>
<li><p> symmetric Matrices (i.e., inheriting from
<code>"symmetricMatrix"</code>) are allowed to have <code>dimnames</code> of
the form <code>list(NULL, &lt;names&gt;)</code> <em>and</em> now print correctly
and get correctly coerced to general matrices.
</p>
</li>
<li> <p><code>indMatrix</code> object (“index matrices”) no longer
need to be “skinny”.
</p>
</li>
<li> <p><code>rsparseMatrix()</code> now accepts <code>rand.x = NULL</code> and
then creates a random <em>patter<b>n</b></em> matrix
(<code>"nsparseMatrix"</code>).
</p>
</li>
<li> <p><code>anyDuplicatedT()</code> and <code>uniqTsparse()</code> low level
utilities are exported now.
</p>
</li>
<li><p> Partial Korean translations of messages.
</p>
</li></ul>




<h4>Deprecation</h4>


<ul>
<li><p> For <code class="reqn"><span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>R</mi><mo>≥</mo><mn>3.2.0</mn></mrow><annotation encoding="application/x-tex">R \ge 3.2.0</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="base"><span class="strut" style="height: 0.8193em; vertical-align: -0.136em;"></span><span style="margin-right: 0.0077em;" class="mord mathnormal">R</span><span class="mspace" style="margin-right: 0.2778em;"></span><span class="mrel">≥</span><span class="mspace" style="margin-right: 0.2778em;"></span></span><span class="base"><span class="strut" style="height: 0.6444em;"></span><span class="mord">3.2.0</span></span></span></span></code>, <code>cBind()</code> and <code>rBind()</code>
are deprecated, as they are no longer needed since <code>cbind()</code>
and <code>rbind()</code> do work automatically.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> Fix some <code>rbind2()</code> methods.
</p>
</li>
<li> <p><code>t()</code> now transposes the dimnames even for symmetric
matrices.
</p>
</li>
<li> <p><code>diag(M) &lt;- val</code> did not always recycle <code>val</code> to
full length, e.g., when <code>M</code> was a <code>"dtrMatrix"</code>.
</p>
</li>
<li> <p><code>crossprod(&lt;indMatrix&gt;)</code> was wrong in cases where the
matrix had all-zero columns.
</p>
</li>
<li><p> Matrix products (<code>%*%</code>, <code>crossprod</code>, and
<code>tcrossprod</code>) with one sparse and one dense argument now
return <em>numeric</em> (a <code>"dMatrix"</code>) when they should, i.e.,
unless the new setting <code>boolArith = TRUE</code> is applied.
</p>
</li></ul>




<h3>Changes in version 1.1-5 (2015-01-18, svn r3037)</h3>



<h4>New Features</h4>


<ul>
<li><p> More use of <code>anyNA()</code> (for speedup).
</p>
</li>
<li><p> Matrix products (<code>%*%</code>, <code>crossprod</code>,
<code>tcrossprod</code>) now behave compatibly to <span class="rlang"><b>R</b></span> 3.2.0, i.e., more
lenient in matching dimensions for matrix - vector products.
</p>
</li>
<li> <p><code>isTriangular()</code> gets new optional argument <code>upper = NA</code>.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>crossprod()</code> and <code>tcrossprod()</code> fixes for
several &lt;diagonal&gt; o &lt;sparse&gt; combinations.
</p>
</li>
<li> <p><code>rowMeans(&lt;dgeMatrix&gt;, na.rm=TRUE)</code> was wrong sometimes.
</p>
</li>
<li><p> fix and speedup of coercions (<code>as(., .)</code>) from and to
symmetric or triangular matrices.
</p>
</li>
<li> <p><code>invPerm()</code> coercion to integer
</p>
</li>
<li> <p><code>dimnames( solve(.,.) )</code> fix [r3036]
</p>
</li>
<li> <p><code>tril()</code> and <code>triu()</code> now return correct <code>uplo</code>.
</p>
</li>
<li> <p><code>names(dimnames(.))</code> now preserved, e.g. in
<code>symmpart()</code> or subsetting (<code>A[i,j]</code>).
</p>
</li></ul>




<h3>Changes in version 1.1-4 (2014-06-14, svn r2994)</h3>



<h4>New Features</h4>


<ul>
<li><p> new <code>rsparsematrix()</code> for random sparse Matrices.
</p>
</li>
<li><p> improved warnings, notably for unused arguments previously
swallowed into <code>...</code>.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>crossprod(&lt;vec&gt;, &lt;dsyMatrix&gt;)</code> fixed.
</p>
</li>
<li> <p><code>crossprod()</code> and <code>kronecker()</code> fixes for some
&lt;indMatrix&gt; cases.
</p>
</li></ul>




<h3>Changes in version 1.1-3 (2014-03-30, svn r2982)</h3>



<h4>New Features</h4>


<ul>
<li> <p><code>%*%</code> and <code>crossprod()</code> now also work with
<code>sparseVector</code>s.
</p>
</li>
<li><p> speedup of <code>crossprod(v, &lt;sparseM&gt;)</code>, thanks to nudge
by Niels Richard Hansen.
</p>
</li>
<li><p> new help page for all such matrix products
(‘<span class="file">../man/matrix-products.Rd</span>’).
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>image()</code> now gets correct <code>ylim</code> again.
</p>
</li>
<li><p> More consistent matrix products.
</p>
</li></ul>




<h3>Changes in version 1.1-2-2 (2014-03-04, svn r2966)</h3>



<h4>Bug Fixes</h4>


<ul>
<li><p> correct adaption to <span class="rlang"><b>R</b></span> 3.1.0
</p>
</li>
<li><p> using <code>tolerance</code> (and not ‘tol’) in <code>all.equal()</code>
</p>
</li></ul>




<h3>Changes in version 1.1-2 (2014-01-28, svn r2962)</h3>



<h4>New Features</h4>


<ul>
<li><p> export fast power-user coercion utilities
<code>.dsy2mat()</code>, <code>.dxC2mat()</code>, <code>.T2Cmat()</code>, <code>..2dge()</code>.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> matrix products now (mostly) work with <code>sparseVector</code>s;
and correctly in some more cases.
</p>
</li></ul>




<h3>Changes in version 1.1-1.1 (2013-12-30, svn r2957)</h3>


<ul>
<li><p> Testing code's <code>assertWarning()</code> adapted for <code class="reqn"><span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>R</mi><mo>≤</mo><mn>3.0.1</mn></mrow><annotation encoding="application/x-tex">R \le 3.0.1</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="base"><span class="strut" style="height: 0.8193em; vertical-align: -0.136em;"></span><span style="margin-right: 0.0077em;" class="mord mathnormal">R</span><span class="mspace" style="margin-right: 0.2778em;"></span><span class="mrel">≤</span><span class="mspace" style="margin-right: 0.2778em;"></span></span><span class="base"><span class="strut" style="height: 0.6444em;"></span><span class="mord">3.0.1</span></span></span></span></code>.
</p>
</li>
<li> <p><code>Depends: R &gt;= 2.15.2</code> eases checking.
</p>
</li></ul>



<h3>Changes in version 1.1-1 (2013-12-28)</h3>



<h4>New Features</h4>


<ul>
<li> <p><code>image(.., xlim, ylim)</code>: nicer defaults 
for the axis limits, and <code>ylim</code> is sorted decreasingly; not
strictly back-compatible but should never harm.
</p>
</li>
<li> <p><code>rankMatrix(*, method="qr")</code> now using <code>tol</code>
</p>
</li>
<li> <p><code>T2graph()</code> and <code>graph2T()</code> export old functionality explicitly.
Tweaks in conversions between <code>"graph"</code> and
<code>"sparseMatrix"</code> objects.  Notably, <code>as(&lt;graph&gt;,
	&lt;Matrix&gt;)</code> now more often returns a (0/1 pattern) "n..Matrix".
</p>
</li>
<li> <p><code>sparseMatrix()</code>: new <code>use.last.ij</code> argument.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>KhatriRao()</code>: fix rownames (X &lt;-&gt; Y)
</p>
</li>
<li> <p><code>qr.coef()</code>, <code>qr.fitted</code>, and <code>qr.resid</code> now
also work with <em>sparse</em> RHS <code>y</code>.
</p>
</li>
<li><p> sparse matrix “sub assignments”, e.g., <code>M[ii] &lt;- v</code>,
speedup and fixes.
</p>
</li>
<li><p> bug fixes also in <code>M[negative indices] &lt;- value</code> and
<code>&lt;sparseMatrix&gt;[cbind(i,j)]</code>.
</p>
</li></ul>




<h3>Changes in version 1.1-0 (2013-10-21, svn r2930)</h3>



<h4>New Features</h4>


<ul>
<li> <p><code>fac2sparse</code> and <code>fac2Sparse</code> now exported, with a
new <code>giveCsparse</code> option.
</p>
</li>
<li><p> Update to latest <code>SuiteSparse</code> C library by Tim Davis,
U. Florida.
</p>
</li>
<li><p> ensuing “C API changes”
</p>
</li>
<li><p> new <code>.SuiteSparse_version()</code> function
</p>
</li>
<li><p> Many ‘Imports:’ instead of ‘Depends:’.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> fixed long lasting undetected <code>solve(&lt;dsCMatrix&gt;, *)</code>
bug.
</p>
</li>
<li><p> Our <code>all.equal()</code> methods no longer sometimes return
<code>c("TRUE", "....difference..")</code>.
</p>
</li>
<li> <p><code>rankMatrix(&lt;matrix&gt;)</code>: fix the internal <code>x.dense</code>
definition.
</p>
</li></ul>




<h3>Changes in version 1.0-14 (2013-09-12, svn r2907)</h3>



<h4>Bug Fixes</h4>


<ul>
<li><p> Revert some wrong changes to <code>solve(&lt;sparse&gt;, *)</code> from
1.0-13 (“stop gap fix” for <span class="rlang"><b>R</b></span> 3.0.2).
</p>
</li></ul>




<h3>Changes in version 1.0-13 (2013-09-10, svn r2904)</h3>



<h4>New Features</h4>


<ul>
<li><p> New (efficient) <code>KhatriRao()</code> function by Michael Cysouw
</p>
</li>
<li><p> New <code>"indMatrix"</code> class of “index matrices”, a
generalization of <code>"pMatrix"</code>, the permutation matrices, many
methods generalized from pMatrix to indMatrix.  All (initial)
functionality contributed by Fabian Scheibl, Univ.  Munich.
</p>
</li>
<li><p> Export and document <code>isDiagonal()</code> and
<code>isTriangular()</code> as they are useful outside of <span class="pkg">Matrix</span>.
</p>
</li>
<li> <p><code>rankMatrix(M, method="qr")</code> no longer needs
<code>sval</code> which makes it considerably more useful for large
sparse <code>M</code>.
</p>
</li>
<li><p> Start providing <code>anyNA</code> methods for <code class="reqn"><span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mi>R</mi><mo>&gt;</mo><mo>=</mo><mn>3.1.0</mn></mrow><annotation encoding="application/x-tex">R &gt;= 3.1.0</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="base"><span class="strut" style="height: 0.7224em; vertical-align: -0.0391em;"></span><span style="margin-right: 0.0077em;" class="mord mathnormal">R</span><span class="mspace" style="margin-right: 0.2778em;"></span><span class="mrel">&gt;=</span><span class="mspace" style="margin-right: 0.2778em;"></span></span><span class="base"><span class="strut" style="height: 0.6444em;"></span><span class="mord">3.1.0</span></span></span></span></code>.
</p>
</li>
<li> <p><code>solve(&lt;sparse&gt; a, &lt;sparse&gt; b)</code>: if <code>a</code> is
symmetric, now compute <em>sparse</em> result.
</p>
</li>
<li> <p><code>nearPD()</code> gets new option <code>conv.norm.type = "I"</code>.
</p>
</li>
<li> <p><code>determinant(&lt;dpoMatrix&gt;)</code> now uses <code>chol()</code>, and
hence also an existing (‘cached’) Cholesky factor.
</p>
</li>
<li><p> 3 new <code>C -&gt; R</code> utilities (including hidden <span class="rlang"><b>R</b></span> function
<code>.set.factors()</code> for caching also from <span class="rlang"><b>R</b></span>, not just in C).
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>M[] &lt;- v</code> for unitriangular <code>M</code> now correct.
</p>
</li>
<li> <p><code>lu(.)</code> no longer sometimes returns unsorted columns.
</p>
</li></ul>




<h3>Changes in version 1.0-12 (2013-03-26, svn r2872)</h3>



<h4>New Features</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h3>Changes in version 1.0-11 (2013-02-02)</h3>



<h4>New Features</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li> <p><code>as(&lt;csr&gt;, "dgCMatrix")</code> (from package <a href="https://cran.r-project.org/package=SparseM"><span class="pkg">SparseM</span></a>)
now works again.
</p>
</li>
<li><p> .
</p>
</li></ul>




<h3>Changes in version 1.0-10 (2012-10-22)</h3>



<h4>New Features</h4>


<ul>
<li> <p><code>.sparseDiagonal()</code>: new <code>unitri</code> argument, and
more flexibility;
</p>
</li>
<li><p> new <code>solve(&lt;dsCMatrix&gt;, &lt;missing&gt;)</code> via efficient C code.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h3>Changes in version 1.0-9 (2012-09-05)</h3>



<h4>New Features</h4>


<ul>
<li><p> new <code>sparseVector()</code> constructor function.
</p>
</li>
<li> <p><code>is.finite()</code> <code>is.infinite()</code> now work for our
matrices and "*sparseVector" objects.
</p>
</li>
<li> <p><code>diag(.) &lt;- V</code> now preserves symmetricity,
triangularity and even uni-triangularity sometimes.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> Quite a few fixes for <code>Ops</code> (arithmetic, logic, etc)
group methods.
</p>
</li>
<li><p> Ditto for <code>diagonalMatrix</code> methods.
</p>
</li></ul>




<h3>Changes in version 1.0-6 (2012-03-16, publ. 2012-06-18)</h3>



<h4>New Features</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h3>Changes in version 1.0-5 (2012-03-15)</h3>



<h4>New Features</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h3>Changes in version 1.0-4 (2012-02-21)</h3>



<h4>New Features</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h3>Changes in version 1.0-3 (2012-01-13)</h3>



<h4>New Features</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h3>Changes in version 1.0-2 (2011-11-19)</h3>



<h4>New Features</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h3>Changes in version 1.0-1 (2011-10-18)</h3>



<h4>New Features</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h3>Changes in version 1.0-0 (2011-10-04)</h3>



<h4>New Features</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h3>Changes in version 0.9996875-3 (2011-08-13)</h3>



<h4>New Features</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h3>Changes in version 0.9996875-2 (2011-08-09)</h3>



<h4>New Features</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h3>Changes in version 0.9996875-1 (2011-08-08)</h3>



<h4>New Features</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h3>Changes in version 0.999375-50 (2011-04-08)</h3>



<h4>New Features</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h3>Changes in version 0.95-1 (2005-02-18, svn r561)</h3>



<h4>Authorship</h4>


<ul>
<li><p> During Doug Bates' sabbatical in Zurich,
Martin Maechler becomes co-author of the <span class="pkg">Matrix</span> package.
</p>
</li></ul>




<h4>New Features</h4>


<ul>
<li><p> Beginning of class reorganization with a more systematic
naming scheme.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> More (correct) coercions <code>as(&lt;from&gt;, &lt;to&gt;)</code>.
</p>
</li></ul>




<h3>Changes in version 0.9-1 (2005-01-24, svn r451)</h3>



<h4>New Features</h4>


<ul>
<li><p> lme4 / lmer specific R code moved out to <a href="https://cran.r-project.org/package=lme4"><span class="pkg">lme4</span></a> package.
</p>
</li></ul>




<h4>Bug Fixes</h4>


<ul>
<li><p> .
</p>
</li></ul>




<h3>Changes in version 0.8-2 (2004-04-06, svn r51)</h3>



<h4>Authorship</h4>


<ul>
<li><p> Doug Bates (only)
</p>
</li></ul>




<h4>New Features</h4>


<ul>
<li><p> Sparse matrices, classes and methods, partly via
</p>
</li>
<li><p> Interface to LDL, TAUCS, Metis and UMFPACK C libraries
</p>
</li></ul>




<h3>Version 0.2-4</h3>



<h4>..., 0.3-1, 0.3-n (n=3,5,...,26): 22 more CRAN releases</h4>

 <ul>
<li><p> ............................................. </p>
</li></ul>
 

<h3>Version 0.2-1 (2000-07-15)</h3>

<p>The first CRAN release of the <span class="pkg">Matrix</span> package,
titled “A Matrix library for R” authored by
Douglas Bates (maintainer, principal author) and Saikat DebRoy.
</p>


<h4>Features</h4>


<ul>
<li> <p><code>Matrix()</code> constructor for <span class="rlang"><b>R</b></span> objects of class <code>Matrix</code>.
</p>
</li>
<li> <p><code>Matrix.class()</code> returning informal subclasses such as
<code>"Hermitian"</code>, <code>"LowerTriangular"</code>
</p>
</li>
<li> <p><code>is.Orthonormal()</code>, <code>is.Hermitian()</code> ,
<code>is.UpperTriangular()</code> functions.
</p>
</li>
<li> <p><code>SVD()</code>, <code>lu()</code>, and <code>schur()</code> decomposition
generics with <code>"Matrix"</code> methods.
</p>
</li>
<li> <p><code>rcond()</code>, <code>norm()</code>, <code>det()</code>;
<code>expand()</code> and <code>facmul()</code>.
</p>
</li>
<li><p> C++ interface to LAPACK
</p>
</li></ul>




</div>

</body></html>