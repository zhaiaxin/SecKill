package org.seckill.exception;

/**
 * 秒杀关闭异常
 *
 * @author zhaiaxin
 * @time 2018/6/28 14:27
 */
public class SeckillCloseException extends SeckillException {

    public SeckillCloseException(String message) {
        super(message);
    }

    public SeckillCloseException(String message, Throwable cause) {
        super(message, cause);
    }

}
