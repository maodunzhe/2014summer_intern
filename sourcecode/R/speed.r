## rec_rate for speed more than 1
match = read.table('match.txt', colClasses = c('numeric', 'numeric', 'numeric', 'numeric', 'numeric'))
unmatch = read.table('unmatch.txt', colClasses = c('numeric', 'numeric', 'numeric', 'numeric'))
rec_rate_total = nrow(match)/(nrow(match) + nrow(unmatch))
max(unmatch$V4)
max(match$V5)

## calculate the rec_rate for different speed intervals
rate = rep(0,9)
for (i in 1:8){
  rate[i] = nrow(subset(match, V5 > 5*i-5 & V5 < 5*i))/(nrow(subset(match, V5 > 5*i-5 & V5 < 5*i)) + nrow(subset(unmatch, V4 > 5*i-5 & V4 < 5*i)))
}
rate[9] = nrow(subset(match, V5 > 40))/(nrow(subset(match, V5 > 40)) + nrow(subset(unmatch, V4 > 40)))
plot(c(seq(5,40,5), 100), rate, type = 'l')
barplot(rate, main ='recrate_speed', xlab = 'speed', ylab = 'rec_rate', names.arg = c('5', '10', '15', '20', '25', '30', '35', '40', '>40'), ylim = c(0,1))
