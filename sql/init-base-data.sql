-- ======================================
-- 基础数据初始化 SQL（车站、火车、经停站、车厢、座位）
-- ======================================

-- 一、车站
INSERT INTO station (id, name, name_pinyin, name_py, create_time, update_time) VALUES
(1,  '北京',     'bei_jing',              'bj',  now(3), now(3)),
(2,  '北京南',   'bei_jing_nan',          'bjn', now(3), now(3)),
(3,  '上海',     'shang_hai',             'sh',  now(3), now(3)),
(4,  '上海虹桥', 'shang_hai_hong_qiao',   'shhq',now(3), now(3)),
(5,  '广州',     'guang_zhou',            'gz',  now(3), now(3)),
(6,  '广州南',   'guang_zhou_nan',        'gzn', now(3), now(3)),
(7,  '深圳',     'shen_zhen',             'sz',  now(3), now(3)),
(8,  '武汉',     'wu_han',                'wh',  now(3), now(3)),
(9,  '杭州',     'hang_zhou',             'hz',  now(3), now(3)),
(10, '南京',     'nan_jing',              'nj',  now(3), now(3)),
(11, '济南',     'ji_nan',                'jn',  now(3), now(3)),
(12, '长沙',     'chang_sha',             'cs',  now(3), now(3)),
(13, '成都',     'cheng_du',              'cd',  now(3), now(3)),
(14, '西安',     'xi_an',                 'xa',  now(3), now(3));

-- 二、车次
INSERT INTO train (id, code, type, `start`, start_pinyin, start_time, `end`, end_pinyin, end_time, create_time, update_time) VALUES
(1, 'G1',   'G', '北京南', 'bei_jing_nan',  '07:00:00', '上海虹桥', 'shang_hai_hong_qiao', '11:30:00', now(3), now(3)),
(2, 'G2',   'G', '上海虹桥','shang_hai_hong_qiao','07:00:00','北京南', 'bei_jing_nan',         '11:30:00', now(3), now(3)),
(3, 'D2161','D', '广州南', 'guang_zhou_nan', '08:00:00', '武汉',    'wu_han',                '12:30:00', now(3), now(3)),
(4, 'K179', 'K', '北京',   'bei_jing',       '22:32:00', '广州',    'guang_zhou',            '21:16:00', now(3), now(3));

-- 三、经停站（火车车站）

-- G1: 北京南 → 济南 → 南京 → 上海虹桥
INSERT INTO train_station (id, train_code, `index`, name, name_pinyin, in_time, out_time, stop_time, km, create_time, update_time) VALUES
(1,  'G1', 0, '北京南',   'bei_jing_nan',          NULL,       '07:00:00', NULL,    0,      now(3), now(3)),
(2,  'G1', 1, '济南',     'ji_nan',                '08:18:00', '08:20:00', '00:02', 406,    now(3), now(3)),
(3,  'G1', 2, '南京',     'nan_jing',              '10:38:00', '10:40:00', '00:02', 1023,   now(3), now(3)),
(4,  'G1', 3, '上海虹桥', 'shang_hai_hong_qiao',   '11:30:00', NULL,       NULL,    1318,   now(3), now(3));

-- G2: 上海虹桥 → 南京 → 济南 → 北京南
INSERT INTO train_station (id, train_code, `index`, name, name_pinyin, in_time, out_time, stop_time, km, create_time, update_time) VALUES
(5,  'G2', 0, '上海虹桥', 'shang_hai_hong_qiao',   NULL,       '07:00:00', NULL,    0,      now(3), now(3)),
(6,  'G2', 1, '南京',     'nan_jing',              '07:52:00', '07:54:00', '00:02', 295,    now(3), now(3)),
(7,  'G2', 2, '济南',     'ji_nan',                '09:58:00', '10:00:00', '00:02', 912,    now(3), now(3)),
(8,  'G2', 3, '北京南',   'bei_jing_nan',          '11:30:00', NULL,       NULL,    1318,   now(3), now(3));

-- D2161: 广州南 → 长沙 → 武汉
INSERT INTO train_station (id, train_code, `index`, name, name_pinyin, in_time, out_time, stop_time, km, create_time, update_time) VALUES
(9,  'D2161', 0, '广州南', 'guang_zhou_nan', NULL,       '08:00:00', NULL,    0,      now(3), now(3)),
(10, 'D2161', 1, '长沙',   'chang_sha',      '09:58:00', '10:02:00', '00:04', 707,    now(3), now(3)),
(11, 'D2161', 2, '武汉',   'wu_han',         '12:30:00', NULL,       NULL,    1069,   now(3), now(3));

-- K179: 北京 → 武汉 → 长沙 → 广州
INSERT INTO train_station (id, train_code, `index`, name, name_pinyin, in_time, out_time, stop_time, km, create_time, update_time) VALUES
(12, 'K179', 0, '北京', 'bei_jing', NULL,       '22:32:00', NULL,    0,      now(3), now(3)),
(13, 'K179', 1, '武汉', 'wu_han',   '06:28:00', '06:34:00', '00:06', 1225,   now(3), now(3)),
(14, 'K179', 2, '长沙', 'chang_sha','10:04:00', '10:10:00', '00:06', 1587,   now(3), now(3)),
(15, 'K179', 3, '广州', 'guang_zhou','21:16:00', NULL,       NULL,    2294,   now(3), now(3));

-- 四、车厢

-- G1 车厢：1号一等座，2号二等座
INSERT INTO train_carriage (id, train_code, `index`, seat_type, seat_count, row_count, col_count, create_time, update_time) VALUES
(1, 'G1', 1, '1', 20, 5, 4, now(3), now(3)),   -- 一等座 5排×4列
(2, 'G1', 2, '2', 85, 17, 5, now(3), now(3));   -- 二等座 17排×5列

-- G2 车厢：1号一等座，2号二等座
INSERT INTO train_carriage (id, train_code, `index`, seat_type, seat_count, row_count, col_count, create_time, update_time) VALUES
(3, 'G2', 1, '1', 20, 5, 4, now(3), now(3)),
(4, 'G2', 2, '2', 85, 17, 5, now(3), now(3));

-- D2161 车厢：1号一等座，2号二等座
INSERT INTO train_carriage (id, train_code, `index`, seat_type, seat_count, row_count, col_count, create_time, update_time) VALUES
(5, 'D2161', 1, '1', 20, 5, 4, now(3), now(3)),
(6, 'D2161', 2, '2', 85, 17, 5, now(3), now(3));

-- K179 车厢：1号硬卧，2号软卧
INSERT INTO train_carriage (id, train_code, `index`, seat_type, seat_count, row_count, col_count, create_time, update_time) VALUES
(7, 'K179', 1, '4', 66, 11, 6, now(3), now(3)),  -- 硬卧 11排×6列
(8, 'K179', 2, '3', 36, 9, 4, now(3), now(3));   -- 软卧 9排×4列

-- 五、座位（通过存储过程根据车厢的 row_count 和 seat_type 自动生成）

-- 临时分隔符，允许存储过程内使用分号
DELIMITER //

DROP PROCEDURE IF EXISTS gen_seat //

CREATE PROCEDURE gen_seat()
BEGIN
    DECLARE v_id BIGINT DEFAULT 1000;
    DECLARE v_done INT DEFAULT FALSE;
    DECLARE v_train_code VARCHAR(20);
    DECLARE v_carriage_index INT;
    DECLARE v_seat_type CHAR(1);
    DECLARE v_row_count INT;
    DECLARE v_seat_index INT;
    DECLARE v_row INT;
    DECLARE v_col_code CHAR(1);

    -- 清空已有座位
    DELETE FROM train_seat;

    -- 游标：遍历所有车厢
    DECLARE cur_carriage CURSOR FOR
        SELECT train_code, `index`, seat_type, row_count FROM train_carriage ORDER BY train_code, `index`;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;

    OPEN cur_carriage;

    carriage_loop: LOOP
        FETCH cur_carriage INTO v_train_code, v_carriage_index, v_seat_type, v_row_count;
        IF v_done THEN
            LEAVE carriage_loop;
        END IF;

        SET v_seat_index = 1;

        -- 根据座位类型决定列号列表并循环插入
        -- 一等座(seat_type=1): A, C, D, F
        IF v_seat_type = '1' THEN
            SET v_row = 1;
            WHILE v_row <= v_row_count DO
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'A', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'C', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'D', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'F', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                SET v_row = v_row + 1;
            END WHILE;

        -- 二等座(seat_type=2): A, B, C, D, F
        ELSEIF v_seat_type = '2' THEN
            SET v_row = 1;
            WHILE v_row <= v_row_count DO
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'A', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'B', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'C', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'D', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'F', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                SET v_row = v_row + 1;
            END WHILE;

        -- 软卧(seat_type=3): A, B, C, D（上下铺各2列）
        ELSEIF v_seat_type = '3' THEN
            SET v_row = 1;
            WHILE v_row <= v_row_count DO
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'A', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'B', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'C', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'D', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                SET v_row = v_row + 1;
            END WHILE;

        -- 硬卧(seat_type=4): A, B, C, D, E, F（上中下铺各2列）
        ELSEIF v_seat_type = '4' THEN
            SET v_row = 1;
            WHILE v_row <= v_row_count DO
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'A', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'B', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'C', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'D', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'E', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                INSERT INTO train_seat (id, train_code, carriage_index, `row`, col, seat_type, carriage_seat_index, create_time, update_time)
                VALUES
                    (v_id, v_train_code, v_carriage_index, LPAD(v_row, 2, '0'), 'F', v_seat_type, v_seat_index, now(3), now(3)); SET v_id = v_id + 1; SET v_seat_index = v_seat_index + 1;
                SET v_row = v_row + 1;
            END WHILE;
        END IF;

    END LOOP;

    CLOSE cur_carriage;
END //

DELIMITER ;

-- 调用存储过程生成所有座位
CALL gen_seat();

-- 删除存储过程（用完即弃）
DROP PROCEDURE IF EXISTS gen_seat;
