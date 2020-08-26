-- Select the results for the without seasonaltiy
SELECT replicateid,
  filename,
  cast((regexp_matches(filename, 'mmc-([\.\d]*)-([\.\d]*)\.yml'))[2] as float) as beta,
  avg(eir) AS eir, 
  avg(pfprunder5) AS pfprunder5, 
  avg(pfpr2to10) AS pfpr2to10, 
  avg(pfprall) AS pfprall
FROM sim.configuration c
  INNER JOIN sim.replicate r on r.configurationid = c.id
  INNER JOIN sim.monthlydata md on md.replicateid = r.id
  INNER JOIN sim.monthlysitedata msd on msd.monthlydataid = md.id
WHERE studyid = 5
  AND md.dayselapsed >= 3987
GROUP BY replicateid, filename
ORDER BY beta

-- Select the results for the with seasonaltiy
SELECT replicateid,
  filename,
  dayselapsed,
  cast((regexp_matches(filename, 'mmc-rain-([\.\d]*)-([\.\d]*)\.yml'))[2] as float) as beta,
  eir, 
  pfprunder5, 
  pfpr2to10, 
  pfprall
FROM sim.configuration c
  INNER JOIN sim.replicate r on r.configurationid = c.id
  INNER JOIN sim.monthlydata md on md.replicateid = r.id
  INNER JOIN sim.monthlysitedata msd on msd.monthlydataid = md.id
WHERE studyid = 5
  AND md.dayselapsed >= 3987
ORDER BY beta, dayselapsed

-- Extended analysis query for run that steps through base values, without seasonality
SELECT replicateid,
  filename,
  cast((regexp_matches(filename, 'mmc-(\d*\.\d*)-(\d*\.\d*)-(\d*\.\d*)\.yml'))[2] as float) as base,
  cast((regexp_matches(filename, 'mmc-(\d*\.\d*)-(\d*\.\d*)-(\d*\.\d*)\.yml'))[3] as float) as beta,
  avg(eir) AS eir, 
  avg(pfprunder5) AS pfprunder5, 
  avg(pfpr2to10) AS pfpr2to10, 
  avg(pfprall) AS pfprall
FROM sim.configuration c
  INNER JOIN sim.replicate r on r.configurationid = c.id
  INNER JOIN sim.monthlydata md on md.replicateid = r.id
  INNER JOIN sim.monthlysitedata msd on msd.monthlydataid = md.id
WHERE studyid = 6
  AND md.dayselapsed >= 3987
GROUP BY replicateid, filename
ORDER BY base, beta

-- Extended analysis query for run that steps through base values, with seasonality
SELECT replicateid,
  filename,
  dayselapsed,
  cast((regexp_matches(filename, 'mmc-(\d*\.\d*)-(\d*\.\d*)-(\d*\.\d*)\.yml'))[2] as float) as base,
  cast((regexp_matches(filename, 'mmc-(\d*\.\d*)-(\d*\.\d*)-(\d*\.\d*)\.yml'))[3] as float) as beta,
  eir, 
  pfprunder5, 
  pfpr2to10, 
  pfprall
FROM sim.configuration c
  INNER JOIN sim.replicate r on r.configurationid = c.id
  INNER JOIN sim.monthlydata md on md.replicateid = r.id
  INNER JOIN sim.monthlysitedata msd on msd.monthlydataid = md.id
WHERE studyid = 6
  AND md.dayselapsed >= 3987
ORDER BY base, beta, dayselapsed