CREATE TABLE t0 (
            c0 BOOLEAN,
            c1 BLOB,
            c2 INTEGER,
            c3 INTEGER
        );
        WITH cte0 AS (
        SELECT COALESCE(t4.c0, CAST(t9.c1 AS BLOB), NULLIF(t11.c0, t9.c0), t4.c3, t5.c1) AS c4, like(NULL,FALSE) AS c5, t11.c3 AS c6, t5.c0 AS c7, t5.c1 AS c8, t9.c0 AS c9, t2.c3 AS c10, t11.c3 AS c11,
          CASE t11.c1 WHEN t9.c1 = t3.c1 THEN t2.c1
               ELSE IFNULL(X'4534f90f', t3.c1)
          END AS c12, t10.c0 AS c13, t10.c1 AS c14, t9.c0 AS c15, t6.c0 AS c16
         FROM t0 AS t1
            LEFT JOIN (
            t0 AS t2
               LEFT JOIN t0 AS t3
                ON (t2.c3 IS NULL)
              INNER JOIN (
              t0 AS t4
               INNER JOIN t0 AS t5
                ON (t4.c3 = t5.c2)      )
               ON (t3.c2 = t5.c2)
             INNER JOIN t0 AS t6
              ON (t3.c2 = t6.c2)    )
             ON (t1.c0 <> t2.c0)
           LEFT JOIN (
           t0 AS t7
              INNER JOIN t0 AS t8
               ON (t8.c2 IS NOT NULL)
             INNER JOIN (
             t0 AS t9
              INNER JOIN t0 AS t10
               ON (t10.c3 <= t10.c3)     )
              ON (false)
            INNER JOIN t0 AS t11
             ON (t10.c2 IS NULL)   )
            ON (true)
         WHERE t11.c3 = t11.c3
         ORDER BY c16 COLLATE NOCASE, c9
         LIMIT 984787926489729537 OFFSET 3177233916585467417
        ), cte1 AS (
        SELECT t12.c3 AS c8, t12.c2 AS c9,
          CASE WHEN t12.c2 < t12.c2 THEN subq0.c5
               ELSE subq0.c5
          END AS c10, t12.c3 AS c11, t12.c2 AS c12, t12.c2 AS c13, t12.c3 AS c14, subq0.c5 AS c15, t12.c1 AS c16
         FROM t0 AS t12
            CROSS JOIN t0 AS t13
             ON (true)
           LEFT JOIN (SELECT t14.c3 AS c4, t14.c3 AS c5, t14.c0 AS c6, t14.c1 AS c7
             FROM t0 AS t14
             WHERE t14.c1 <> t14.c1
             ORDER BY c7 ASC
             LIMIT 4363772089824810580 ) as subq0
            ON (false)
         WHERE
          CASE subq0.c5 WHEN subq0.c6 IS NOT NULL THEN t13.c3
               WHEN t13.c0 <>
           CASE t13.c0 WHEN subq0.c4 = t12.c3 THEN subq0.c6
                WHEN subq0.c7 = t13.c1 THEN subq0.c6
                WHEN CAST(t13.c1 AS BOOLEAN) IS NULL AND t13.c3 = subq0.c5 THEN t13.c0
                WHEN likelihood(NULL,0.021238) <= subq0.c5 THEN subq0.c6
                ELSE subq0.c6
           END THEN t12.c3
               WHEN t13.c0 <> t12.c0 THEN subq0.c5
               WHEN subq0.c7 > t12.c1 OR 36 > t13.c3 AND 96 = t12.c2 THEN subq0.c4
               WHEN t13.c3 > subq0.c5 THEN subq0.c5
               WHEN t12.c2 <= t13.c3 THEN t13.c2
               WHEN false THEN subq0.c5
               ELSE subq0.c5
          END >= subq0.c5 AND true OR t13.c0 = subq0.c6 OR subq0.c5 IS NULL AND t12.c0 = FALSE OR COALESCE(t12.c2, t12.c2, t13.c2, t13.c3) >= CAST(subq0.c6 AS TEXT)
         ORDER BY c8, c14 COLLATE NOCASE
        ), cte2 AS (
        SELECT t15.c3 AS c4, t15.c3 AS c5, t15.c0 AS c6, t15.c0 AS c7, t15.c3 AS c8, t15.c2 AS c9,
          CASE t15.c1 WHEN false OR t15.c1 IS NULL AND
           CASE t15.c0 WHEN t15.c0 IS NULL AND t15.c3 <> like(NULL,'text20') THEN t15.c0
                WHEN true AND t15.c1 = CAST(t15.c0 AS BLOB) THEN t15.c0
                WHEN t15.c3 IS NULL THEN t15.c0
                WHEN t15.c3 >= t15.c3 OR EXISTS (
            SELECT 33 AS c4, t16.c2 AS c5
             FROM t0 AS t16
             WHERE t16.c3 < t16.c2
             ORDER BY c4 COLLATE RTRIM DESC
             LIMIT 6121260869267060666 OFFSET 4911288594628582095
            ) THEN t15.c0
                WHEN CAST(t15.c2 AS BLOB) >= t15.c3 THEN t15.c0
                WHEN true AND 3 >= t15.c2 THEN
            CASE WHEN t15.c2 >= t15.c3 THEN t15.c0
                 ELSE t15.c0
            END
                ELSE t15.c0
           END <>
           CASE WHEN t15.c2 IS NOT NULL THEN t15.c0
                ELSE t15.c0
           END AND t15.c1 >= t15.c1 OR t15.c2 < t15.c3 AND t15.c2 = t15.c2 THEN t15.c1
               WHEN t15.c2 > t15.c2 THEN X'b6f6af76'
               WHEN t15.c3 < t15.c2 AND true THEN t15.c1
               WHEN t15.c3 >= t15.c3 THEN t15.c1
               WHEN t15.c3 >= t15.c3 THEN t15.c1
               WHEN t15.c0 = t15.c0 THEN t15.c1
               WHEN t15.c0 <> t15.c0 THEN t15.c1
               WHEN 73 <= t15.c3 THEN
           CASE t15.c1 WHEN t15.c2 = t15.c3 OR true AND t15.c1 <> t15.c1 THEN t15.c1
                WHEN t15.c0 IS NULL THEN t15.c1
                WHEN t15.c1 <> t15.c1 THEN t15.c1
                WHEN false THEN t15.c1
                ELSE t15.c1
           END
               WHEN t15.c1 >= CAST(t15.c3 AS BLOB) AND false THEN t15.c1
               WHEN X'5f84e29d' <= t15.c1 OR t15.c3 <= t15.c3 AND
           CASE WHEN EXISTS (
            SELECT t18.c1 AS c4, t19.c0 AS c5, t18.c2 AS c6, t17.c2 AS c7, t19.c2 AS c8
             FROM t0 AS t17
                INNER JOIN t0 AS t18
                 ON (t17.c1 = t18.c1)
               CROSS JOIN t0 AS t19
                ON (t18.c3 IS NULL)
             WHERE t19.c3 < t18.c2 OR t19.c0 <> t19.c0 AND t19.c2 <> t19.c3
             ORDER BY c6, c4 ASC, c7 ASC
             LIMIT 6987904410604623467
            ) THEN t15.c0
                ELSE CAST(t15.c1 AS TEXT)
           END = t15.c0 THEN COALESCE(t15.c0,
            CASE WHEN t15.c0 <> t15.c0 THEN NULL
                 ELSE NULL
            END)
               WHEN glob(X'428f5591',TRUE) > t15.c3 THEN
           CASE WHEN t15.c0 = COALESCE(t15.c0, t15.c0, t15.c3, t15.c0, t15.c3, t15.c0) THEN t15.c1
                ELSE t15.c1
           END
               WHEN t15.c1 > t15.c1 OR t15.c3 = t15.c3 OR t15.c3 < 44 THEN t15.c1
               ELSE
           CASE t15.c1 WHEN t15.c2 IS NULL AND false THEN t15.c1
                WHEN t15.c3 > t15.c2 AND t15.c2 >= t15.c2 THEN t15.c1
                WHEN t15.c0 IS NULL AND t15.c3 =
            CASE WHEN t15.c2 >= t15.c3 THEN t15.c3
                 ELSE t15.c3
            END AND EXISTS (
            SELECT t20.c2 AS c4, t20.c2 AS c5, t20.c1 AS c6, t20.c2 AS c7
             FROM t0 AS t20
             WHERE false
             ORDER BY c6, c7, c6
            ) OR t15.c0 <> t15.c0 AND t15.c3 >= t15.c3 AND t15.c0 <> t15.c0 THEN t15.c1
                WHEN t15.c0 IS NOT NULL THEN t15.c1
                WHEN t15.c3 >= t15.c3 AND false OR t15.c3 IS NULL OR true AND false AND t15.c0 = t15.c0 THEN t15.c1
                WHEN t15.c2 < COALESCE(TRUE,
             CASE WHEN t15.c1 >= t15.c1 AND t15.c3 < t15.c2 OR t15.c3 > t15.c2 THEN CAST(t15.c0 AS INTEGER)
                  ELSE NULL
             END, t15.c3, t15.c2, t15.c3, t15.c2) THEN t15.c1
                WHEN
            CASE t15.c1 WHEN EXISTS (
             SELECT t22.c1 AS c4, t21.c1 AS c5
              FROM t0 AS t21
                INNER JOIN t0 AS t22
                 ON (true)
              WHERE FALSE IS NULL
              ORDER BY c5, c4
              LIMIT 8935439260303621600
             ) THEN t15.c1
                 WHEN t15.c2 <> t15.c3 THEN t15.c1
                 ELSE t15.c1
            END <> t15.c1 THEN t15.c1
                WHEN EXISTS (
            SELECT t23.c3 AS c4, t23.c2 AS c5
             FROM t0 AS t23
             WHERE t23.c2 <> t23.c2 AND X'b1d0c660' > t23.c1 AND t23.c3 IS NULL AND t23.c3 >= t23.c2
             ORDER BY c4 COLLATE NOCASE
            ) THEN
            CASE t15.c1 WHEN t15.c0 <> FALSE THEN X'fd4fea72'
                 WHEN t15.c1 <> t15.c1 OR t15.c0 = t15.c0 AND
             CASE WHEN t15.c3 = t15.c2 THEN t15.c3
                  ELSE t15.c3
             END > t15.c3 OR t15.c0 <> t15.c0 AND t15.c2 IS NOT NULL AND t15.c2 < t15.c3 AND t15.c1 IS NULL THEN t15.c1
                 WHEN false THEN t15.c1
                 WHEN t15.c1 <> t15.c1 THEN t15.c1
                 WHEN t15.c1 = t15.c1 THEN t15.c1
                 WHEN t15.c3 = t15.c2 THEN t15.c1
                 ELSE t15.c1
            END
                ELSE t15.c1
           END
          END AS c6, t15.c2 AS c7
         FROM t0 AS t15
         WHERE t15.c0 <> FALSE
         ORDER BY c7
         LIMIT 3145780324746856724
        ), cte3 AS (
        SELECT t26.c2 AS c4, t26.c1 AS c5, subq1.c4 AS c6, subq2.c5 AS c7, subq1.c6 AS c8
         FROM (SELECT t24.c3 AS c4, t24.c0 AS c5, t24.c0 AS c6, t24.c1 AS c7, t24.c1 AS c8
             FROM t0 AS t24
             WHERE t24.c0 <> t24.c0
             ORDER BY c6 ASC
             LIMIT 2532018708546537331 OFFSET 1232015651327623920) as subq1
           LEFT JOIN (
           (SELECT t25.c1 AS c4, t25.c3 AS c5
              FROM t0 AS t25
              WHERE t25.c3 = t25.c2
              ORDER BY c5 DESC, c5 ASC, c5, c4 COLLATE NOCASE DESC, c4) as subq2
            LEFT JOIN t0 AS t26
             ON (false)   )
            ON (likely( NULL) >= subq2.c5)
         WHERE t26.c2 <>
          CASE WHEN subq2.c4 <> X'1c8e3c51' OR subq2.c5 = t26.c3 THEN subq1.c4
               ELSE 29
          END
         ORDER BY c6 ASC, c6, c4
        ), cte4 AS (
        SELECT t27.c0 AS c4
         FROM t0 AS t27
         WHERE EXISTS (
          SELECT t29.c0 AS c4, t29.c1 AS c5, t28.c3 AS c6, t28.c1 AS c7, instr(TRUE,X'8395442e') AS c8
           FROM t0 AS t28
             INNER JOIN t0 AS t29
              ON (t28.c0 = t28.c0)
           WHERE t29.c0 IS NOT NULL OR t28.c1 IS NULL
           ORDER BY c8, c6, c5
           LIMIT 4828279198547278562 OFFSET 6720961285169446335
          )
         ORDER BY c4 DESC
         LIMIT 8798543568268684072
        ), cte5 AS (
        SELECT subq3.c4 AS c5, subq3.c4 AS c6
         FROM (SELECT t31.c2 AS c4
            FROM t0 AS t30
              LEFT JOIN t0 AS t31
               ON (t31.c3 > t30.c3)
            WHERE t30.c2 > t30.c3
            ORDER BY c4) as subq3
         WHERE subq3.c4 < subq3.c4
         ORDER BY c5 ASC, c6 ASC, c6, c6 COLLATE NOCASE, c6 DESC
         LIMIT 6934518183931425302 OFFSET 4889192710036676453
        ), cte6 AS (
        SELECT changes() AS c4
         FROM t0 AS t32
         WHERE EXISTS (
          SELECT subq4.c6 AS c7, subq4.c5 AS c8
           FROM (SELECT t33.c0 AS c4, t33.c0 AS c5, t33.c0 AS c6
              FROM t0 AS t33
              WHERE t33.c1 <> t33.c1 AND t33.c1 IS NOT NULL
              ORDER BY c4, c5 ASC
              LIMIT 4341955145835816642 OFFSET 6168886671401952516) as subq4
           WHERE subq4.c5 <> subq4.c5 OR false OR subq4.c5 <> subq4.c4
           ORDER BY c7 ASC, c8, c8 DESC, c7, c8 DESC
           LIMIT 2436938149920978479 OFFSET 3806792540028576091
          )
         ORDER BY c4, c4, c4, c4, c4 ASC
         LIMIT 1495297699718987670
        ), cte7 AS (
        SELECT subq5.c8 AS c10, X'8ae13f1c' AS c11, subq5.c5 AS c12, subq5.c8 AS c13
         FROM (SELECT t34.c2 AS c4, t35.c1 AS c5, t35.c1 AS c6, t34.c0 AS c7, t34.c1 AS c8, t35.c3 AS c9
            FROM t0 AS t34
              LEFT JOIN t0 AS t35
               ON (false)
            WHERE t34.c1 > t35.c1
            ORDER BY c5 DESC, c5 ASC
            LIMIT 784438155366877240 OFFSET 6555875086290180906) as subq5
         WHERE subq5.c5 >= subq5.c8
         ORDER BY c12, c12
         LIMIT 9160030243326398414 OFFSET 6560140355752991108
        ), cte8 AS (
        SELECT CAST(subq6.c4 AS INTEGER) AS c6, subq6.c4 AS c7
         FROM (SELECT t36.c3 AS c4, t36.c2 AS c5
            FROM t0 AS t36
              INNER JOIN (
              t0 AS t37
               LEFT JOIN t0 AS t38
                ON (t37.c2 <> t38.c3)      )
               ON (t38.c0 = FALSE AND t36.c3 <> t38.c2 OR true)
            WHERE false AND t36.c3 = t36.c3
            ORDER BY c4 ASC, c4 ASC) as subq6
         WHERE subq6.c5 <= subq6.c5
         ORDER BY c6, c7, c7 DESC, c6 ASC, c7
         LIMIT 7887725421566407498
        ), cte9 AS (
        SELECT t39.c3 AS c4, t39.c0 AS c5
         FROM t0 AS t39
         WHERE t39.c0 = t39.c0
         ORDER BY c4 COLLATE RTRIM, c5 ASC, c5, c4 COLLATE BINARY, c4 COLLATE NOCASE DESC
        ), cte10 AS (
        SELECT
          CASE subq7.c33 WHEN
           CASE subq7.c10 WHEN subq7.c30 = subq7.c14 OR subq7.c11 IS NULL THEN subq7.c10
                WHEN subq7.c17 < subq7.c41 THEN subq7.c13
                WHEN EXISTS (
            SELECT t43.c0 AS c4, t42.c3 AS c5, t42.c2 AS c6, t43.c0 AS c7, t42.c3 AS c8, t43.c3 AS c9, t43.c2 AS c10, t43.c3 AS c11, t42.c2 AS c12, t43.c0 AS c13, t43.c1 AS c14, t42.c0 AS c15, t43.c2 AS c16, t43.c0 AS c17, t42.c0 AS c18, t43.c1 AS c19, t42.c2 AS c20, t43.c2 AS c21
             FROM t0 AS t42
               INNER JOIN t0 AS t43
                ON (t42.c3 = t43.c2)
             WHERE EXISTS (
              SELECT t44.c0 AS c4, X'd9b6da2e' AS c5, t44.c1 AS c6, t44.c0 AS c7, t44.c0 AS c8, t44.c2 AS c9, t44.c3 AS c10, t44.c2 AS c11, t44.c2 AS c12, t44.c3 AS c13, t44.c2 AS c14, t44.c0 AS c15, t44.c1 AS c16, t44.c0 AS c17, t44.c2 AS c18
               FROM t0 AS t44
               WHERE EXISTS (
                SELECT t45.c0 AS c4, t45.c1 AS c5, t45.c3 AS c6, t45.c1 AS c7, t45.c3 AS c8, t45.c1 AS c9, t45.c2 AS c10, t45.c1 AS c11
                 FROM t0 AS t45
                 WHERE t45.c2 <> t45.c2
                 ORDER BY c9, c4
                )
               ORDER BY c11, c5 COLLATE NOCASE, c16
               LIMIT 5809126036781140600
              ) OR t42.c1 < t43.c1
             ORDER BY c15, c4 COLLATE BINARY
            ) THEN subq7.c36
                WHEN false THEN subq7.c21
                WHEN subq7.c32 >= subq7.c24 THEN subq7.c28
                WHEN true THEN subq7.c26
                ELSE subq7.c39
           END <> subq7.c28 THEN subq7.c41
               WHEN subq7.c14 IS NOT NULL THEN X'a8bba556'
               WHEN false THEN subq7.c27
               WHEN false THEN subq7.c33
               WHEN subq7.c5 = subq7.c13 THEN X'da50acdc'
               WHEN subq7.c14 <> subq7.c30 AND subq7.c32 IS NOT NULL OR X'90aeec69' > subq7.c33 THEN IFNULL(subq7.c9, subq7.c17)
               ELSE subq7.c16
          END AS c12,
          CASE WHEN false THEN subq7.c27
               ELSE subq7.c6
          END AS c13, subq7.c27 AS c14, subq7.c14 AS c15, subq7.c21 AS c16, subq7.c29 AS c17, subq7.c17 AS c18,
          CASE subq7.c41 WHEN subq7.c11 > subq7.c10 THEN subq7.c34
               WHEN subq7.c13 >= subq7.c19 THEN X'dfb306d9'
               WHEN subq7.c27 > subq7.c34 THEN subq7.c41
               WHEN subq7.c30 = subq7.c29 THEN subq7.c9
               WHEN subq7.c33 <> subq7.c4 THEN subq7.c16
               WHEN false THEN
           CASE subq7.c41 WHEN subq7.c4 IS NOT NULL THEN subq7.c38
                WHEN subq7.c26 <> subq7.c32 AND subq7.c34 > subq7.c17 THEN subq7.c9
                WHEN subq7.c32 <= subq7.c8 THEN subq7.c20
                ELSE subq7.c20
           END
               WHEN subq7.c22 <> subq7.c5 THEN subq7.c9
               WHEN subq7.c41 <= X'395594fc' OR 2 < subq7.c15 THEN subq7.c6
               ELSE subq7.c38
          END AS c19, subq7.c26 AS c20, subq7.c26 AS c21, subq7.c35 AS c22, subq7.c37 AS c23
         FROM (SELECT t40.c1 AS c4, t40.c3 AS c5, t40.c1 AS c6, t40.c3 AS c7, t40.c3 AS c8, t40.c1 AS c9, t40.c3 AS c10, t40.c2 AS c11,
             CASE t40.c0 WHEN t40.c0 = t40.c0 THEN t40.c0
                  WHEN CAST(t40.c2 AS INTEGER) IS NULL THEN t40.c0
                  ELSE t40.c0
             END AS c12, t40.c2 AS c13, t40.c0 AS c14, t40.c3 AS c15, CAST(t40.c0 AS BOOLEAN) AS c16, t40.c1 AS c17, t40.c0 AS c18, t40.c3 AS c19, t40.c1 AS c20, t40.c2 AS c21, t40.c3 AS c22, t40.c3 AS c23, t40.c2 AS c24, t40.c3 AS c25, NULLIF(t40.c3, t40.c3) AS c26, CAST(t40.c0 AS TEXT) AS c27, t40.c2 AS c28, t40.c0 AS c29, t40.c0 AS c30, t40.c0 AS c31, t40.c2 AS c32, t40.c1 AS c33, t40.c1 AS c34, t40.c3 AS c35, t40.c2 AS c36, t40.c0 AS c37, t40.c1 AS c38, t40.c3 AS c39, t40.c2 AS c40, t40.c1 AS c41
            FROM t0 AS t40
            WHERE t40.c3 >= 51 AND t40.c2 <> t40.c3 OR EXISTS (
             SELECT t41.c1 AS c4, t41.c1 AS c5, t41.c2 AS c6, t41.c0 AS c7
              FROM t0 AS t41
              WHERE true
              ORDER BY c6, c5, c4
              LIMIT 1516166502531311827 OFFSET 3589648532708247829
             )
            ORDER BY c41
            LIMIT 7624497011460768375 ) as subq7
         WHERE 27 = subq7.c21
         ORDER BY c23, c16 DESC, c20
        ), cte11 AS (
        SELECT subq8.c5 AS c4, t47.c1 AS c5, subq8.c4 AS c6
         FROM (SELECT t46.c3 AS c4, t46.c0 AS c5
             FROM t0 AS t46
             WHERE true
             ORDER BY c4 COLLATE BINARY ASC, c4 DESC
             LIMIT 9126758867602662757 ) as subq8
           LEFT JOIN t0 AS t47
            ON (subq8.c4 IS NOT NULL)
         WHERE t47.c2 <
          CASE WHEN t47.c3 < t47.c3 THEN subq8.c4
               ELSE 60
          END AND EXISTS (
          SELECT t48.c0 AS c4, t48.c2 AS c5, t48.c0 AS c6, t49.c0 AS c7
           FROM t0 AS t48
             LEFT JOIN t0 AS t49
              ON (t48.c1 <= t49.c1)
           WHERE EXISTS (
            SELECT t50.c0 AS c4
             FROM t0 AS t50
             WHERE EXISTS (
              SELECT t51.c2 AS c4
               FROM t0 AS t51
               WHERE t51.c1 <= t51.c1 OR false OR t51.c1 = t51.c1
               ORDER BY c4
              )
             ORDER BY c4, c4 ASC, c4, c4 COLLATE RTRIM, c4 COLLATE RTRIM ASC
             LIMIT 2654765777187074528 OFFSET 3724706489530633255
            )
           ORDER BY c5 DESC, c7 ASC, c5
           LIMIT 2254513205670203618 OFFSET 6340427620702674737
          ) OR EXISTS (
          SELECT t52.c1 AS c4, t52.c3 AS c5
           FROM t0 AS t52
           WHERE t52.c3 > t52.c2 OR t52.c1 >= CAST(t52.c0 AS BLOB) OR t52.c2 < t52.c3 AND t52.c3 <> t52.c3
           ORDER BY c5 ASC
           LIMIT 6071630205145395608 OFFSET 2729188623890119843
          ) AND true OR EXISTS (
          SELECT t53.c0 AS c4, t53.c3 AS c5, t53.c2 AS c6, t53.c2 AS c7,
            CASE t53.c1 WHEN t53.c2 <> t53.c3 OR t53.c3 IS NOT NULL THEN t53.c1
                 WHEN 24 = t53.c3 THEN t53.c1
                 WHEN t53.c0 <> t53.c0 AND t53.c2 = t53.c2 THEN t53.c1
                 WHEN CAST(t53.c1 AS BOOLEAN) = t53.c0 THEN t53.c1
                 WHEN t53.c0 <> t53.c0 THEN t53.c1
                 WHEN IFNULL(t53.c1, t53.c1) > t53.c1 AND 15 IS NULL AND t53.c1 > t53.c1 THEN t53.c1
                 WHEN t53.c0 <> t53.c0 OR t53.c0 <> t53.c0 OR
             CASE t53.c2 WHEN t53.c0 = t53.c0 THEN
              CASE WHEN t53.c1 = t53.c1 THEN t53.c2
                   ELSE t53.c3
              END
                  WHEN true THEN t53.c2
                  WHEN t53.c0 <> t53.c0 THEN t53.c3
                  WHEN t53.c2 > t53.c2 THEN t53.c3
                  WHEN EXISTS (
              SELECT t54.c2 AS c4
               FROM t0 AS t54
               WHERE t54.c2 <> t54.c2
               ORDER BY c4
               LIMIT 4592403434843744147
              ) AND t53.c1 = t53.c1 THEN t53.c2
                  WHEN X'b28b11ef' >= t53.c1 THEN t53.c2
                  WHEN t53.c0 IS NOT NULL THEN t53.c3
                  ELSE t53.c3
             END > t53.c3 THEN t53.c1
                 WHEN t53.c0 IS NOT NULL THEN t53.c1
                 WHEN t53.c3 <= t53.c3 AND t53.c2 < t53.c3 THEN t53.c1
                 ELSE t53.c1
            END AS c5, zeroblob( 9) AS c6,
            CASE t53.c0 WHEN nullif('text99',NULL) IS NOT NULL THEN t53.c0
                 WHEN t53.c2 > t53.c3 OR t53.c2 <= t53.c3 THEN t53.c0
                 WHEN EXISTS (
             SELECT t55.c2 AS c4, t56.c1 AS c5, t56.c1 AS c6, t56.c3 AS c7, t55.c2 AS c8, t55.c2 AS c9
              FROM t0 AS t55
                INNER JOIN t0 AS t56
                 ON (t55.c2 = t56.c2)
              WHERE t55.c3 >= t56.c3
              ORDER BY c6, c5
             ) THEN t53.c0
                 WHEN t53.c0 = t53.c0 OR t53.c0 <> t53.c0 THEN FALSE
                 WHEN t53.c3 > t53.c3 THEN COALESCE(t53.c3, TRUE, t53.c0)
                 WHEN t53.c0 = t53.c0 OR t53.c3 <= t53.c2 THEN t53.c0
                 WHEN t53.c1 < t53.c1 THEN t53.c0
                 WHEN t53.c2 <> t53.c3 AND t53.c3 < t53.c3 OR t53.c0 = t53.c0 THEN t53.c0
                 ELSE t53.c0
            END AS c10, t53.c3 AS c11, t53.c0 AS c12, t53.c3 AS c13, t53.c3 AS c14, t53.c1 AS c15, t53.c3 AS c16
           FROM t0 AS t53
           WHERE t53.c2 <> t53.c2 AND t53.c0 <> t53.c0
           ORDER BY c13 DESC, c13 DESC, c4 ASC
          ) OR 56 = subq8.c4 AND t47.c1 >= t47.c1
         ORDER BY c6
        ), cte12 AS (
        SELECT t57.c2 AS c4
         FROM t0 AS t57
         WHERE t57.c1 IS NULL AND t57.c2 >= t57.c3 OR t57.c2 IS NULL OR
          CASE t57.c2 WHEN EXISTS (
           SELECT t58.c2 AS c4
            FROM t0 AS t58
            WHERE t58.c3 < t58.c3
            ORDER BY c4 ASC
            LIMIT 2524194830875506617 OFFSET 1025691471528465556
           ) THEN t57.c2
               WHEN t57.c3 = t57.c3 THEN t57.c3
               WHEN
           CASE WHEN t57.c0 = t57.c0 THEN t57.c3
                ELSE t57.c3
           END >= CAST(t57.c3 AS BOOLEAN) THEN t57.c3
               WHEN 46 >= t57.c3 THEN t57.c2
               ELSE t57.c3
          END <= t57.c3
         ORDER BY c4
         LIMIT 552948462492477691 OFFSET 6395012827043578859
        )SELECT subq10.c17 AS c8, subq10.c16 AS c9, subq10.c15 AS c10, subq10.c16 AS c11, subq10.c14 AS c12, subq10.c17 AS c13
         FROM (SELECT subq9.c8 AS c14, subq9.c11 AS c15, TRUE AS c16, subq9.c10 AS c17
            FROM (SELECT t59.c3 AS c4, t60.c0 AS c5, t59.c3 AS c6, t59.c0 AS c7, t59.c2 AS c8, t60.c0 AS c9, t59.c0 AS c10, t60.c1 AS c11, t59.c3 AS c12, t59.c1 AS c13
               FROM t0 AS t59
                 LEFT OUTER JOIN t0 AS t60
                  ON (t59.c3 IS NOT NULL)
               WHERE t59.c3 > t59.c2
               ORDER BY c12 COLLATE NOCASE, c6 ASC, c4) as subq9
            WHERE EXISTS (
             SELECT t62.c3 AS c4, t61.c2 AS c5, t61.c2 AS c6, t62.c0 AS c7
              FROM t0 AS t61
                INNER JOIN t0 AS t62
                 ON (t62.c2 < t61.c3)
              WHERE t62.c1 <> t62.c1
              ORDER BY c4, c6
              LIMIT 7465852383001526970 OFFSET 7892240695901365899
             )
            ORDER BY c16 ASC) as subq10
         WHERE 51 < subq10.c14 OR subq10.c17 =
          CASE subq10.c16 WHEN subq10.c16 IS NULL THEN subq10.c16
               ELSE subq10.c16
          END
         ORDER BY c12, c8 COLLATE RTRIM
         LIMIT 414725328173764698 ;
