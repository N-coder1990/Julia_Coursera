using DelimitedFiles
wikiEVDraw_check1 = DelimitedFiles.readdlm("wikipediaEVDraw.csv", ',')

col1 = wikiEVDraw[:, 1] ;

for i = 1:length(col1)
    col1[i] = Dates.DateTime(col1[i], "d u y")  # note that this replaces the previous value in col1[i]
end
