using DelimitedFiles
wikiEVDraw = DelimitedFiles.readdlm("wikipediaEVDraw.csv", ',')

col1 = wikiEVDraw[:, 1] ;

for i = 1:length(col1)
    col1[i] = Dates.DateTime(col1[i], "d u y")  # note that this replaces the previous value in col1[i]
end

dayssincemar22(x) = Dates.datetime2rata(x) - Dates.datetime2rata(col1[54])
epidays = Array{Int64}(undef,54)
for i = 1:length(col1)
    epidays[i] = dayssincemar22(col1[i])
end

wikiEVDraw[:, 1] = epidays
DelimitedFiles.writedlm("wikipediaEVDdatesconverted.csv", wikiEVDraw, ',')

using DelimitedFiles
EVDdata = DelimitedFiles.readdlm("wikipediaEVDdatesconverted.csv", ',')  # don't forget the delimiter!
epidays = EVDdata[:, 1]  # Here ":" means all the entries in all rows of the specified columns
allcases = EVDdata[:, 2] # ditto---here, the specified columns is just column 2


plot(epidays, allcases,   # here are the data to be plotted, below are the attributes
title       = "West African EVD epidemic, total cases",
xlabel    = "Days since 22 March 2014",
ylabel    = "Total cases to date (three countries)",
marker  = (:diamond, 4),  # note the use of  parentheses to group the marker attributes into a composite of attributes
                          # and because we plot both the path and the points, we use plot rather than scatter
line         = (:path, "black"),   # line attributes likewise put together as one unit by the use of parantheses
legend   = true,
grid        = true)

savefig("WAfricanEVD.pdf")


using DelimitedFiles
EVDdata = DelimitedFiles.readdlm("wikipediaEVDdatesconverted.csv", ',') # again: don't forget the delimiter!
EVDdata[end-9:end, :]

rows, cols = size(EVDdata)  # size() is a very useful function ... look it up with "? size"
for j = 1:cols
    for i = 1:rows  # this order goes does one column at a time
       if !isdigit(string(EVDdata[i, j])[1]) # remember that "!" is the NOT operator (week 1, lecture 5)
         EVDdata[i,j] = 0
       end
   end
end

# extract the data
epidays = EVDdata[:,1]
#EVDcasesbycountry = EVDdata[:, [4, 6, 8]]

# load Plots and plot them


epidays = EVDdata[:,1]
# Original array: EVDcasesbycountry = EVDdata[:, [4, 6, 8]], change it to
EVDcasesbycountry = [EVDdata[:,4] EVDdata[:,6] EVDdata[:,8]]
gr()
plot(epidays, EVDcasesbycountry, title="Days vs Ebola cases in each country", label=["Guinea" "Liberia" "Sierra Leone"], xlabel="Days", ylabel="Cases", marker=([:diamond :octagon :star7],3), line=(:path,"gray"))

savefig("three_countries.pdf")

f(x) = 3 * x^2 + 6 * x - 9
for x = -5:5
  println("(",x, ", ", f(x), ")")
end
using Plots
plotly()# Activate the GR backend for use with Plots
plot(f, -4, 3) # plot f over [-4,4]
plot!(zero, -4, 3)
