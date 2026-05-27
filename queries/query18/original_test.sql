CREATE TABLE t0 (
            c0 TEXT,
            c1 TEXT,
            c2 BOOLEAN,
            c3 BOOLEAN,
            c4 TEXT
        );
         SELECT subq1.c5 AS c6
        FROM (SELECT FALSE AS c5
           FROM (SELECT t1.c3 AS c5, t1.c2 AS c6, t1.c2 AS c7
               FROM t0 AS t1
               WHERE t1.c1 >= t1.c1
               ORDER BY c6, c7 ASC, c7
               LIMIT 5114586222650338778 ) as subq0
             INNER JOIN t0 AS t2
              ON (subq0.c6 = t2.c3 AND subq0.c7 <> subq0.c6 AND true)
           WHERE true
           ORDER BY c5) as subq1
        WHERE subq1.c5 <> subq1.c5 AND subq1.c5 <> subq1.c5 AND subq1.c5 =
         CASE WHEN NULLIF(subq1.c5, subq1.c5) = subq1.c5 OR subq1.c5 <>
          CASE subq1.c5 WHEN subq1.c5 = subq1.c5 OR subq1.c5 = subq1.c5 THEN subq1.c5
               WHEN true THEN subq1.c5
               ELSE subq1.c5
          END THEN subq1.c5
              ELSE subq1.c5
         END
        ORDER BY c6 COLLATE RTRIM DESC, c6, c6, c6 COLLATE NOCASE ASC;
