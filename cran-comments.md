## R CMD check results

0 errors | 0 warnings | 2 notes

* Dear maintainer, I struggle to replicate the Mac M1 error you reported last time. All rhub and devtools checks pass, also on Mac M1. If this happens again, I will have to set \donttest on the CSV files. From what I get from your reported error, it fails reading regular CSV files. That seems more like a base R problem than my package (if I can be so arrogant).

