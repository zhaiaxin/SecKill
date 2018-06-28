package org.seckill.dao;

import org.junit.Test;

import javax.annotation.Resource;

import org.junit.Test;
import org.seckill.BaseTest;
import org.seckill.entity.SuccessKilled;

/**
 * 成功秒杀单元测试
 *
 * @author zhaiaxin
 * @time 2018/6/28 12:17
 */
public class SuccessKilledDaoTest extends BaseTest{

    @Resource
    private SuccessKilledDao successKilledDao;

    @Test
    public void testInsertSuccessKilled() throws Exception {
        /**
         * 第一次:insertCount=1
         * 第二次:insertCount=0
         */
        long id = 1001;
        long phone = 13631231234L;
        int insertCount = successKilledDao.insertSuccessKilled(id, phone);
        System.out.println("insertCount=" + insertCount);
    }

    @Test
    public void testQueryByIdWithSeckill() throws Exception {
        long id = 1001;
        long phone = 13631231234L;
        SuccessKilled successKilled = successKilledDao.queryByIdWithSeckill(id, phone);
        System.out.println(successKilled);
        System.out.println(successKilled.getSeckill());
    }

}