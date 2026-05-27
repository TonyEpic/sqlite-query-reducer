CREATE TABLE t0 (
    c0 BOOLEAN,
    c1 BOOLEAN,
    c2 INTEGER,
    c3 NULL,
    c4 TEXT
);
UPDATE t0 
SET c0 = t0.c0, c2 = t0.c2, c4 = t0.c4
WHERE t0.c3 = CAST(t0.c2 AS TEXT);
DELETE FROM t0
WHERE t0.c2 < t0.c2;
INSERT INTO t0 VALUES (FALSE, FALSE, 42, NULL, COALESCE(NULL, 1, 'text77'));
INSERT INTO t0 VALUES (CAST(TRUE AS BOOLEAN), FALSE, 19, NULL, 'text55');
SELECT subq0.c5 AS c7
FROM (SELECT 4 AS c5, t2.c2 AS c6
   FROM t0 AS t1
      CROSS JOIN t0 AS t2      
       ON (t1.c1 = t1.c0)
     LEFT OUTER JOIN t0 AS t3     
      ON (t1.c0 = t2.c1)
   WHERE t3.c1 <> t3.c1
   ORDER BY c6, c6 DESC, c6, c6 ASC) as subq0
WHERE COALESCE(subq0.c5, subq0.c5, subq0.c5, subq0.c6, subq0.c6, subq0.c6) <> subq0.c5
ORDER BY c7 ASC, c7 DESC, c7 DESC, c7;
SELECT subq1.c8 AS c9
FROM (SELECT TRUE AS c8
   FROM (SELECT t1.c1 AS c5, t1.c0 AS c6, t1.c0 AS c7
      FROM t0 AS t1
      WHERE t1.c1 = t1.c0
      ORDER BY c5
      LIMIT 5819351589579946652 ) as subq0
   WHERE trim(67,NULL) IS NOT NULL
   ORDER BY c8) as subq1
WHERE subq1.c8 <> 
 CASE subq1.c8 WHEN subq1.c8 = subq1.c8 THEN subq1.c8
      WHEN subq1.c8 = subq1.c8 THEN subq1.c8
      WHEN subq1.c8 = FALSE OR subq1.c8 <> subq1.c8 THEN subq1.c8
      WHEN subq1.c8 = subq1.c8 THEN subq1.c8
      WHEN subq1.c8 <> subq1.c8 THEN subq1.c8
      WHEN subq1.c8 = 
  CASE subq1.c8 WHEN subq1.c8 <> subq1.c8 THEN subq1.c8
       WHEN subq1.c8 IS NOT NULL AND subq1.c8 = subq1.c8 THEN subq1.c8
       WHEN false THEN subq1.c8
       WHEN subq1.c8 = CAST(subq1.c8 AS BOOLEAN) THEN subq1.c8
       WHEN subq1.c8 = subq1.c8 THEN 
   CASE WHEN subq1.c8 <> subq1.c8 THEN 
    CASE WHEN subq1.c8 = subq1.c8 OR true THEN CAST(subq1.c8 AS INTEGER)
         ELSE subq1.c8
    END
        ELSE subq1.c8
   END
       WHEN CAST(max(98,TRUE,NULL) AS TEXT) <> subq1.c8 OR 
   CASE WHEN subq1.c8 IS NOT NULL THEN subq1.c8
        ELSE COALESCE(subq1.c8, subq1.c8)
   END = 
   CASE subq1.c8 WHEN subq1.c8 = subq1.c8 THEN subq1.c8
        WHEN subq1.c8 = subq1.c8 THEN subq1.c8
        ELSE subq1.c8
   END AND subq1.c8 <> subq1.c8 THEN subq1.c8
       ELSE subq1.c8
  END THEN subq1.c8
      ELSE subq1.c8
 END
ORDER BY c9;
SELECT 'text86' AS c6, subq0.c5 AS c7, subq0.c5 AS c8
FROM (SELECT 'text31' AS c5
   FROM t0 AS t1
   WHERE NULL <> 
    CASE WHEN t1.c1 IS NULL THEN t1.c3
         ELSE t1.c3
    END
   ORDER BY c5 COLLATE RTRIM
   LIMIT 3067136083976056605 OFFSET 1944759231573977099) as subq0
WHERE coalesce(NULL,22,TRUE) <> printf('text92',17)
ORDER BY c6, c7 DESC, c7
LIMIT 4397090910022201618 ;
SELECT 
 CASE subq0.c5 WHEN 
  CASE WHEN subq0.c6 < subq0.c6 OR subq0.c5 = subq0.c5 THEN subq0.c6
       ELSE subq0.c6
  END < subq0.c6 THEN subq0.c7
      WHEN subq0.c6 < subq0.c6 OR subq0.c5 <> subq0.c5 THEN subq0.c7
      WHEN subq0.c5 <> subq0.c7 THEN subq0.c7
      WHEN 71 = 19 AND subq0.c6 <> subq0.c6 THEN subq0.c7
      WHEN true THEN subq0.c5
      WHEN subq0.c6 <= 
  CASE subq0.c6 WHEN subq0.c5 = subq0.c7 THEN IFNULL(subq0.c6, subq0.c6)
       WHEN subq0.c5 = subq0.c5 THEN subq0.c6
       WHEN EXISTS (
   SELECT t2.c4 AS c5
    FROM t0 AS t2
    WHERE false AND 'text35' < t2.c4 AND false
    ORDER BY c5 DESC, c5, c5, c5 DESC
    LIMIT 6335367745650020868 OFFSET 5793053272747369672
   ) OR subq0.c7 IS NULL THEN subq0.c6
       WHEN subq0.c7 = 
   CASE WHEN false THEN subq0.c5
        ELSE subq0.c5
   END OR EXISTS (
   SELECT t3.c0 AS c5, t3.c3 AS c6, t3.c3 AS c7, t3.c2 AS c8, t3.c3 AS c9, t3.c4 AS c10, t3.c2 AS c11, t3.c0 AS c12, t3.c3 AS c13
    FROM t0 AS t3
    WHERE t3.c3 IS NULL
    ORDER BY c7 DESC, c7, c8 ASC
   ) AND true THEN subq0.c6
       WHEN true OR subq0.c7 IS NOT NULL THEN 
   CASE WHEN subq0.c5 <> subq0.c5 THEN subq0.c6
        ELSE subq0.c6
   END
       ELSE subq0.c6
  END THEN subq0.c5
      WHEN subq0.c5 <> subq0.c7 THEN subq0.c7
      WHEN subq0.c6 <> 82 OR CAST(subq0.c5 AS INTEGER) <> subq0.c5 AND subq0.c6 IS NOT NULL AND true THEN subq0.c5
      ELSE subq0.c7
 END AS c14, COALESCE(subq0.c6, subq0.c7, subq0.c6) AS c15, subq0.c6 AS c16
FROM (SELECT 
    CASE t1.c0 WHEN t1.c1 <> t1.c0 AND t1.c1 = t1.c1 THEN FALSE
         WHEN t1.c3 <> t1.c3 THEN COALESCE(t1.c1, t1.c4, t1.c4, t1.c0, NULL)
         ELSE t1.c0
    END AS c5, t1.c2 AS c6, t1.c1 AS c7
   FROM t0 AS t1
   WHERE t1.c0 <> t1.c0 OR t1.c1 = t1.c0 AND t1.c0 <> t1.c0 OR t1.c2 < t1.c2 AND t1.c4 <> t1.c4
   ORDER BY c6, c7, c6) as subq0
WHERE 89 = subq0.c6
ORDER BY c14, c14, c15;
SELECT 
 CASE WHEN subq0.c14 < subq0.c6 AND subq0.c18 <> subq0.c18 AND subq0.c9 >= 2 THEN subq0.c11
      ELSE subq0.c13
 END AS c17, subq0.c16 AS c18, subq0.c5 AS c19, subq0.c7 AS c20, subq0.c16 AS c21, subq0.c21 AS c22, subq0.c21 AS c23
FROM (SELECT t1.c0 AS c5, t1.c4 AS c6, t1.c2 AS c7, t1.c1 AS c8, IFNULL(t1.c3, t1.c3) AS c9, t1.c1 AS c10, t1.c0 AS c11, t1.c3 AS c12, t1.c4 AS c13, ltrim( FALSE) AS c14, t1.c4 AS c15, t1.c3 AS c16, NULLIF(t1.c0, t1.c0) AS c17, t1.c1 AS c18, t1.c4 AS c19, t1.c2 AS c20, t1.c2 AS c21, 
    CASE WHEN t1.c0 = t1.c0 THEN t1.c1
         ELSE t1.c0
    END AS c22, 
    CASE t1.c2 WHEN t1.c1 <> t1.c1 THEN t1.c2
         WHEN likelihood(NULL,0.097802) > t1.c2 THEN t1.c2
         WHEN t1.c3 = t1.c3 THEN t1.c2
         WHEN t1.c4 = t1.c4 THEN t1.c2
         WHEN t1.c3 <> t1.c3 THEN t1.c2
         WHEN EXISTS (
     SELECT t2.c2 AS c5, t2.c4 AS c6, t2.c4 AS c7
      FROM t0 AS t2
        LEFT JOIN t0 AS t3        
         ON (t2.c2 = t3.c2)
      WHERE t2.c1 <> t2.c1
      ORDER BY c6 DESC, c6 DESC
      LIMIT 7262358248999388677 
     ) OR 
     CASE WHEN t1.c4 >= t1.c4 AND NULL IS NULL THEN t1.c3
          ELSE NULL
     END = t1.c3 THEN t1.c2
         WHEN EXISTS (
     SELECT t4.c2 AS c5, t4.c1 AS c6, t4.c1 AS c7, t4.c0 AS c8
      FROM t0 AS t4
      WHERE true
      ORDER BY c5, c7
      LIMIT 3084467557702557815 OFFSET 4908473048124723401
     ) THEN t1.c2
         WHEN CAST(t1.c1 AS TEXT) = 'text42' THEN t1.c2
         WHEN t1.c2 > t1.c2 AND t1.c0 IS NULL THEN t1.c2
         ELSE t1.c2
    END AS c9, t1.c3 AS c10, t1.c4 AS c11, t1.c2 AS c12, t1.c1 AS c13, t1.c0 AS c14, t1.c3 AS c15, t1.c4 AS c16
   FROM t0 AS t1
   WHERE t1.c0 <> t1.c0
   ORDER BY c11 DESC
   LIMIT 906032125336520990 ) as subq0
WHERE false AND substr(TRUE,'text68') < ifnull(TRUE,35) AND true
ORDER BY c20 DESC;
SELECT subq1.c8 AS c5, t5.c1 AS c6, FALSE AS c7, t4.c0 AS c8, t4.c4 AS c9, t4.c2 AS c10, 
 CASE WHEN subq0.c5 IS NOT NULL THEN subq1.c8
      ELSE t4.c3
 END AS c11, t4.c3 AS c12
FROM (SELECT t1.c2 AS c5, t1.c0 AS c6
    FROM t0 AS t1
    WHERE t1.c1 = t1.c0 OR t1.c0 <> t1.c0 OR true OR t1.c1 <> t1.c0 OR t1.c3 <> t1.c3 OR COALESCE(t1.c3, t1.c3, t1.c2, t1.c2, t1.c3) <> t1.c2
    ORDER BY c6 COLLATE RTRIM ASC
    LIMIT 1566526972627615022 OFFSET 755997179622966651) as subq0
  INNER JOIN (
  (SELECT t3.c1 AS c5, t3.c1 AS c6, t2.c4 AS c7, t3.c3 AS c8, t2.c3 AS c9, t3.c1 AS c10, t3.c1 AS c11, t2.c0 AS c12, t3.c0 AS c13, t2.c4 AS c14
      FROM t0 AS t2
        INNER JOIN t0 AS t3        
         ON (t3.c3 <> t3.c3)
      WHERE t2.c0 <> t3.c0 OR t2.c4 >= t3.c4 AND t3.c1 = t3.c1 OR t2.c0 <> t2.c0 AND t3.c3 = t2.c3 OR true
      ORDER BY c5, c5) as subq1
    LEFT JOIN t0 AS t4    
     ON (subq1.c14 = t4.c4)
   LEFT JOIN t0 AS t5   
    ON (t4.c1 <> FALSE)  )
   ON (subq1.c5 <> subq1.c12)
WHERE true
ORDER BY c6 COLLATE BINARY
LIMIT 8657018412999196054 ;
SELECT NULLIF(subq1.c7, NULL) AS c9, subq1.c8 AS c10, subq1.c8 AS c11, subq1.c8 AS c12, subq1.c8 AS c13, subq1.c7 AS c14, subq1.c8 AS c15, 
 CASE subq1.c8 WHEN subq1.c7 <> 
  CASE subq1.c7 WHEN subq1.c7 IS NOT NULL THEN subq1.c7
       WHEN true THEN subq1.c8
       WHEN subq1.c7 <> subq1.c7 THEN subq1.c8
       WHEN subq1.c8 IS NULL THEN NULLIF(subq1.c7, subq1.c7)
       WHEN subq1.c8 <> CAST(subq1.c8 AS BOOLEAN) THEN NULL
       WHEN subq1.c7 = subq1.c8 THEN COALESCE(FALSE, subq1.c8, subq1.c8, subq1.c7, subq1.c7)
       WHEN false THEN subq1.c7
       WHEN EXISTS (
   SELECT t4.c3 AS c5
    FROM t0 AS t3
        INNER JOIN t0 AS t4        
         ON (t3.c4 = t3.c4)
       LEFT OUTER JOIN t0 AS t5       
        ON (false)
      INNER JOIN t0 AS t6      
       ON (t6.c3 <> t5.c3)
    WHERE t3.c2 IS NOT NULL
    ORDER BY c5, c5 COLLATE NOCASE, c5 DESC, c5 ASC
   ) OR EXISTS (
   SELECT t7.c1 AS c5
    FROM t0 AS t7
    WHERE 
     CASE WHEN t7.c2 <> t7.c2 THEN t7.c2
          ELSE t7.c0
     END IS NOT NULL
    ORDER BY c5, c5 DESC, c5 COLLATE RTRIM, c5
    LIMIT 9059557833790630487 OFFSET 4225467459659183037
   ) THEN subq1.c8
       WHEN subq1.c7 = subq1.c7 THEN subq1.c8
       WHEN subq1.c7 <> subq1.c8 THEN subq1.c8
       WHEN subq1.c7 IS NULL AND subq1.c7 <> subq1.c7 OR subq1.c7 <> 
   CASE subq1.c8 WHEN subq1.c7 = subq1.c8 OR subq1.c8 = subq1.c8 AND EXISTS (
    SELECT t8.c2 AS c5, t8.c2 AS c6, t8.c0 AS c7
     FROM t0 AS t8
     WHERE t8.c1 <> t8.c1
     ORDER BY c5 ASC, c6 ASC, c6
     LIMIT 6454608871073635653 OFFSET 7182377306629340754
    ) OR subq1.c8 <> subq1.c7 OR subq1.c7 = subq1.c7 AND subq1.c8 <> subq1.c8 AND subq1.c7 = subq1.c7 THEN subq1.c7
        WHEN NULLIF(COALESCE(subq1.c7, subq1.c8, subq1.c7, subq1.c8, subq1.c7), subq1.c7) IS NOT NULL THEN subq1.c7
        WHEN subq1.c7 IS NULL THEN subq1.c8
        ELSE subq1.c7
   END AND CAST(subq1.c8 AS INTEGER) IS NOT NULL AND false OR IFNULL(subq1.c8, subq1.c7) = subq1.c7 THEN subq1.c7
       ELSE subq1.c8
  END THEN 
  CASE subq1.c7 WHEN subq1.c7 = subq1.c8 THEN 
   CASE WHEN false THEN subq1.c8
        ELSE subq1.c7
   END
       WHEN subq1.c7 IS NULL THEN subq1.c8
       WHEN subq1.c7 <> subq1.c8 THEN 
   CASE subq1.c8 WHEN subq1.c7 <> subq1.c7 THEN subq1.c8
        WHEN false AND EXISTS (
    SELECT t9.c3 AS c5, t9.c0 AS c6, t9.c4 AS c7
     FROM t0 AS t9
     WHERE t9.c1 = t9.c0
     ORDER BY c7 ASC, c6 ASC
    ) THEN subq1.c7
        WHEN subq1.c8 <> subq1.c7 THEN subq1.c7
        WHEN 90 IS NULL AND subq1.c7 <> subq1.c8 AND subq1.c8 <> subq1.c8 OR subq1.c8 IS NULL THEN subq1.c8
        ELSE subq1.c7
   END
       WHEN 
   CASE WHEN subq1.c7 <> NULL THEN 
    CASE subq1.c7 WHEN 
     CASE subq1.c7 WHEN subq1.c7 <> subq1.c8 AND subq1.c8 IS NULL THEN subq1.c8
          ELSE subq1.c8
     END = NULLIF(subq1.c8, subq1.c7) THEN subq1.c8
         WHEN subq1.c7 = subq1.c8 THEN subq1.c7
         WHEN subq1.c7 <> NULL OR subq1.c7 = subq1.c8 THEN subq1.c7
         WHEN subq1.c7 IS NULL AND false THEN 
     CASE subq1.c7 WHEN NULLIF(subq1.c7, subq1.c8) = subq1.c8 THEN subq1.c8
          WHEN EXISTS (
      SELECT t10.c1 AS c5, t10.c0 AS c6, t10.c0 AS c7, t10.c3 AS c8, t10.c1 AS c9, t10.c4 AS c10
       FROM t0 AS t10
       WHERE t10.c0 IS NOT NULL
       ORDER BY c6 DESC, c5 ASC
       LIMIT 7638700423510814072 
      ) THEN subq1.c7
          WHEN false THEN subq1.c7
          WHEN NULL = subq1.c7 THEN subq1.c7
          WHEN subq1.c7 = subq1.c7 THEN subq1.c7
          ELSE subq1.c8
     END
         ELSE subq1.c8
    END
        ELSE subq1.c8
   END = subq1.c8 THEN subq1.c7
       WHEN subq1.c8 <> subq1.c7 THEN subq1.c7
       WHEN subq1.c8 <> CAST(subq1.c7 AS INTEGER) THEN subq1.c8
       WHEN NULL = subq1.c7 OR subq1.c8 = subq1.c7 AND round( NULL) IS NULL THEN subq1.c7
       ELSE subq1.c8
  END
      WHEN true OR subq1.c7 <> subq1.c7 THEN subq1.c7
      WHEN subq1.c7 <> subq1.c8 THEN subq1.c8
      WHEN EXISTS (
  SELECT t12.c3 AS c5, t12.c1 AS c6, t12.c4 AS c7, FALSE AS c8, t11.c4 AS c9, t12.c0 AS c10, t11.c3 AS c11, t11.c2 AS c12, t11.c4 AS c13, t11.c1 AS c14, t11.c0 AS c15, t11.c3 AS c16
   FROM t0 AS t11
     INNER JOIN t0 AS t12     
      ON (t11.c1 = t12.c0)
   WHERE t12.c4 <= 'text13' OR EXISTS (
    SELECT t13.c2 AS c5, t14.c0 AS c6, t13.c0 AS c7, t14.c2 AS c8
     FROM t0 AS t13
       LEFT JOIN t0 AS t14       
        ON (t14.c3 <> t14.c3)
     WHERE EXISTS (
      SELECT t15.c4 AS c5, t15.c3 AS c6, t15.c3 AS c7
       FROM t0 AS t15
       WHERE t15.c0 IS NOT NULL
       ORDER BY c6
      )
     ORDER BY c7, c7 COLLATE BINARY ASC
    )
   ORDER BY c12 ASC
   LIMIT 7810820740787587799 OFFSET 502975690396703083
  ) THEN subq1.c7
      WHEN EXISTS (
  SELECT t16.c0 AS c5, t16.c0 AS c6, t16.c1 AS c7, t16.c2 AS c8, t16.c3 AS c9, t16.c3 AS c10, t16.c1 AS c11, t16.c1 AS c12, 
    CASE t16.c2 WHEN t16.c4 = t16.c4 THEN t16.c2
         WHEN t16.c3 <> t16.c3 THEN t16.c2
         WHEN t16.c4 <= t16.c4 THEN t16.c2
         WHEN t16.c2 <> t16.c2 THEN t16.c2
         ELSE t16.c2
    END AS c13, t16.c2 AS c14, t16.c4 AS c15, t16.c2 AS c16, t16.c1 AS c17, t16.c2 AS c18, t16.c2 AS c19, t16.c0 AS c20, t16.c3 AS c21
   FROM t0 AS t16
   WHERE t16.c4 >= 
    CASE WHEN t16.c0 <> t16.c0 THEN 
     CASE t16.c4 WHEN t16.c4 IS NOT NULL THEN t16.c4
          WHEN t16.c0 = t16.c1 THEN t16.c4
          WHEN false THEN t16.c4
          ELSE t16.c4
     END
         ELSE 'text77'
    END
   ORDER BY c21, c8 DESC, c17
   LIMIT 836937630898007888 OFFSET 2355400803137596060
  ) THEN subq1.c8
      WHEN subq1.c8 <> subq1.c7 OR subq1.c8 = subq1.c7 THEN subq1.c7
      ELSE subq1.c7
 END AS c22, subq1.c7 AS c23, subq1.c8 AS c24, subq1.c8 AS c25, subq1.c7 AS c26
FROM (SELECT subq0.c5 AS c7, subq0.c6 AS c8
   FROM (SELECT t1.c3 AS c5, t1.c3 AS c6
      FROM t0 AS t1
        LEFT OUTER JOIN t0 AS t2        
         ON (t1.c2 IS NOT NULL)
      WHERE t2.c0 <> t2.c1
      ORDER BY c6 COLLATE RTRIM ASC, c6) as subq0
   WHERE subq0.c5 = 
    CASE subq0.c5 WHEN true THEN subq0.c5
         WHEN subq0.c6 <> subq0.c6 THEN subq0.c6
         WHEN subq0.c6 = NULL THEN subq0.c6
         ELSE subq0.c6
    END AND subq0.c6 = subq0.c5
   ORDER BY c7 DESC, c7, c7 DESC, c8
   LIMIT 1970206224801196390 OFFSET 3515894589746295571) as subq1
WHERE CAST(subq1.c7 AS TEXT) IS NULL
ORDER BY c11 DESC
LIMIT 5187270018120034418 ;
SELECT subq0.c6 AS c9, subq0.c8 AS c10, 
 CASE subq0.c7 WHEN false OR 
  CASE WHEN subq0.c7 <> subq0.c8 THEN 
   CASE WHEN subq0.c7 = subq0.c6 THEN subq0.c5
        ELSE subq0.c8
   END
       ELSE subq0.c5
  END IS NULL AND subq0.c6 <> subq0.c8 AND subq0.c5 < subq0.c5 THEN FALSE
      WHEN subq0.c5 <> 55 THEN subq0.c8
      WHEN 
  CASE WHEN NULLIF(subq0.c7, like('text34',FALSE)) IS NOT NULL THEN subq0.c6
       ELSE subq0.c8
  END = subq0.c8 AND subq0.c8 = subq0.c6 THEN subq0.c6
      WHEN subq0.c7 <> subq0.c6 THEN subq0.c7
      WHEN 
  CASE WHEN EXISTS (
   SELECT t4.c1 AS c5, t4.c4 AS c6, 
     CASE t4.c1 WHEN TRUE = t4.c0 THEN t4.c1
          WHEN TRUE <> t4.c1 THEN t4.c1
          WHEN t4.c3 <> t4.c3 THEN t4.c1
          ELSE t4.c1
     END AS c7, t4.c1 AS c8, t4.c1 AS c9
    FROM t0 AS t4
    WHERE t4.c0 <> t4.c0
    ORDER BY c5 DESC
    LIMIT 1280513665834716451 OFFSET 581408224666032018
   ) OR subq0.c8 = subq0.c8 AND subq0.c7 <> subq0.c8 AND subq0.c7 <> subq0.c8 THEN subq0.c6
       ELSE subq0.c8
  END <> subq0.c8 THEN subq0.c8
      WHEN EXISTS (
  SELECT t5.c3 AS c5, t5.c3 AS c6, t5.c0 AS c7, NULLIF(t5.c2, t5.c2) AS c8, t5.c4 AS c9, t5.c3 AS c10, t5.c0 AS c11, t5.c2 AS c12, t5.c4 AS c13, t5.c1 AS c14
   FROM t0 AS t5
   WHERE t5.c0 <> 
    CASE t5.c1 WHEN t5.c1 = t5.c0 THEN t5.c1
         WHEN t5.c2 <> t5.c2 THEN t5.c0
         WHEN t5.c0 = t5.c0 THEN t5.c0
         WHEN t5.c2 >= t5.c2 THEN t5.c0
         WHEN true THEN 
     CASE WHEN t5.c0 = CAST(t5.c1 AS INTEGER) THEN t5.c0
          ELSE t5.c0
     END
         WHEN t5.c1 <> t5.c1 OR t5.c3 <> t5.c3 AND true THEN t5.c1
         WHEN rtrim('text23',33) IS NOT NULL OR true THEN t5.c0
         ELSE t5.c1
    END
   ORDER BY c7, c6 ASC
   LIMIT 3906188417417659812 OFFSET 3986198644048307224
  ) THEN subq0.c7
      WHEN CAST(subq0.c8 AS BOOLEAN) IS NULL THEN subq0.c6
      WHEN COALESCE(subq0.c6, CAST(subq0.c5 AS TEXT), subq0.c7, subq0.c8, CAST(glob(5,NULL) AS TEXT), round('text72',TRUE)) <> subq0.c8 THEN subq0.c8
      WHEN subq0.c8 IS NULL AND subq0.c7 = CAST(subq0.c7 AS BOOLEAN) AND subq0.c6 <> TRUE THEN subq0.c7
      WHEN subq0.c7 <> subq0.c7 THEN subq0.c6
      WHEN subq0.c5 > subq0.c5 THEN subq0.c8
      WHEN subq0.c6 <> subq0.c8 OR subq0.c5 >= subq0.c5 THEN subq0.c8
      ELSE subq0.c6
 END AS c15, subq0.c8 AS c16, 
 CASE WHEN EXISTS (
  SELECT 
    CASE WHEN t8.c1 IS NULL AND t8.c2 > t9.c2 THEN t9.c4
         ELSE t7.c4
    END AS c29, t8.c3 AS c30, t6.c0 AS c31, t8.c3 AS c32, t7.c0 AS c33, t9.c2 AS c34, t6.c3 AS c35, t7.c3 AS c36, t9.c4 AS c37, t9.c3 AS c38, t7.c0 AS c39, t9.c2 AS c40, t9.c3 AS c41, t6.c0 AS c42, t7.c3 AS c43, t9.c1 AS c44, t8.c0 AS c45, t7.c1 AS c46
   FROM t0 AS t6
     LEFT OUTER JOIN (
     t0 AS t7
      INNER JOIN (
      t0 AS t8
       CROSS JOIN t0 AS t9       
        ON (t9.c3 = t8.c3)      )
       ON (t8.c0 = t8.c1 OR EXISTS (
        SELECT t10.c1 AS c5, t10.c3 AS c6, t10.c3 AS c7
         FROM t0 AS t10
         WHERE true
         ORDER BY c7 ASC, c7, c6 DESC
        ))     )
      ON (t7.c1 = t7.c0 OR EXISTS (
       SELECT ALL t11.c0 AS c5, t11.c4 AS c6, t11.c2 AS c7, t11.c3 AS c8, t11.c0 AS c9, t11.c2 AS c10, t11.c3 AS c11, t11.c0 AS c12, t11.c2 AS c13, t11.c4 AS c14, t11.c0 AS c15, t11.c1 AS c16, t11.c1 AS c17, t11.c4 AS c18, t11.c3 AS c19, t11.c4 AS c20, t11.c0 AS c21, t11.c1 AS c22, t11.c3 AS c23, t11.c3 AS c24, t11.c3 AS c25, t11.c4 AS c26, t11.c0 AS c27, t11.c4 AS c28
        FROM t0 AS t11
        WHERE t11.c0 <> t11.c1 AND t11.c3 <> t11.c3
        ORDER BY c13, c21 COLLATE BINARY DESC, c13 DESC
        LIMIT 4666398613485326882 
       ))
   WHERE like(FALSE,NULL) IS NULL OR t8.c0 = FALSE
   ORDER BY c40, c46, c30 COLLATE NOCASE ASC
   LIMIT 2892024916826749180 OFFSET 2346044335106521994
  ) AND EXISTS (
  SELECT t12.c3 AS c5, t12.c0 AS c6
   FROM t0 AS t12
     INNER JOIN (
     t0 AS t13
      INNER JOIN t0 AS t14      
       ON (t13.c4 IS NOT NULL)     )
      ON (t13.c2 <> t12.c2)
   WHERE t12.c4 IS NULL AND t14.c1 IS NOT NULL
   ORDER BY c6
   LIMIT 1577224672905552195 OFFSET 3800345213815333165
  ) THEN subq0.c8
      ELSE subq0.c6
 END AS c7, subq0.c5 AS c8, subq0.c8 AS c9, subq0.c6 AS c10, subq0.c7 AS c11, subq0.c8 AS c12, 
 CASE WHEN subq0.c6 IS NULL THEN NULLIF(subq0.c6, subq0.c6)
      ELSE subq0.c7
 END AS c13, 
 CASE WHEN CAST(subq0.c6 AS INTEGER) = CAST(subq0.c5 AS INTEGER) THEN subq0.c5
      ELSE subq0.c5
 END AS c14, subq0.c6 AS c15, subq0.c6 AS c16, subq0.c8 AS c17, subq0.c6 AS c18, subq0.c8 AS c19, subq0.c8 AS c20, subq0.c7 AS c21
FROM (SELECT t3.c2 AS c5, t3.c0 AS c6, t3.c0 AS c7, t2.c0 AS c8
   FROM t0 AS t1
      LEFT OUTER JOIN t0 AS t2      
       ON (t1.c1 = t2.c0)
     LEFT JOIN t0 AS t3     
      ON (true)
   WHERE t2.c1 = t3.c1
   ORDER BY c7, c8 COLLATE RTRIM ASC, c6
   LIMIT 8442260309220876271 OFFSET 3822454569420395662) as subq0
WHERE EXISTS (
 SELECT t16.c4 AS c5, t16.c0 AS c6, t17.c3 AS c7, t16.c0 AS c8, t16.c1 AS c9, t15.c0 AS c10, t16.c1 AS c11, t16.c3 AS c12, t15.c1 AS c13, t17.c3 AS c14
  FROM t0 AS t15
    INNER JOIN (
    t0 AS t16
     INNER JOIN t0 AS t17     
      ON (t16.c2 = t17.c2)    )
     ON (TRUE <> t15.c1 OR t16.c1 = t16.c1 OR t16.c3 = t16.c3)
  WHERE EXISTS (
   SELECT t18.c4 AS c5, t18.c3 AS c6, t18.c3 AS c7, t18.c2 AS c8, t18.c2 AS c9, t18.c1 AS c10, t18.c3 AS c11, 4 AS c12, t18.c3 AS c13, t18.c0 AS c14, t18.c4 AS c15, t18.c3 AS c16, t18.c3 AS c17, t18.c2 AS c18
    FROM t0 AS t18
    WHERE t18.c0 = 
     CASE WHEN false THEN t18.c0
          ELSE t18.c0
     END
    ORDER BY c15 DESC, c6
   )
  ORDER BY c8 DESC
 ) AND subq0.c5 IS NULL AND subq0.c6 IS NOT NULL
ORDER BY c16 DESC;
SELECT subq1.c6 AS c9, subq1.c6 AS c10
FROM (SELECT TRUE AS c5, t1.c3 AS c6, t1.c4 AS c7, t1.c3 AS c8, t1.c0 AS c9, t1.c1 AS c10, t1.c1 AS c11, COALESCE(t1.c3, t1.c2, t1.c4) AS c12
    FROM t0 AS t1
    WHERE false
    ORDER BY c8 DESC, c6 COLLATE RTRIM, c12 ASC
    LIMIT 615260677817988053 OFFSET 1601989916828623125) as subq0
  LEFT JOIN (SELECT t2.c2 AS c5, t2.c2 AS c6, t2.c4 AS c7, 47 AS c8
    FROM t0 AS t2
    WHERE t2.c4 > t2.c4
    ORDER BY c8
    LIMIT 3545703657940571200 OFFSET 4703971103111178082) as subq1  
   ON (subq0.c12 = subq1.c7)
WHERE subq1.c6 IS NULL
ORDER BY c10, c10, c10, c10;
SELECT subq0.c9 AS c13, subq0.c7 AS c14, 14 AS c15
FROM (SELECT t1.c3 AS c5, 
    CASE t1.c4 WHEN t1.c0 <> t1.c0 THEN t1.c4
         WHEN false OR t1.c4 <> t1.c4 AND t1.c2 >= t1.c2 THEN 
     CASE t1.c4 WHEN t1.c2 <= t1.c2 THEN trim( NULL)
          WHEN t1.c4 <> t1.c4 THEN t1.c4
          WHEN t1.c2 IS NULL THEN t1.c4
          WHEN t1.c1 <> t1.c1 THEN t1.c4
          WHEN t1.c3 = t1.c3 THEN t1.c4
          WHEN t1.c1 IS NULL THEN t1.c4
          WHEN t1.c4 IS NOT NULL THEN t1.c4
          WHEN 'text17' >= 'text32' OR t1.c4 IS NOT NULL THEN t1.c4
          WHEN true THEN t1.c4
          WHEN t1.c4 >= t1.c4 THEN t1.c4
          WHEN t1.c2 > t1.c2 THEN t1.c4
          WHEN t1.c1 <> t1.c0 THEN t1.c4
          ELSE t1.c4
     END
         ELSE t1.c4
    END AS c6, t1.c2 AS c7, t1.c1 AS c8, t1.c1 AS c9, t1.c2 AS c10, 
    CASE WHEN t1.c0 = t1.c0 AND t1.c3 IS NOT NULL AND t1.c1 = 
     CASE WHEN t1.c2 <> t1.c2 THEN t1.c0
          ELSE t1.c0
     END AND t1.c1 <> t1.c1 OR t1.c2 = t1.c2 THEN 96
         ELSE t1.c2
    END AS c11, t1.c3 AS c12
   FROM t0 AS t1
   WHERE t1.c0 <> TRUE AND t1.c1 <> t1.c0
   ORDER BY c7 ASC, c11
   LIMIT 4224862539711498118 OFFSET 706990438318866717) as subq0
WHERE subq0.c7 <= subq0.c10
ORDER BY c14 COLLATE NOCASE;
SELECT t1.c4 AS c13, subq0.c7 AS c14, subq0.c8 AS c15, 
 CASE subq0.c9 WHEN true THEN 
  CASE subq0.c9 WHEN CAST(subq0.c12 AS INTEGER) >= subq0.c8 THEN COALESCE(CAST(t1.c0 AS BOOLEAN), subq0.c10, subq0.c10, t1.c0, CAST(t1.c3 AS BOOLEAN), COALESCE(subq0.c6, subq0.c10, subq0.c7, t1.c4))
       WHEN 'text1' >= subq0.c12 THEN t1.c0
       ELSE subq0.c9
  END
      WHEN t1.c1 = CAST(
   CASE t1.c4 WHEN true THEN t1.c3
        WHEN EXISTS (
    SELECT t3.c4 AS c5, t3.c1 AS c6, t3.c3 AS c7, t3.c2 AS c8, t3.c1 AS c9, NULL AS c10, t3.c4 AS c11, t3.c2 AS c12, t3.c2 AS c13, t3.c1 AS c14, t3.c3 AS c15, t3.c1 AS c16, t3.c0 AS c17, t3.c1 AS c18, t3.c2 AS c19, t3.c4 AS c20, t3.c0 AS c21, t3.c2 AS c22, t3.c4 AS c23, t3.c2 AS c24, t3.c1 AS c25, t3.c3 AS c26, t3.c1 AS c27, t3.c3 AS c28, t3.c0 AS c29, t3.c2 AS c30, t3.c0 AS c31, t3.c4 AS c32, t3.c4 AS c33, t3.c3 AS c34, t3.c0 AS c35
     FROM t0 AS t3
     WHERE t3.c0 <> t3.c0
     ORDER BY c26 DESC, c24, c12 ASC
     LIMIT 2319926796771360384 OFFSET 6619333888372339652
    ) THEN t1.c4
        WHEN true THEN 
    CASE subq0.c8 WHEN t1.c1 <> t1.c0 THEN CAST(t1.c4 AS TEXT)
         WHEN subq0.c12 <> quote( FALSE) OR t1.c0 <> 
     CASE t1.c1 WHEN t1.c2 >= t1.c2 THEN subq0.c9
          WHEN subq0.c6 IS NULL AND EXISTS (
      SELECT t4.c0 AS c5, t4.c0 AS c6, t4.c1 AS c7, t4.c0 AS c8, t4.c4 AS c9, t4.c0 AS c10, t4.c0 AS c11, t4.c4 AS c12, t4.c2 AS c13, t4.c4 AS c14, t4.c2 AS c15
       FROM t0 AS t4
       WHERE EXISTS (
        SELECT t5.c4 AS c5, t5.c3 AS c6
         FROM t0 AS t5
         WHERE t5.c4 < t5.c4 OR t5.c0 = t5.c0 OR false OR EXISTS (
          SELECT t6.c1 AS c5, t6.c1 AS c6, t6.c2 AS c7, t6.c4 AS c8, t6.c3 AS c9, t6.c1 AS c10, t6.c4 AS c11, t6.c4 AS c12
           FROM t0 AS t6
           WHERE true OR t6.c0 = t6.c0 AND t6.c0 = t6.c1 OR true
           ORDER BY c6 ASC, c9
           LIMIT 8766303434812490939 OFFSET 5637949270729467639
          ) OR t5.c2 IS NULL OR t5.c4 = t5.c4 OR t5.c1 = t5.c1 AND false AND false
         ORDER BY c6 COLLATE BINARY
         LIMIT 5741641231662685564 
        )
       ORDER BY c15, c14, c14 COLLATE NOCASE
       LIMIT 1712036829125270811 OFFSET 9082995118469034135
      ) THEN subq0.c9
          WHEN subq0.c7 <> t1.c1 AND t1.c2 = t1.c2 THEN 
      CASE WHEN subq0.c12 <= subq0.c12 OR false AND t1.c2 = 90 AND subq0.c12 <> subq0.c5 THEN subq0.c9
           ELSE subq0.c7
      END
          WHEN subq0.c5 >= t1.c4 THEN subq0.c11
          WHEN t1.c4 > subq0.c12 THEN subq0.c11
          WHEN subq0.c9 = t1.c0 THEN t1.c0
          WHEN subq0.c7 = t1.c1 OR subq0.c5 >= subq0.c5 THEN subq0.c9
          WHEN false THEN subq0.c9
          WHEN t1.c4 IS NOT NULL THEN FALSE
          WHEN subq0.c10 <> subq0.c6 THEN t1.c0
          WHEN subq0.c12 = subq0.c5 OR t1.c4 <= subq0.c5 THEN subq0.c9
          WHEN subq0.c10 = subq0.c10 THEN subq0.c11
          ELSE subq0.c9
     END OR t1.c3 = subq0.c10 THEN subq0.c6
         WHEN t1.c0 = subq0.c7 THEN subq0.c7
         WHEN 
     CASE t1.c0 WHEN t1.c1 <> subq0.c7 OR subq0.c10 = subq0.c10 OR t1.c4 <= t1.c4 THEN t1.c0
          WHEN t1.c2 > 
      CASE WHEN EXISTS (
       SELECT t7.c4 AS c5, t7.c4 AS c6, t7.c2 AS c7, t7.c1 AS c8, t7.c4 AS c9, t7.c3 AS c10, t7.c0 AS c11, t7.c1 AS c12, t7.c4 AS c13, t7.c1 AS c14
        FROM t0 AS t7
        WHERE true
        ORDER BY c13 DESC
        LIMIT 5901509416344928709 OFFSET 2841322519145693365
       ) THEN subq0.c8
           ELSE t1.c2
      END THEN t1.c1
          WHEN subq0.c12 >= subq0.c5 THEN FALSE
          WHEN subq0.c11 IS NULL THEN t1.c3
          WHEN subq0.c5 = subq0.c5 THEN t1.c0
          WHEN subq0.c9 IS NOT NULL THEN t1.c4
          WHEN EXISTS (
      SELECT t8.c4 AS c5, t8.c2 AS c6, t8.c0 AS c7, t8.c4 AS c8
       FROM t0 AS t8
       WHERE t8.c2 <> t8.c2
       ORDER BY c5 COLLATE NOCASE, c8 ASC
       LIMIT 2556080620514318430 OFFSET 4004631886671157425
      ) OR subq0.c12 <> subq0.c5 THEN subq0.c6
          WHEN t1.c0 IS NULL THEN subq0.c7
          WHEN t1.c3 <> COALESCE(subq0.c12, subq0.c10) THEN t1.c4
          WHEN subq0.c11 = subq0.c7 THEN t1.c1
          ELSE t1.c4
     END IS NULL THEN NULL
         WHEN t1.c4 = subq0.c12 OR subq0.c12 > subq0.c5 THEN t1.c3
         WHEN t1.c3 <> t1.c3 THEN subq0.c7
         WHEN subq0.c6 <> subq0.c6 AND subq0.c8 < t1.c2 OR t1.c4 IS NULL AND replace(TRUE,'text51','text3') = 'text48' THEN subq0.c6
         WHEN subq0.c12 > subq0.c12 THEN COALESCE(subq0.c11, subq0.c6, subq0.c10, t1.c3)
         WHEN t1.c1 = subq0.c9 THEN subq0.c11
         WHEN subq0.c5 > subq0.c12 THEN subq0.c11
         WHEN EXISTS (
     SELECT t9.c2 AS c5, t9.c3 AS c6, t9.c3 AS c7, t9.c3 AS c8, t9.c1 AS c9, t9.c3 AS c10, t9.c4 AS c11, t9.c1 AS c12, t9.c0 AS c13
      FROM t0 AS t9
      WHERE true
      ORDER BY c8 DESC
      LIMIT 1465690027721391080 OFFSET 502863557319350429
     ) THEN CAST(t1.c3 AS BOOLEAN)
         ELSE subq0.c5
    END
        WHEN subq0.c11 IS NOT NULL THEN CAST(FALSE AS BOOLEAN)
        WHEN 
    CASE WHEN subq0.c9 <> subq0.c11 THEN subq0.c5
         ELSE subq0.c5
    END <> subq0.c12 THEN 
    CASE WHEN subq0.c5 IS NOT NULL THEN subq0.c5
         ELSE 
     CASE WHEN t1.c3 = t1.c3 THEN subq0.c11
          ELSE t1.c4
     END
    END
        WHEN false AND t1.c2 <= 
    CASE t1.c2 WHEN subq0.c8 <> subq0.c8 OR t1.c0 <> subq0.c9 THEN subq0.c8
         WHEN true THEN subq0.c8
         WHEN 
     CASE t1.c3 WHEN subq0.c6 <> t1.c3 THEN subq0.c6
          WHEN subq0.c9 <> t1.c0 AND EXISTS (
      SELECT t10.c2 AS c5, t10.c3 AS c6, t10.c3 AS c7, t10.c1 AS c8, t10.c4 AS c9
       FROM t0 AS t10
       WHERE EXISTS (
        SELECT t11.c2 AS c5
         FROM t0 AS t11
         WHERE false
         ORDER BY c5, c5 COLLATE RTRIM, c5, c5 DESC
         LIMIT 4830704431498383004 OFFSET 244777622436379260
        ) OR t10.c3 <> t10.c3 OR t10.c4 = t10.c4
       ORDER BY c8 DESC, c7 ASC
       LIMIT 6561156522222612537 
      ) THEN subq0.c10
          WHEN EXISTS (
      SELECT t12.c3 AS c5, t12.c3 AS c6, 'text87' AS c7, t12.c0 AS c8, t12.c3 AS c9, t12.c1 AS c10, t12.c3 AS c11, t12.c0 AS c12, t12.c0 AS c13, t12.c4 AS c14, t12.c4 AS c15, t12.c4 AS c16, t12.c1 AS c17, t12.c2 AS c18, t12.c1 AS c19, t12.c3 AS c20
       FROM t0 AS t12
       WHERE false
       ORDER BY c5, c10 ASC, c5
       LIMIT 2233805338485943391 OFFSET 1606907566598092874
      ) THEN subq0.c10
          WHEN subq0.c8 <> subq0.c8 THEN 
      CASE subq0.c10 WHEN true THEN t1.c3
           WHEN t1.c3 <> subq0.c10 THEN t1.c3
           WHEN subq0.c8 <= subq0.c8 AND subq0.c12 >= subq0.c12 OR EXISTS (
       SELECT t13.c1 AS c5
        FROM t0 AS t13
        WHERE EXISTS (
         SELECT t14.c4 AS c5, t14.c2 AS c6, t14.c3 AS c7, t14.c0 AS c8
          FROM t0 AS t14
          WHERE true
          ORDER BY c5
          LIMIT 2825843445980595664 
         )
        ORDER BY c5 ASC, c5 DESC, c5 COLLATE BINARY, c5 ASC
        LIMIT 7238696757004295286 
       ) THEN subq0.c10
           WHEN true THEN subq0.c6
           WHEN subq0.c6 <> subq0.c6 OR subq0.c11 = subq0.c7 THEN subq0.c6
           WHEN subq0.c9 <> t1.c0 THEN subq0.c10
           WHEN t1.c0 <> t1.c1 THEN subq0.c6
           ELSE NULL
      END
          WHEN subq0.c11 <> subq0.c11 AND false THEN subq0.c10
          WHEN subq0.c8 >= t1.c2 THEN t1.c3
          WHEN t1.c4 IS NULL AND subq0.c11 <> t1.c0 THEN subq0.c10
          ELSE subq0.c10
     END <> t1.c3 THEN t1.c2
         WHEN subq0.c10 = subq0.c6 THEN subq0.c8
         WHEN subq0.c7 <> subq0.c7 THEN subq0.c8
         WHEN t1.c2 >= IFNULL(subq0.c8, subq0.c8) THEN t1.c2
         WHEN subq0.c11 IS NULL THEN subq0.c8
         WHEN subq0.c6 <> t1.c3 OR subq0.c10 = subq0.c10 THEN t1.c2
         WHEN subq0.c7 IS NULL THEN subq0.c8
         WHEN t1.c4 <= subq0.c5 THEN subq0.c8
         WHEN t1.c0 = subq0.c11 THEN subq0.c8
         WHEN subq0.c9 <> 
     CASE subq0.c9 WHEN EXISTS (
      SELECT t15.c0 AS c5
       FROM t0 AS t15
       WHERE t15.c2 >= t15.c2 AND true
       ORDER BY c5 ASC, c5 DESC, c5 ASC, c5
       LIMIT 3530287226320805055 OFFSET 2734557130672701099
      ) THEN subq0.c11
          WHEN subq0.c7 <> t1.c1 THEN CAST(subq0.c5 AS TEXT)
          WHEN subq0.c6 = subq0.c6 THEN subq0.c7
          WHEN t1.c2 IS NOT NULL THEN subq0.c11
          WHEN subq0.c6 <> subq0.c6 THEN subq0.c9
          WHEN true THEN subq0.c7
          WHEN t1.c3 = t1.c3 THEN subq0.c11
          WHEN t1.c0 = subq0.c9 THEN subq0.c9
          WHEN subq0.c12 > subq0.c5 AND 
      CASE WHEN t1.c1 = TRUE THEN subq0.c5
           ELSE subq0.c12
      END < subq0.c5 THEN subq0.c9
          ELSE TRUE
     END THEN subq0.c8
         ELSE subq0.c8
    END THEN subq0.c10
        WHEN 'text96' < 'text66' THEN t1.c4
        WHEN true THEN t1.c3
        WHEN t1.c0 = 
    CASE subq0.c9 WHEN EXISTS (
     SELECT t16.c2 AS c5, t16.c1 AS c6, t16.c0 AS c7, t16.c0 AS c8
      FROM t0 AS t16
      WHERE true
      ORDER BY c6, c5
      LIMIT 6994576167024800395 OFFSET 6751711955269114393
     ) THEN subq0.c9
         WHEN t1.c0 <> t1.c1 THEN subq0.c7
         WHEN 
     CASE t1.c4 WHEN t1.c1 IS NULL OR EXISTS (
      SELECT t17.c4 AS c5, t17.c2 AS c6
       FROM t0 AS t17
       WHERE t17.c4 < t17.c4 OR t17.c1 = t17.c0
       ORDER BY c6 ASC, c6, c5, c5 ASC
       LIMIT 1610746162451414741 
      ) THEN subq0.c12
          WHEN TRUE = t1.c1 AND COALESCE(NULL, t1.c4, t1.c3) <= t1.c2 THEN subq0.c7
          WHEN subq0.c7 = subq0.c9 THEN t1.c4
          WHEN subq0.c11 = subq0.c9 THEN subq0.c9
          WHEN EXISTS (
      SELECT t19.c3 AS c5, t18.c0 AS c6, t18.c3 AS c7, t19.c1 AS c8, t19.c4 AS c9, t18.c4 AS c10, t19.c1 AS c11, t18.c1 AS c12, t19.c1 AS c13
       FROM t0 AS t18
         INNER JOIN t0 AS t19         
          ON (t18.c1 = TRUE)
       WHERE t19.c0 IS NULL
       ORDER BY c8 ASC, c6, c11 DESC
       LIMIT 696042639756585777 OFFSET 2019388691672998891
      ) THEN t1.c3
          WHEN subq0.c9 <> subq0.c9 THEN t1.c2
          WHEN t1.c0 = subq0.c11 THEN t1.c3
          WHEN false OR subq0.c5 IS NOT NULL THEN subq0.c6
          WHEN false THEN subq0.c9
          WHEN t1.c1 IS NOT NULL THEN t1.c4
          WHEN subq0.c10 <> subq0.c6 THEN subq0.c10
          WHEN subq0.c10 IS NOT NULL OR true OR t1.c0 IS NULL THEN subq0.c5
          ELSE t1.c4
     END IS NULL THEN t1.c1
         WHEN t1.c3 = NULL THEN subq0.c11
         WHEN t1.c2 IS NULL THEN subq0.c7
         WHEN t1.c4 = subq0.c12 OR subq0.c5 > subq0.c5 OR subq0.c12 <> 
     CASE subq0.c5 WHEN t1.c2 < t1.c2 THEN 'text99'
          WHEN false THEN subq0.c5
          WHEN subq0.c11 = subq0.c7 THEN subq0.c5
          ELSE subq0.c5
     END OR EXISTS (
     SELECT TRUE AS c5, t20.c4 AS c6, t20.c4 AS c7
      FROM t0 AS t20
      WHERE true
      ORDER BY c6 DESC, c7, c6
      LIMIT 2528256608990235843 OFFSET 6975707006201508687
     ) THEN FALSE
         WHEN t1.c3 = subq0.c6 THEN subq0.c11
         WHEN 
     CASE WHEN 
      CASE WHEN subq0.c12 <> subq0.c12 AND subq0.c5 >= t1.c4 THEN subq0.c11
           ELSE t1.c0
      END <> t1.c0 THEN subq0.c9
          ELSE subq0.c9
     END = subq0.c7 THEN subq0.c9
         WHEN EXISTS (
     SELECT t21.c4 AS c5, t21.c4 AS c6, t21.c2 AS c7, t21.c4 AS c8, t21.c2 AS c9, t21.c1 AS c10, t21.c0 AS c11, t21.c0 AS c12, TRUE AS c13, t21.c2 AS c14, t21.c4 AS c15
      FROM t0 AS t21
      WHERE t21.c2 < t21.c2
      ORDER BY c10 ASC, c15 ASC, c14 DESC
     ) THEN subq0.c9
         WHEN subq0.c5 > t1.c4 THEN subq0.c7
         ELSE subq0.c9
    END THEN subq0.c6
        WHEN EXISTS (
    SELECT t22.c2 AS c5, t22.c0 AS c6, t22.c0 AS c7, t22.c4 AS c8, t22.c2 AS c9, t22.c4 AS c10, t22.c2 AS c11, t22.c0 AS c12, t22.c4 AS c13, t22.c0 AS c14, t22.c1 AS c15, t22.c1 AS c16, t22.c1 AS c17, 
      CASE WHEN t22.c4 < t22.c4 THEN t22.c3
           ELSE t22.c3
      END AS c18, t22.c3 AS c19
     FROM t0 AS t22
     WHERE EXISTS (
      SELECT t23.c2 AS c5, t23.c3 AS c6, t23.c1 AS c7, t23.c3 AS c8, t23.c2 AS c9, t23.c2 AS c10, t23.c4 AS c11, t23.c4 AS c12, t23.c0 AS c13
       FROM t0 AS t23
       WHERE true AND EXISTS (
        SELECT t24.c1 AS c5, t24.c0 AS c6, NULL AS c7, t24.c1 AS c8
         FROM t0 AS t24
         WHERE t24.c0 IS NOT NULL
         ORDER BY c5, c6 COLLATE RTRIM ASC, c5
         LIMIT 6976551445593382551 OFFSET 3513391168980268801
        ) AND t23.c3 IS NOT NULL
       ORDER BY c10 ASC, c8 DESC
       LIMIT 386365999215345544 
      )
     ORDER BY c8 ASC
     LIMIT 2323264080173256328 
    ) OR NULL <> t1.c3 THEN t1.c3
        ELSE subq0.c7
   END AS TEXT) THEN t1.c1
      WHEN EXISTS (
  SELECT NULL AS c5, 
    CASE WHEN COALESCE(t26.c3, t26.c3, t26.c4, t25.c2, t25.c3, t26.c4) < ifnull(TRUE,100) THEN CAST(t25.c2 AS BOOLEAN)
         ELSE t26.c0
    END AS c6, t25.c0 AS c7, t26.c0 AS c8, t26.c2 AS c9, t26.c2 AS c10, t25.c4 AS c11, t26.c3 AS c12, t25.c4 AS c13, t25.c1 AS c14, t26.c0 AS c15, t26.c0 AS c16, t25.c2 AS c17, t26.c0 AS c18
   FROM t0 AS t25
     INNER JOIN t0 AS t26     
      ON (t26.c3 = t26.c3)
   WHERE t25.c4 > t26.c4
   ORDER BY c15 ASC, c16, c17 DESC
   LIMIT 3287878660373641095 
  ) THEN 
  CASE t1.c1 WHEN false THEN subq0.c11
       WHEN subq0.c5 <= subq0.c5 THEN subq0.c7
       WHEN subq0.c6 IS NULL THEN subq0.c7
       WHEN t1.c3 = 
   CASE WHEN subq0.c7 = subq0.c7 OR subq0.c10 IS NULL THEN subq0.c6
        ELSE t1.c3
   END OR subq0.c12 <> t1.c4 THEN subq0.c9
       WHEN t1.c0 IS NOT NULL THEN t1.c0
       ELSE subq0.c7
  END
      WHEN subq0.c10 = t1.c3 THEN t1.c0
      WHEN subq0.c8 <> t1.c2 THEN subq0.c9
      ELSE 
  CASE WHEN false THEN t1.c0
       ELSE t1.c1
  END
 END AS c19, t1.c3 AS c20, t1.c4 AS c21, subq0.c5 AS c22
FROM t0 AS t1
  INNER JOIN (SELECT t2.c4 AS c5, t2.c3 AS c6, t2.c1 AS c7, 81 AS c8, t2.c1 AS c9, t2.c3 AS c10, TRUE AS c11, t2.c4 AS c12
    FROM t0 AS t2
    WHERE t2.c4 >= t2.c4
    ORDER BY c7 DESC, c12, c12
    LIMIT 2161086417330148131 ) as subq0  
   ON (subq0.c9 <> subq0.c7)
WHERE 
 CASE subq0.c9 WHEN subq0.c8 < subq0.c8 THEN t1.c0
      WHEN t1.c3 <> subq0.c6 OR subq0.c9 <> subq0.c11 THEN subq0.c11
      WHEN false AND subq0.c6 <> subq0.c10 AND CAST(CAST(t1.c4 AS BOOLEAN) AS TEXT) IS NOT NULL OR subq0.c5 >= subq0.c5 THEN CAST(COALESCE(subq0.c9, t1.c3, CAST(subq0.c6 AS BOOLEAN)) AS INTEGER)
      WHEN subq0.c5 <> subq0.c12 THEN TRUE
      WHEN t1.c3 IS NULL THEN t1.c1
      WHEN subq0.c6 = subq0.c10 THEN CAST(subq0.c6 AS INTEGER)
      WHEN subq0.c8 <> subq0.c8 THEN subq0.c7
      WHEN t1.c4 = subq0.c12 THEN subq0.c9
      ELSE t1.c0
 END = t1.c0
ORDER BY c20 ASC, c13 ASC;
