data = load '/pig/stocks' using PigStorage()as (market: chararray, stockname : chararray, date:chararray, open:float, high:float, low:float, close:float, volume:long,overall:float);
project = foreach data generate stockname, volume;
gprd = group project by stockname;
cntd = foreach gprd generate group, COUNT(project.stockname);
volume = foreach gprd generate group, SUM(project.volume);
store cntd into '/pig/counts' using PigStorage();
store volume into '/pig/volume' using PigStorage();
