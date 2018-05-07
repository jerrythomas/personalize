#!/bin/zsh

if [ $# -eq 0 ]
then
   echo "Please provide virtual env for linking opencv."
fi

When generating the epub output 

OS: macOS Sierra 10.12.6 
RStudio Server 1.0.153
R: 3.4.2
MacTex

Build options 
Project Build tools <website>
Book output format <bookdown::epub_book>


For general questions, please ask them on StackOverflow first, using the tags `r` and `bookdown`: http://stackoverflow.com/questions/ask Please come back here only if nobody answers your question there, and let us know the URL of your StackOverflow post. If you are not sure whether to post a StackOverflow question or open a Github issue, do the former first.

For bug reports, please try the development version first: `devtools::install_github('rstudio/bookdown')`. If it still does not work, please provide a minimal, self-contained, and reproducible example by reducing your example as much as possible right before the problem goes away. By doing this, you may be able to figure out what the problem really is before reporting to me. You can attach your example as a zip file here, and screenshots are often very helpful to illustrate your issues. You may consider creating your reproducible example based on https://github.com/yihui/bookdown-minimal. Please include the following info with your bug report:

I tried generating the epub for the bookdown demo, and the resulting epub did not contain the graphs and charts. I was able to see the graphs and charts in the generated PDF.

https://bookdown.org/yihui/bookdown-demo/ I ran bookdown::render_book('index.Rmd', 'all') to generate the supported formats.

On expanding the epub and looking into the generated code I see that media folder is not inside the EPUB folder and the link for the image expects this. Changing

to

resolves this.

Is there a setting to control the location of the media folder?
```{r}
devtools::session_info('bookdown')
Session info --------------------------------------------------------------------------------------------------------
 setting  value                       
 version  R version 3.4.2 (2017-09-28)
 system   x86_64, darwin16.7.0        
 ui       RStudio (1.0.153)           
 language (EN)                        
 collate  en_US.UTF-8                 
 tz       Asia/Kolkata                
 date     2017-11-08                  

Packages ------------------------------------------------------------------------------------------------------------
 package   * version    date       source                            
 backports   1.1.1      2017-09-25 CRAN (R 3.4.2)                    
 base64enc   0.1-3      2015-07-28 CRAN (R 3.4.2)                    
 bitops      1.0-6      2013-08-17 CRAN (R 3.4.2)                    
 bookdown    0.5        2017-08-20 CRAN (R 3.4.2)                    
 caTools     1.17.1     2014-09-10 CRAN (R 3.4.2)                    
 digest      0.6.12     2017-01-27 CRAN (R 3.4.2)                    
 evaluate    0.10.1     2017-06-24 CRAN (R 3.4.2)                    
 graphics  * 3.4.2      2017-09-29 local                             
 grDevices * 3.4.2      2017-09-29 local                             
 highr       0.6        2016-05-09 CRAN (R 3.4.2)                    
 htmltools   0.3.6      2017-04-28 CRAN (R 3.4.2)                    
 jsonlite    1.5        2017-06-01 CRAN (R 3.4.2)                    
 knitr       1.17       2017-08-10 CRAN (R 3.4.2)                    
 magrittr    1.5        2014-11-22 CRAN (R 3.4.2)                    
 markdown    0.8        2017-04-20 CRAN (R 3.4.2)                    
 methods   * 3.4.2      2017-09-29 local                             
 mime        0.5        2016-07-07 CRAN (R 3.4.2)                    
 Rcpp        0.12.13    2017-09-28 CRAN (R 3.4.2)                    
 rmarkdown   1.6.0.9009 2017-11-08 Github (rstudio/rmarkdown@6e68143)
 rprojroot   1.2        2017-01-16 CRAN (R 3.4.2)                    
 stats     * 3.4.2      2017-09-29 local                             
 stringi     1.1.5      2017-04-07 CRAN (R 3.4.2)                    
 stringr     1.2.0      2017-02-18 CRAN (R 3.4.2)                    
 tools       3.4.2      2017-09-29 local                             
 utils     * 3.4.2      2017-09-29 local                             
 yaml        2.1.14     2016-11-12 CRAN (R 3.4.2)                    
> rmarkdown::pandoc_version()
[1] ‘2.0.1.1’
> system('pdflatex --version')
pdfTeX 3.14159265-2.6-1.40.18 (TeX Live 2017)
kpathsea version 6.2.3
Copyright 2017 Han The Thanh (pdfTeX) et al.
There is NO warranty.  Redistribution of this software is
covered by the terms of both the pdfTeX copyright and
the Lesser GNU General Public License.
For more information about these matters, see the file
named COPYING and the pdfTeX source.
Primary author of pdfTeX: Han The Thanh (pdfTeX) et al.
Compiled with libpng 1.6.29; using libpng 1.6.29
Compiled with zlib 1.2.11; using zlib 1.2.11
Compiled with xpdf version 3.04
```



prerequisites for building the bookdown

Getting Started
git clone

On macOS
```bash
brew install NLopt
```
Inside R
```r
    install.packages(c('car','yarrr'))
```
