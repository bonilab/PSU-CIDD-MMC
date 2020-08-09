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