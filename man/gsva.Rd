\name{gsva}
\alias{gsva}
\alias{gsva,ExpressionSet,list-method}
\alias{gsva,ExpressionSet,GeneSetCollection-method}
\alias{gsva,matrix,GeneSetCollection-method}
\alias{gsva,matrix,list-method}

\encoding{latin1}

\title{
Gene Set Variation Analysis
}
\description{
Estimates GSVA enrichment scores.
}
\usage{
\S4method{gsva}{ExpressionSet,list}(expr, gset.idx.list, annotation,
    method=c("gsva", "ssgsea", "zscore", "plage"),
    kcdf=c("Gaussian", "Poisson", "none"),
    rnaseq=FALSE,
    abs.ranking=FALSE,
    min.sz=1,
    max.sz=Inf,
    no.bootstraps=0,
    bootstrap.percent = .632,
    parallel.sz=0,
    parallel.type="SOCK",
    mx.diff=TRUE,
    tau=switch(method, gsva=1, ssgsea=0.25, NA),
    kernel=TRUE,
    ssgsea.norm=TRUE,
    verbose=TRUE,
    return.old.value=FALSE)
\S4method{gsva}{ExpressionSet,GeneSetCollection}(expr, gset.idx.list, annotation,
    method=c("gsva", "ssgsea", "zscore", "plage"),
    kcdf=c("Gaussian", "Poisson", "none"),
    rnaseq=FALSE,
    abs.ranking=FALSE,
    min.sz=1,
    max.sz=Inf,
    no.bootstraps=0,
    bootstrap.percent = .632,
    parallel.sz=0,
    parallel.type="SOCK",
    mx.diff=TRUE,
    tau=switch(method, gsva=1, ssgsea=0.25, NA),
    kernel=TRUE,
    ssgsea.norm=TRUE,
    verbose=TRUE,
    return.old.value=FALSE)
\S4method{gsva}{matrix,GeneSetCollection}(expr, gset.idx.list, annotation,
    method=c("gsva", "ssgsea", "zscore", "plage"),
    kcdf=c("Gaussian", "Poisson", "none"),
    rnaseq=FALSE,
    abs.ranking=FALSE,
    min.sz=1,
    max.sz=Inf,
    no.bootstraps=0,
    bootstrap.percent = .632,
    parallel.sz=0,
    parallel.type="SOCK",
    mx.diff=TRUE,
    tau=switch(method, gsva=1, ssgsea=0.25, NA),
    kernel=TRUE,
    ssgsea.norm=TRUE,
    verbose=TRUE,
    return.old.value=FALSE)
\S4method{gsva}{matrix,list}(expr, gset.idx.list, annotation,
    method=c("gsva", "ssgsea", "zscore", "plage"),
    kcdf=c("Gaussian", "Poisson", "none"),
    rnaseq=FALSE,
    abs.ranking=FALSE,
    min.sz=1,
    max.sz=Inf,
    no.bootstraps=0,
    bootstrap.percent = .632,
    parallel.sz=0,
    parallel.type="SOCK",
    mx.diff=TRUE,
    tau=switch(method, gsva=1, ssgsea=0.25, NA),
    kernel=TRUE,
    ssgsea.norm=TRUE,
    verbose=TRUE,
    return.old.value=FALSE)
}
\arguments{
  \item{expr}{Gene expression data which can be given either as an \code{ExpressionSet}
              object or as a matrix of expression values where rows correspond
              to genes and columns correspond to samples.}
  \item{gset.idx.list}{Gene sets provided either as a \code{list} object or as a
                       \code{GeneSetCollection} object.}
  \item{annotation}{In the case of calling \code{gsva()} with expression data in a \code{matrix}
                    and gene sets as a \code{GeneSetCollection} object, the \code{annotation} argument
                    can be used to supply the name of the Bioconductor package that contains
                    annotations for the class of gene identifiers occurring in the row names of
                    the expression data matrix. By default \code{gsva()} will try to match the
                    identifiers in \code{expr} to the identifiers in \code{gset.idx.list} just as
                    they are, unless the \code{annotation} argument is set.}
  \item{method}{Method to employ in the estimation of gene-set enrichment scores per sample. By default
                this is set to \code{gsva} (\enc{Hänzelmann}{Hanzelmann} et al, 2013) and other options are
                \code{ssgsea} (Barbie et al, 2009), \code{zscore} (Lee et al, 2008) or \code{plage}
                (Tomfohr et al, 2005). The latter two standardize first expression profiles into z-scores
                over the samples and, in the case of \code{zscore}, it combines them together as their sum
                divided by the square-root of the size of the gene set,
                while in the case of \code{plage} they are used to calculate the singular value decomposition
                (SVD) over the genes in the gene set and use the coefficients of the first right-singular vector
                as pathway activity profile.}
  \item{kcdf}{Character string denoting the kernel to use during the non-parametric estimation of the
              cumulative distribution function of expression levels across samples when \code{method="gsva"}.
              By default, \code{kcdf="Gaussian"} which is suitable when input expression values are continuous,
              such as microarray fluorescent units in logarithmic scale, RNA-seq log-CPMs, log-RPKMs or log-TPMs.
              When input expression values are integer counts, such as those derived from RNA-seq experiments,
              then this argument should be set to \code{kcdf="Poisson"}. This argument supersedes arguments
              \code{rnaseq} and \code{kernel}, which are deprecated and will be removed in the next release.}
  \item{rnaseq}{This argument has been deprecated and will be removed in the next release. Please use the
                argument \code{kcdf} instead.}
  \item{abs.ranking}{Flag used only when \code{mx.diff=TRUE}. When \code{abs.ranking=FALSE} (default)
            a modified Kuiper statistic is used to calculate enrichment scores, taking the magnitude
            difference between the largest positive and negative random walk deviations. When
            \code{abs.ranking=TRUE} the original Kuiper statistic that sums the largest positive and
            negative random walk deviations, is used. In this latter case, gene sets with genes
            enriched on either extreme (high or low) will be regarded as 'highly' activated.}
  \item{min.sz}{Minimum size of the resulting gene sets.}
  \item{max.sz}{Maximum size of the resulting gene sets.}
  \item{no.bootstraps}{Number of bootstrap iterations to perform. This argument has been deprecated and will
                       be removed in the next release.}
  \item{bootstrap.percent}{.632 is the ideal percent samples bootstrapped. This argument has been deprecated and
                           will be removed in the next release.}
  \item{parallel.sz}{Number of processors to use when doing the calculations in parallel.
                     This requires to previously load either the \code{parallel} or the
                     \code{snow} library. If \code{parallel} is loaded and this argument
                     is left with its default value (\code{parallel.sz=0}) then it will use
                     all available core processors unless we set this argument with a
                     smaller number. If \code{snow} is loaded then we must set this argument
                     to a positive integer number that specifies the number of processors to
                     employ in the parallel calculation.}
  \item{parallel.type}{Type of cluster architecture when using \code{snow}.}
  \item{mx.diff}{Offers two approaches to calculate the enrichment statistic (ES)
                 from the KS random walk statistic. \code{mx.diff=FALSE}: ES is calculated as
                 the maximum distance of the random walk from 0. \code{mx.diff=TRUE} (default): ES
                 is calculated as the magnitude difference between the largest positive
                 and negative random walk deviations.}
  \item{tau}{Exponent defining the weight of the tail in the random walk performed by both the \code{gsva}
             (\enc{Hänzelmann}{Hanzelmann} et al., 2013) and the \code{ssgsea} (Barbie et al., 2009) methods. By default,
             this \code{tau=1} when \code{method="gsva"} and \code{tau=0.25} when \code{method="ssgsea"} just
             as specified by Barbie et al. (2009) where this parameter is called \code{alpha}.}
  \item{kernel}{This argument has been deprecated and will be removed in the next release. Please use the
                argument \code{kcdf} instead.}
  \item{ssgsea.norm}{Logical, set to \code{TRUE} (default) with \code{method="ssgsea"} runs the SSGSEA method
                     from Barbie et al. (2009) normalizing the scores by the absolute difference between
                     the minimum and the maximum, as described in their paper. When \code{ssgsea.norm=FALSE}
                     this last normalization step is skipped.}
  \item{verbose}{Gives information about each calculation step. Default: \code{FALSE}.}
  \item{return.old.value}{Logical, set to \code{FALSE} (default) has no effect but when \code{return.old.value=TRUE},
                          then the return value takes form of a \code{list} object as in previous versions of
                          GSVA. This argument will be present only in this release for backward compability
                          purposes during the deprecation of the arguments \code{no.bootstraps} and \code{bootstrap.percent}
                          and will dissappear in the next release.}
}

\details{
GSVA assesses the relative enrichment of gene sets across samples using
a non-parametric approach.  Conceptually, GSVA transforms a p-gene by n-sample
gene expression matrix into a g-geneset by n-sample pathway enrichment matrix.
This facilitates many forms of statistical analysis in the 'space' of pathways
rather than genes, providing a higher level of interpretability.

The \code{gsva()} function first maps the identifiers in the gene sets to the
identifiers in the input expression data leading to a filtered collection of
gene sets. This collection can be further filtered to require a minimun and/or
maximum size of the gene sets for which we want to calculate GSVA enrichment
scores, by using the arguments \code{min.sz} and \code{max.sz}.
}
\value{
A gene-set by sample matrix of GSVA enrichment scores.
}
\references{
Barbie, D.A. et al. Systematic RNA interference reveals that oncogenic KRAS-driven
cancers require TBK1. \emph{Nature}, 462(5):108-112, 2009.

\enc{Hänzelmann}{Hanzelmann}, S., Castelo, R. and Guinney, J.
GSVA: Gene set variation analysis for microarray and RNA-Seq data.
\emph{BMC Bioinformatics}, 14:7, 2013.

Lee, E. et al. Inferring pathway activity toward precise disease classification.
\emph{PLoS Comp Biol}, 4(11):e1000217, 2008.

Tomfohr, J. et al. Pathway level analysis of gene expression using singular value decomposition.
\emph{BMC Bioinformatics}, 6:225, 2005.
}
\author{J. Guinney and R. Castelo}
\seealso{
  \code{\link{filterGeneSets}}
  \code{\link{computeGeneSetsOverlap}}
}
\examples{

library(limma)

p <- 10 ## number of genes
n <- 30 ## number of samples
nGrp1 <- 15 ## number of samples in group 1
nGrp2 <- n - nGrp1 ## number of samples in group 2

## consider three disjoint gene sets
geneSets <- list(set1=paste("g", 1:3, sep=""),
                 set2=paste("g", 4:6, sep=""),
                 set3=paste("g", 7:10, sep=""))

## sample data from a normal distribution with mean 0 and st.dev. 1
y <- matrix(rnorm(n*p), nrow=p, ncol=n,
            dimnames=list(paste("g", 1:p, sep="") , paste("s", 1:n, sep="")))

## genes in set1 are expressed at higher levels in the last 'nGrp1+1' to 'n' samples
y[geneSets$set1, (nGrp1+1):n] <- y[geneSets$set1, (nGrp1+1):n] + 2

## build design matrix
design <- cbind(sampleGroup1=1, sampleGroup2vs1=c(rep(0, nGrp1), rep(1, nGrp2)))

## fit linear model
fit <- lmFit(y, design)

## estimate moderated t-statistics
fit <- eBayes(fit)

## genes in set1 are differentially expressed
topTable(fit, coef="sampleGroup2vs1")

## estimate GSVA enrichment scores for the three sets
gsva_es <- gsva(y, geneSets, mx.diff=1)

## fit the same linear model now to the GSVA enrichment scores
fit <- lmFit(gsva_es, design)

## estimate moderated t-statistics
fit <- eBayes(fit)

## set1 is differentially expressed
topTable(fit, coef="sampleGroup2vs1")

}
\keyword{Pathway variation}
