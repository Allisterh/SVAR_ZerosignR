zerosign_restr <- function(model=NULL, restr_matrix, LR=FALSE, tries=500, ...){
  #'Perform simulations to identify shock under zero and sign restrictions and calculate IRFs
  #'
  #'@description
  #'This function calculates IRFs for a given estimated bayesian/frequentist model
  #'or explicit parameters of VAR, then simulates and checks orthognormal
  #'random matrices Q given number of times in order to identify structural shocks.
  #'It returns a list of Q matrices and transformed IRFs that satisfy imposed restrictions.
  #'
  #'@usage
  #'## S3 method for classes 'bvar' and 'varest'
  #'zerosign_restr(model, restr_matrix, LR = FALSE, tries = 500, ...)
  #'
  #'## S3 method for class 'array'
  #'zerosign_restr(B, Sigma, p, n, draws, restr_matrix, LR = FALSE,
  #'               has_const = TRUE, tries = 300, var_names = NULL)
  #'
  #'@param model Estimated (B)VAR model. \code{varest} from \strong{vars} for frequentist
  #'and \code{bvar} from \strong{BVAR} for bayesian approach are supported. If \code{NULL}
  #'is provided, user has to provide model's parameters manually, as it is given in the second signature.
  #'@param restr_matrix \code{array} with \emph{nvars} x \emph{nvars} x \emph{max. restr. period}.
  #'First dimension = shocks, structural and residual ones. Put \emph{0, 1} or \emph{-1}
  #'into \emph{(i,j,t)}-th cell of
  #'this array in order to set zero/non-negative/non-positive restriction to the \emph{i}-th variable
  #'response to the shock \emph{j} at period t. Otherwise, put \code{NA} for no restrictions.
  #'See below for more info.
  #'@param LR Boolean, \code{TRUE} if long-run restictions are present.
  #'@param tries Numeric, number of attempts to generate random orthonormal matrix Q for
  #'frequentist model/each draw of bayesian model.
  #'@param B \emph{optional} \eqn{B = A_+ \cdot (A_0)^(-1)}{B = A+ * A0^(-1)} ---
  #'three-dimensional array of reduced parameters in form
  #'\eqn{B = \[c, B_1, \ldots, B_p\]}{B = (c, B1, ..., Bp)}.
  #'The first dimension denotes draw, other two are related to the matrix of parameters.
  #'@param Sigma \emph{optional} Array with draws of variance-covariance matrix of error term.
  #'The first dimension denotes draw, other two are related to the covariance matrix.
  #'@param p \emph{optional} Order of model.
  #'@param n \emph{optional} Number of variables.
  #'@param draws \emph{optional} Number of draws (1 if frequentist model).
  #'@param has_const \emph{optional} Boolean. Whether constant is present in \code{B}
  #'@param var_names \emph{optional} Vector of strings (characters) --- names of variables.
  #'@param shock_names \emph{optional} Vector of strings (characters) --- names of shocks.
  #'@return \code{ZerosignR} object with accepted Q matrices.
  #'
  #'@note
  #'In order to create restriction matrix, create an array with three dimensions:
  #'the first and second one of them should have length of number of variables,
  #'the latter should have length of maximum period with restrictions imposed.
  #'Columns are shocks (both structural and residual), rows are variables.
  #'Note that user should put shocks in decreasing order of zero restrictions,
  #'i. e. the shock with the most zero restrictions should be first.
  #'There should be no more than \code{nvars - j} zero restrictions for \code{j}-th
  #'shock for \strong{all} time periods in total.
  #'
  #'@details
  #'Arias et al. (2018) suggest IRF zero and sign restrictions method to identify structural shocks.
  #'Consider the model of form: \deqn{y_t = B y_{t-1} + u_t,}{y(t) = B * y(t-1) + u(t),}
  #'where \eqn{u_t}{u(t)} is vector of statistical shocks that lack structural interpretation.
  #'Covariance matrix of structural shocks \eqn{\Sigma_\epsilon}{Σ_ε} can be estimated, hence, the simplest way
  #'(although rigid) to get structural shocks is to apply Cholesky decomposition to covariance matrix
  #'\eqn{\Sigma_u}{Σ_u}: \deqn{\epsilon_u = A_0 * \Sigma_\epsilon * A_0' = A_0 * A_0'.}{Σ_u = A0 * Σ_ε * A0' = A0 * A0'.}
  #'Then, A0 is a structural parameters matrix capturing contemporaneous effects, and \eqn{A_+ = BA_0}{A+ = B A0}
  #'is a structural parameters matrix containing other effects.
  #'After that, it is possible to get structural IRFs for horizon \eqn{h}{h}: \eqn{L_h(A_0, A_+)}{Lh(A0, A+)}.
  #'
  #'Since Cholesky identification assumes that there is \emph{recursive} relation of shocks and variables
  #'(e. g. if lower Cholesky decomposition is used, the first shock effects all variables contemporaneously,
  #'while the last one has influence only to the last variable), it is hardly to justify such restrictions.
  #'Then, researcher can calculate VMA representation: \deqn{y_t = \Phi u_{t, t-\infty},}{y(t) = Φ(t, t-∞),}
  #'and define \eqn{\psi_i = \phi_i * A_0}{ψ(i) = φ(i) * A0} --- structural IRFs and impose sign and zero restrictions
  #'to them multiplying by matrix \eqn{Q}{Q}. The latter is done by generating \emph{n} times random orthonormal matrix \eqn{Q}{Q} for pure sign approach,
  #'or recursively constructing it for sign and zero approach.
  #'
  #'@seealso \code{\link{irf.ZerosignR.result}}
  #'@author Artur Zmanovskii. \email{anzmanovskii@gmail.com}
  #'@references{
  #'Arias, J.E. and Rubio-Ramirez, J. F. and Waggoner, D. F. (2018)
  #'Inference Based on Structural Vector Autoregressions Identifiied with Sign and Zero Restrictions:
  #'Theory and Applications. \emph{Econometrica}, 86, 2, 685-720, \url{https://doi.org/10.3982/ECTA14468}.
  #'
  #'Breitenlechner, M., Geiger, M., & Sindermann, F. (2019).
  #'ZeroSignVAR: A Zero and Sign Restriction Algorithm Implemented in MATLAB.}
  UseMethod("zerosign_restr", model)
}
