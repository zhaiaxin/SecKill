package org.seckill.exception;

/**
 * 秒杀相关业务异常
 *
 * @author zhaiaxin
 * @time 2018/6/28 14:27
 */
public class SeckillException extends RuntimeException {

    public SeckillException(String message) {
        super(message);
    }

    public SeckillException(String message, Throwable cause) {
        super(message, cause);
    }

}
