--连接mysql
mysql -hlocalhost -uroot -proot
--使用seckill数据库
use seckill
-- 秒杀执行存储过程
DELIMITER $$ -- console ; 转换为 $$
-- 定义存储过程
-- 参数：in 输入参数; out 输出参数
-- row_count():返回上一条修改类型sql(delete,insert,upodate)的影响行数
-- row_count: 0:未修改数据; >0:表示修改的行数; <0:sql错误/未执行修改sql

CREATE PROCEDURE `seckill`.`execute_seckill`
(IN v_seckill_id bigint, IN v_phone BIGINT,
IN v_kill_time TIMESTAMP, OUT r_result INT)
	BEGIN
		DECLARE insert_count INT DEFAULT 0;
		START TRANSACTION;
		INSERT ignore INTO success_killed
		(seckill_id, user_phone, create_time, state)
		VALUES(v_seckill_id, v_phone, v_kill_time, 1);

		SELECT ROW_COUNT() INTO insert_count;

		IF (insert_count = 0) THEN
			ROLLBACK;
			/*重复秒杀*/
			SET r_result = -1;

		ELSEIF (insert_count < 0) THEN
			ROLLBACK ;
			/*系统异常*/
			SET r_result = -2;

		ELSE

			UPDATE seckill SET
			number = number - 1
			WHERE seckill_id = v_seckill_id
        AND end_time > v_kill_time
        AND start_time < v_kill_time
        AND number > 0;

			SELECT ROW_COUNT() INTO insert_count;

			IF (insert_count = 0) THEN
				ROLLBACK;
				/*秒杀结束*/
				SET r_result = 0;

			ELSEIF (insert_count < 0) THEN
				ROLLBACK;
				/*系统异常*/
				SET r_result = -2;

			ELSE
			  SET r_result = 1;
				COMMIT;
			END IF;

		END IF;

	END;
$$
-- 代表存储过程定义结束

DELIMITER ;


-- 执行存储过程
call execute_seckill(1001, 12312341234, now(), @r_result);
-- 获取结果
SELECT @r_result;

-- 存储过程
-- 1.存储过程优化：事务行级锁持有的时间
-- 2.不要过度依赖存储过程
-- 3.简单的逻辑可以应用存储过程
-- 4.QPS:一个秒杀单6000/qps

