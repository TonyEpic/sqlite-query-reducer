CREATE TABLE t0 (
    c0 BOOLEAN,
    c1 INTEGER,
    c2 BOOLEAN,
    c3 TEXT,
    c4 NULL,
    c5 INTEGER,
    c6 BOOLEAN
);
INSERT INTO t0 VALUES (FALSE, 1, FALSE, 'text16', NULL, COALESCE(72, 81, 25, 72), FALSE);
UPDATE t0 
SET c0 = t0.c0, c3 = upper( 77), c4 = t0.c4
WHERE 
 CASE t0.c3 WHEN t0.c1 >= t0.c5 THEN t0.c3
      WHEN t0.c1 >= t0.c1 THEN t0.c3
      WHEN EXISTS (
  SELECT t2.c4 AS c7, t2.c2 AS c8, t1.c2 AS c9, NULL AS c10, t1.c0 AS c11, t1.c6 AS c12, t1.c4 AS c13
   FROM t0 AS t1
     LEFT JOIN t0 AS t2     
      ON (t1.c4 <> t2.c4)
   WHERE EXISTS (
    SELECT t3.c4 AS c7, t3.c3 AS c8, t3.c2 AS c9, t3.c3 AS c10, t3.c0 AS c11, t3.c4 AS c12, t3.c3 AS c13
     FROM t0 AS t3
     WHERE EXISTS (
      SELECT t4.c5 AS c7, t4.c6 AS c8, t4.c2 AS c9, t4.c1 AS c10, t4.c4 AS c11, t4.c1 AS c12
       FROM t0 AS t4
       WHERE t4.c5 > 91 AND t4.c4 IS NOT NULL OR 46 <= t4.c1
       ORDER BY c11 ASC, c9, c12 ASC
      )
     ORDER BY c9, c8 ASC
    )
   ORDER BY c13, c10
  ) THEN quote( TRUE)
      WHEN t0.c2 <> t0.c0 THEN t0.c3
      WHEN t0.c0 <> t0.c2 AND t0.c4 = t0.c4 AND t0.c5 IS NULL OR 
  CASE t0.c0 WHEN t0.c2 <> t0.c6 THEN t0.c0
       WHEN COALESCE(t0.c4, t0.c2, t0.c4, t0.c6) <> t0.c2 THEN t0.c6
       WHEN t0.c4 = COALESCE(t0.c4, t0.c4, t0.c0, t0.c4, t0.c4) THEN t0.c6
       WHEN EXISTS (
   SELECT t5.c3 AS c7, t7.c4 AS c8, t7.c2 AS c9, t6.c2 AS c10, t5.c3 AS c11, t6.c3 AS c12
    FROM t0 AS t5
      INNER JOIN (
      t0 AS t6
       LEFT JOIN t0 AS t7       
        ON (t6.c3 = t7.c3)      )
       ON (t7.c0 IS NOT NULL AND t5.c5 <= t5.c5)
    WHERE t6.c1 = t7.c5 OR t7.c5 = 61 OR false OR FALSE <> t5.c2
    ORDER BY c7 ASC
   ) AND t0.c1 > t0.c5 OR t0.c5 <= t0.c5 AND t0.c6 IS NULL THEN t0.c0
       WHEN t0.c6 <> t0.c6 THEN t0.c0
       WHEN t0.c2 <> t0.c0 AND false AND 
   CASE WHEN t0.c3 >= t0.c3 THEN t0.c2
        ELSE FALSE
   END = t0.c2 OR EXISTS (
   SELECT t8.c4 AS c7, t8.c5 AS c8, t8.c0 AS c9, t8.c0 AS c10, t8.c1 AS c11, 59 AS c12, t8.c4 AS c13, t8.c1 AS c14, FALSE AS c15, t8.c2 AS c16
    FROM t0 AS t8
    WHERE t8.c6 = FALSE OR t8.c0 = t8.c0
    ORDER BY c8, c14 COLLATE NOCASE DESC, c9 COLLATE NOCASE
    LIMIT 4633730287411729534 
   ) OR NULLIF(t0.c5, t0.c1) <= t0.c5 THEN t0.c2
       WHEN t0.c0 <> t0.c0 THEN t0.c2
       WHEN t0.c2 <> t0.c6 OR t0.c0 IS NOT NULL AND EXISTS (
   SELECT t9.c5 AS c7, t9.c3 AS c8, t9.c0 AS c9, t9.c2 AS c10, t9.c2 AS c11, t9.c6 AS c12, t9.c4 AS c13, t9.c5 AS c14, t9.c3 AS c15, t9.c6 AS c16, t9.c5 AS c17, t9.c5 AS c18, t9.c2 AS c19, t9.c4 AS c20, t9.c2 AS c21, t9.c5 AS c22, TRUE AS c23, NULLIF(t9.c4, t9.c4) AS c24
    FROM t0 AS t9
    WHERE t9.c0 = t9.c6
    ORDER BY c10, c15, c17 ASC
   ) THEN 
   CASE WHEN false THEN t0.c2
        ELSE t0.c6
   END
       ELSE t0.c2
  END = 
  CASE WHEN 
   CASE WHEN t0.c2 <> FALSE THEN t0.c6
        ELSE trim( 'text11')
   END IS NULL THEN 
   CASE WHEN true THEN t0.c6
        ELSE t0.c6
   END
       ELSE IFNULL(t0.c6, t0.c0)
  END AND false AND t0.c5 >= t0.c1 THEN t0.c3
      WHEN t0.c3 >= t0.c3 AND length( FALSE) <= IFNULL(t0.c1, t0.c1) THEN COALESCE(t0.c4, t0.c4)
      WHEN EXISTS (
  SELECT t12.c2 AS c7, t10.c6 AS c8, t11.c1 AS c9, t12.c1 AS c10, 
    CASE t12.c4 WHEN t11.c5 > t10.c5 THEN t11.c4
         ELSE t10.c4
    END AS c11, NULLIF(t11.c4, t10.c4) AS c12, t12.c6 AS c13, t11.c5 AS c14, CAST(t12.c2 AS BOOLEAN) AS c15, t11.c3 AS c16, NULLIF(t12.c3, t10.c3) AS c17, t12.c3 AS c18, t12.c6 AS c19
   FROM t0 AS t10
     LEFT JOIN (
     t0 AS t11
      LEFT JOIN t0 AS t12      
       ON (t12.c4 IS NOT NULL)     )
      ON (t10.c1 = t11.c1)
   WHERE false
   ORDER BY c16 DESC, c19 DESC
   LIMIT 6435163214005728455 OFFSET 8629639050956326708
  ) OR t0.c1 IS NULL THEN t0.c3
      WHEN t0.c6 <> t0.c6 THEN t0.c3
      ELSE t0.c3
 END < t0.c3;
INSERT INTO t0 VALUES (TRUE, likely( FALSE), TRUE, 'text75', NULL, 26, FALSE);
INSERT INTO t0 VALUES (FALSE, 8, FALSE, 'text58', NULL, 74, TRUE);
SELECT 
 CASE WHEN EXISTS (
  SELECT subq0.c7 AS c9, subq0.c7 AS c10
   FROM (SELECT t2.c4 AS c7, t2.c3 AS c8
      FROM t0 AS t2
      WHERE t2.c6 <> t2.c6
      ORDER BY c7 ASC, c7 ASC, c8 ASC, c8
      LIMIT 4596198378779748402 ) as subq0
   WHERE subq0.c7 = subq0.c7
   ORDER BY c9 ASC, c9 ASC, c10 COLLATE BINARY, c10 COLLATE BINARY ASC
   LIMIT 9097190617891523017 OFFSET 141125230431790772
  ) THEN changes()
      ELSE t1.c1
 END AS c11
FROM t0 AS t1
WHERE EXISTS (
 SELECT COALESCE(subq1.c7, subq1.c7) AS c13, subq1.c7 AS c14, subq1.c7 AS c15
  FROM (SELECT t3.c5 AS c7
     FROM t0 AS t3
     WHERE t3.c3 >= 
      CASE WHEN EXISTS (
       SELECT t4.c6 AS c7, t4.c4 AS c8, t4.c6 AS c9, t4.c4 AS c10, t4.c3 AS c11, t4.c5 AS c12
        FROM t0 AS t4
        WHERE t4.c5 > 72
        ORDER BY c7 DESC
        LIMIT 3431712274741883048 OFFSET 6533196285066786549
       ) THEN t3.c3
           ELSE 'text79'
      END
     ORDER BY c7 DESC, c7, c7 COLLATE BINARY, c7
     LIMIT 721207036067724971 OFFSET 2518762366882936071) as subq1
  WHERE subq1.c7 <= 1 OR like(FALSE,'text50') <> subq1.c7 AND subq1.c7 > 
   CASE subq1.c7 WHEN 58 >= subq1.c7 THEN subq1.c7
        WHEN subq1.c7 IS NULL THEN subq1.c7
        ELSE subq1.c7
   END
  ORDER BY c13 ASC, c13 DESC, c14
  LIMIT 4155752516192917743 OFFSET 7535720965498394099
 )
ORDER BY c11 DESC, c11, c11, c11
LIMIT 8477245600676270679 OFFSET 8568739569047950690;
INSERT INTO t0 VALUES (TRUE, 15, FALSE, CAST(100 AS TEXT), NULL, IFNULL(62, 91), TRUE);
SELECT t1.c6 AS c7, t1.c0 AS c8, t1.c5 AS c9, t1.c4 AS c10
FROM t0 AS t1
WHERE t1.c0 = t1.c0
ORDER BY c7, c9;
INSERT INTO t0 VALUES (TRUE, 83, FALSE, 'text66', NULL, 3, FALSE);
SELECT subq0.c8 AS c7, t3.c4 AS c8, subq0.c11 AS c9, 
 CASE t3.c1 WHEN subq0.c15 = IFNULL(t3.c6, 
   CASE WHEN max(94,TRUE,FALSE) IS NOT NULL THEN subq0.c9
        ELSE subq0.c9
   END) THEN t3.c1
      WHEN CAST(subq0.c8 AS INTEGER) = subq0.c15 THEN t3.c5
      WHEN subq0.c15 <> t3.c2 THEN subq0.c14
      WHEN subq0.c12 = t3.c3 THEN subq0.c11
      WHEN false OR t3.c2 = TRUE THEN t3.c1
      WHEN FALSE IS NULL OR t3.c0 IS NULL OR EXISTS (
  SELECT t4.c0 AS c7, COALESCE(
     CASE t4.c3 WHEN EXISTS (
      SELECT t5.c2 AS c7, t5.c5 AS c8, t5.c3 AS c9, t5.c4 AS c10, t5.c6 AS c11, t5.c3 AS c12, 'text26' AS c13, t5.c0 AS c14, t5.c3 AS c15, t5.c6 AS c16, t5.c1 AS c17, t5.c3 AS c18, t5.c4 AS c19
       FROM t0 AS t5
       WHERE t5.c2 <> t5.c6
       ORDER BY c11
       LIMIT 8367844154338802670 OFFSET 4897869847856910543
      ) THEN t4.c4
          WHEN true THEN t4.c3
          WHEN t4.c6 = t4.c0 OR t4.c1 = t4.c5 THEN t4.c0
          WHEN t4.c0 <> t4.c2 THEN t4.c0
          WHEN t4.c3 = t4.c3 AND t4.c6 IS NOT NULL THEN t4.c1
          WHEN 8 > t4.c1 THEN t4.c2
          WHEN t4.c5 IS NOT NULL THEN t4.c3
          ELSE t4.c0
     END, t4.c4, t4.c1, t4.c1, t4.c5) AS c20, t4.c0 AS c21, 'text83' AS c22, t4.c5 AS c23, t4.c1 AS c24, t4.c5 AS c25, t4.c2 AS c26, t4.c6 AS c27, t4.c4 AS c28, t4.c4 AS c29, t4.c2 AS c30
   FROM t0 AS t4
   WHERE EXISTS (
    SELECT t6.c1 AS c7, t6.c6 AS c8, t6.c1 AS c9, t6.c0 AS c10, t6.c5 AS c11, t6.c5 AS c12, t6.c4 AS c13, t6.c2 AS c14, t6.c1 AS c15, t6.c5 AS c16, t6.c3 AS c17, t6.c5 AS c18
     FROM t0 AS t6
     WHERE t6.c0 = t6.c0
     ORDER BY c9 COLLATE NOCASE ASC
     LIMIT 5928330123659345534 OFFSET 1119749379068271269
    )
   ORDER BY c24, c7 ASC, c22 DESC
  ) AND 
  CASE WHEN t3.c2 IS NOT NULL THEN subq0.c10
       ELSE subq0.c10
  END IS NOT NULL OR subq0.c17 IS NOT NULL OR subq0.c8 <> subq0.c8 AND subq0.c16 <> subq0.c16 AND 56 >= t3.c1 THEN subq0.c11
      WHEN t3.c1 >= CAST(subq0.c16 AS INTEGER) THEN subq0.c17
      WHEN like('text4',TRUE) IS NULL THEN t3.c1
      ELSE subq0.c17
 END AS c19, t3.c3 AS c20, subq0.c7 AS c21, FALSE AS c22, subq0.c9 AS c23, 
 CASE WHEN subq0.c14 IS NULL THEN subq0.c15
      ELSE subq0.c13
 END AS c24, FALSE AS c25, subq0.c15 AS c26, 
 CASE WHEN NULL <> t3.c4 THEN subq0.c16
      ELSE NULL
 END AS c27, subq0.c16 AS c28, t3.c3 AS c29, subq0.c17 AS c30, subq0.c16 AS c31, subq0.c8 AS c32, subq0.c8 AS c33
FROM (SELECT t1.c3 AS c7, t1.c5 AS c8, t1.c6 AS c9, t1.c0 AS c10, t1.c5 AS c11, t1.c3 AS c12, t1.c2 AS c13, t1.c1 AS c14, t1.c0 AS c15, t1.c4 AS c16, t1.c5 AS c17
    FROM t0 AS t1
    WHERE EXISTS (
     SELECT t2.c0 AS c7, t2.c4 AS c8, t2.c3 AS c9, t2.c5 AS c10
      FROM t0 AS t2
      WHERE t2.c3 < t2.c3
      ORDER BY c8 DESC, c7
      LIMIT 8487782910337437069 OFFSET 8940054953469969540
     )
    ORDER BY c14 ASC, c15 ASC
    LIMIT 5241486417947844697 ) as subq0
  LEFT JOIN t0 AS t3  
   ON (t3.c5 IS NULL)
WHERE false
ORDER BY c32 ASC;
SELECT t1.c3 AS c7, t1.c4 AS c8, t1.c5 AS c9, t1.c1 AS c10, t1.c2 AS c11, t1.c5 AS c12, t1.c3 AS c13, t1.c5 AS c14, t1.c2 AS c15, t1.c0 AS c16, t1.c0 AS c17, t1.c3 AS c18, t1.c3 AS c19, t1.c5 AS c20, CAST(t1.c3 AS TEXT) AS c21, t1.c0 AS c22, t1.c5 AS c23
FROM t0 AS t1
WHERE t1.c5 <= t1.c5
ORDER BY c15, c22, c13
LIMIT 5026372734866574904 OFFSET 2489761886038288292;
SELECT 
 CASE WHEN subq1.c13 <> subq1.c13 THEN subq1.c13
      ELSE subq1.c13
 END AS c14, subq1.c13 AS c15, subq1.c13 AS c16, CAST(subq1.c13 AS TEXT) AS c17, subq1.c13 AS c18
FROM (SELECT FALSE AS c13
   FROM (SELECT TRUE AS c7, t1.c1 AS c8, t1.c2 AS c9, t1.c2 AS c10, t1.c5 AS c11, t1.c1 AS c12
      FROM t0 AS t1
      WHERE 89 > t1.c1
      ORDER BY c9, c11 COLLATE NOCASE ASC
      LIMIT 2316622805712276698 ) as subq0
   WHERE true
   ORDER BY c13, c13, c13, c13 ASC) as subq1
WHERE subq1.c13 = 
 CASE subq1.c13 WHEN subq1.c13 = subq1.c13 THEN subq1.c13
      ELSE subq1.c13
 END OR subq1.c13 = NULLIF(subq1.c13, subq1.c13) OR subq1.c13 IS NOT NULL AND subq1.c13 = subq1.c13
ORDER BY c15, c17, c15 ASC
LIMIT 8255429340041652679 OFFSET 7309356072816970115;
SELECT subq0.c14 AS c11
FROM (SELECT t1.c5 AS c7, t1.c4 AS c8, 96 AS c9, 
    CASE t1.c6 WHEN t1.c6 = t1.c2 THEN t1.c6
         WHEN t1.c3 >= t1.c3 AND t1.c3 <= t1.c3 OR EXISTS (
     SELECT t2.c1 AS c7, t2.c3 AS c8, t2.c1 AS c9
      FROM t0 AS t2
      WHERE t2.c2 IS NOT NULL
      ORDER BY c8, c9, c8
      LIMIT 8073623243054982113 
     ) THEN t1.c2
         WHEN t1.c5 = t1.c1 THEN t1.c0
         ELSE 
     CASE WHEN false THEN t1.c0
          ELSE t1.c0
     END
    END AS c10, t1.c3 AS c11, t1.c3 AS c12, t1.c3 AS c13, COALESCE(t1.c1, t1.c4) AS c14, t1.c4 AS c15
   FROM t0 AS t1
   WHERE t1.c6 = t1.c0 AND t1.c2 <> t1.c2 OR t1.c2 = 
    CASE t1.c0 WHEN EXISTS (
     SELECT 5 AS c7, t3.c2 AS c8, t3.c3 AS c9, TRUE AS c10
      FROM t0 AS t3
      WHERE t3.c5 <> t3.c1
      ORDER BY c8, c8 DESC, c10
     ) THEN t1.c2
         WHEN t1.c5 >= t1.c1 THEN t1.c2
         WHEN t1.c0 <> t1.c6 THEN t1.c6
         ELSE t1.c2
    END
   ORDER BY c10, c11 ASC) as subq0
WHERE EXISTS (
 SELECT subq1.c8 AS c11, subq1.c8 AS c12, subq2.c10 AS c13, subq2.c9 AS c14, subq2.c8 AS c15
  FROM (SELECT t4.c3 AS c7, t4.c4 AS c8
      FROM t0 AS t4
      WHERE t4.c6 = t4.c0 AND 28 < t4.c1
      ORDER BY c8 COLLATE BINARY
      LIMIT 4537694807183241409 ) as subq1
    LEFT JOIN (SELECT t5.c4 AS c7, t5.c3 AS c8, t5.c4 AS c9, t5.c0 AS c10
      FROM t0 AS t5
      WHERE t5.c1 IS NOT NULL
      ORDER BY c9) as subq2    
     ON (subq2.c9 = subq2.c7)
  WHERE subq2.c8 = subq2.c8
  ORDER BY c11 COLLATE RTRIM
  LIMIT 8121752498674788175 OFFSET 1590141587996445005
 ) AND subq0.c12 <> subq0.c13
ORDER BY c11, c11, c11 DESC, c11 COLLATE BINARY ASC
LIMIT 5264995973287149286 OFFSET 5022098690157832144;
SELECT COALESCE(subq0.c7, subq0.c8) AS c10
FROM (SELECT t3.c6 AS c7, t3.c6 AS c8, t3.c2 AS c9
   FROM t0 AS t1
      LEFT OUTER JOIN t0 AS t2      
       ON (t1.c1 >= t2.c1)
     INNER JOIN t0 AS t3     
      ON (t3.c3 < t1.c3)
   WHERE t2.c4 IS NOT NULL
   ORDER BY c9 COLLATE BINARY, c7, c9
   LIMIT 8872177644813134736 ) as subq0
WHERE 
 CASE WHEN subq0.c8 = subq0.c8 THEN subq0.c8
      ELSE subq0.c9
 END = 
 CASE WHEN subq0.c8 = subq0.c9 AND subq0.c9 <> subq0.c8 AND 
  CASE WHEN subq0.c8 = COALESCE(subq0.c9, subq0.c9) THEN subq0.c8
       ELSE subq0.c9
  END = CAST(subq0.c7 AS TEXT) THEN subq0.c7
      ELSE subq0.c9
 END
ORDER BY c10 DESC;
SELECT subq1.c22 AS c25, subq1.c24 AS c26, subq1.c22 AS c27, subq1.c18 AS c28, NULL AS c29
FROM (SELECT subq0.c8 AS c9, subq0.c8 AS c10, subq0.c7 AS c11, subq0.c8 AS c12, subq0.c7 AS c13, subq0.c7 AS c14, subq0.c7 AS c15, subq0.c7 AS c16, COALESCE(subq0.c8, subq0.c8, subq0.c7, subq0.c8) AS c17, subq0.c8 AS c18, subq0.c8 AS c19, subq0.c7 AS c20, subq0.c8 AS c21, subq0.c7 AS c22, subq0.c8 AS c23, subq0.c7 AS c24
   FROM (SELECT t1.c4 AS c7, t1.c0 AS c8
      FROM t0 AS t1
      WHERE false
      ORDER BY c7 DESC
      LIMIT 8847097998777524965 ) as subq0
   WHERE true
   ORDER BY c12, c23 ASC, c23 ASC
   LIMIT 7993381303698447318 OFFSET 3819776743753519267) as subq1
WHERE subq1.c9 <> subq1.c21
ORDER BY c28 COLLATE BINARY, c26 COLLATE NOCASE
LIMIT 751185305895327053 OFFSET 9030370310033329133;
SELECT subq0.c7 AS c12, 27 AS c13, 
 CASE WHEN subq0.c10 <> subq0.c11 AND 55 = subq0.c7 AND subq0.c8 >= subq0.c7 THEN like(37,NULL,'񀅂')
      ELSE subq0.c8
 END AS c14
FROM (SELECT t4.c5 AS c7, t4.c1 AS c8, t2.c6 AS c9, t3.c2 AS c10, t4.c6 AS c11
   FROM t0 AS t1
     LEFT JOIN (
     t0 AS t2
      LEFT JOIN (
      t0 AS t3
       LEFT OUTER JOIN t0 AS t4       
        ON (t3.c4 <> t4.c4)      )
       ON (t3.c3 > t3.c3 AND t2.c3 >= t2.c3)     )
      ON (t1.c5 IS NULL AND false)
   WHERE 'text67' < t4.c3
   ORDER BY c11, c7 DESC, c7
   LIMIT 3888967397801250598 OFFSET 1510394422900618475) as subq0
WHERE false
ORDER BY c14 DESC, c12, c12 COLLATE BINARY DESC
LIMIT 7555288326383950501 OFFSET 349165599566047263;
