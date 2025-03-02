% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot.ZerosignR.irf.R
\name{plot.ZerosignR.irf}
\alias{plot.ZerosignR.irf}
\title{Plot structural IRFs for zero and sign restriction algorithm.}
\usage{
\method{plot}{ZerosignR.irf}(zerosign_irf, plot_ci = TRUE, plot_ctm = FALSE)
}
\arguments{
\item{zerosign_irf}{\code{Zerosign.irf}, an object containing structural IRFs
obtained using zero and sign algorithm.}

\item{plot_ci}{Logical. Whether to plot confidence intervals.}

\item{plot_ctm}{Logical. Whether to plot IRF from closest-to-median model instead of
median IRF.}
}
\value{
\code{NULL}.
}
\description{
Plot structural IRFs for zero and sign restriction algorithm.
}
\seealso{
\code{\link{zerosign_restr}, \link{irf.ZerosignR.result}}
}
\author{
Artur Zmanovskii. \email{anzmanovskii@gmail.com}
}
