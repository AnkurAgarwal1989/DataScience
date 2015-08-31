# read and analyse HTML page
#doc.html = htmlTreeParse('http://biostat.jhsph.edu/~jleek/contact.html',
#                         useInternal = TRUE)

con = url('http://biostat.jhsph.edu/~jleek/contact.html')
htmlCode <- readLines(con)
close(con)
