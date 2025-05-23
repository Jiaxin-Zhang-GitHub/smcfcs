% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/smcfcs.r
\name{smcfcs.casecohort}
\alias{smcfcs.casecohort}
\title{Substantive model compatible fully conditional specification imputation of covariates for case cohort studies}
\usage{
smcfcs.casecohort(originaldata, smformula, method, sampfrac, in.subco, ...)
}
\arguments{
\item{originaldata}{The case-cohort data set (NOT a full cohort data set with a case-cohort substudy within it)}

\item{smformula}{A formula of the form "Surv(entertime,t,d)~x", where d is the event (d=1) or censoring (d=0) indicator, t is the event or censoring time and entertime is equal to the time origin (typically 0) for individuals in the subcohort and is equal to (t-0.001) for cases outside the subcohort [this sets cases outside the subcohort to enter follow-up just before their event time. The value 0.001 may need to be modified depending on the time scale.]}

\item{method}{A required vector of strings specifying for each variable either
that it does not need to be imputed (""), the type of regression model to be
be used to impute. Possible values are \code{"norm"} (normal linear regression),
\code{"logreg"} (logistic regression), \code{"brlogreg"} (bias reduced logistic regression),
\code{"poisson"} (Poisson regression),
\code{"podds"} (proportional odds regression for ordered categorical variables),
\code{"mlogit"} (multinomial logistic regression for unordered categorical variables),
or a custom expression which defines a passively imputed variable, e.g.
\code{"x^2"} or \code{"x1*x2"}. \code{"latnorm"} indicates the variable is a latent
normal variable which is measured with error. If this is specified for a variable,
the \code{"errorProneMatrix"} argument should also be used.}

\item{sampfrac}{The proportion of individuals from the underlying full cohort who are in the subcohort}

\item{in.subco}{The name of a column in the dataset with 0/1s that indicates whether the subject is in the subcohort}

\item{...}{Additional arguments to pass on to \link[smcfcs]{smcfcs}}
}
\description{
Multiply imputes missing covariate values using substantive model compatible
fully conditional specification for case cohort studies.
}
\details{
This version of \code{smcfcs} is designed for use with case cohort studies but where the analyst does not wish to,
or cannot (due to not having the necessary data) impute the full cohort. The function's arguments are the same
as for the main smcfcs function, except for \code{smformula}, \code{in.subco}, and \code{sampfrac} - see above
for details on how these should be specified.
}
\examples{
#the following example is not run when the package is compiled on CRAN
#(to keep computation time down), but it can be run by package users
\dontrun{
  #as per the documentation for ex_cc, the sampling fraction is 10\%
  imps <- smcfcs.casecohort(ex_cc, smformula="Surv(entertime, t, d)~x+z", sampfrac=0.1,
                            in.subco="in.subco", method=c("", "", "norm", "", "", "", ""))
  library(mitools)
  impobj <- imputationList(imps$impDatasets)
  models <- with(impobj, coxph(Surv(entertime,t,d)~x+z+cluster(id)))
  summary(MIcombine(models))
}
}
\author{
Ruth Keogh \email{ruth.keogh@lshtm.ac.uk}

Jonathan Bartlett \email{jonathan.bartlett1@lshtm.ac.uk}
}
