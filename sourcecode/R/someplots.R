## the difference between the rec_rate in several cities and the rec_rate after unique the data
quartz()
old <- c(0.7008267,0.769194,0.7560217,0.7744415,0.7592593,0.8018643,0.8032501,0.7687524,0.7927732,0.7694067)
uni <- c(0.7682113,0.8216702,0.8128674,0.8262272,0.8130931,0.8446931,0.8407636,0.8179634,0.8432224,0.8236713)
plot(old,type='o',col="blue",ylim = range(0.65,0.9),axes=FALSE,ann = FALSE)
axis(1,at = 1:10, lab = c("NY","LA","CH","HO","PH","PO","SA","SD","DA","SJ"))
axis(2, las=1)
box()
lines(uni,type = "o",pch = 22, lty = 2, col="red")
title(main = "recognition rate comparison after processing", col.main = "red", font.main = 4)
title(xlab = "cities")
title(ylab = "rec_rate")
legend(1,0.9,c("original","unique"),cex = 0.8,col=c("blue","red"),pch=21:22,lty=1:2)

## breifly show the rec_rate for 4 different types of venues in NY and CA
quartz()
ny = c(0.69,0.676,0.759,0.672)
ca = c(0.679,0.752,0.7025,0.631)
comb = as.matrix(rbind(ny,ca))
colnames(comb) = c("bar","education","shopping","theatre")
barplot(comb,main="rec_rate for different types of POI",ylab = "rec_rate",ylim = range(0,1),beside = TRUE,col = rainbow(2))
legend("topleft",c("NY","CA"),cex = 0.6,bty = 'n',fill = rainbow(2))

#rec_rate for 20 types:
quartz()
rec_rate = c(0.3395833, 0.4809322, 0.5524086, 0.5661130, 0.5836112, 0.6140351, 0.6413600, 0.6837068, 0.7076923, 0.7109527, 0.7187704, 0.7279217, 0.7296675, 0.7403259, 0.7469973, 0.7645420, 0.7662769, 0.7753655, 0.7864322, 0.8206388 )
barplot(rec_rate, main = "rec_rate for 20 types of venue", ylab = "rec_rate", ylim = range(0,1), xlab = " 20 types", beside = TRUE, col = heat.colors(20))
legend("topleft", c("stadium", "convention", "theatre", "bar", "attraction", "gym", "hotel", "restaurant", "transportation", "factory", "residential", "school", "building", "bank", "shopping", "church", "parking", "hostipal", "townhall", "gas"), cex = 0.6,bty = 'n',fill = heat.colors(20))

#rec_rate for bad/good places show on presentation
quartz()
type_number = c(5, 1, 5, 1, 6, 1, 3, 2, 1, 1, 1, 1)
good_name = c('residential','shopping','parking','anchorage')
type_name = c('stadium','restaurant','theatre','NULL','bar','building','residential','hotel','church','convention','airport','shop')
pie(type_number, main = "bad_types",col = rainbow(length(type_number)), labels = c('stadium','restaurant','theatre','NULL','bar','building','residential','hotel','church','convention','airport','shop'))
pie(c(3, 3, 2, 1), main = 'good_types', col = rainbow(4), labels = good_name)

