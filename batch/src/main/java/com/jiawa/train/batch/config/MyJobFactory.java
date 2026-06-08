package com.jiawa.train.batch.config;

import jakarta.annotation.Resource;
import org.quartz.spi.TriggerFiredBundle;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.scheduling.quartz.SpringBeanJobFactory;
import org.springframework.stereotype.Component;

@Component
public class MyJobFactory extends SpringBeanJobFactory {

    @Resource
    private AutowireCapableBeanFactory beanFactory;

    /**
     * 这里覆盖了super的createJobInstance方法，对其创建出来的类再进行autowire。
     */
    @Override
    protected Object createJobInstance(TriggerFiredBundle bundle) throws Exception {
        Object jobInstance = super.createJobInstance(bundle);
        beanFactory.autowireBean(jobInstance); // 将 Quartz 创建的 Job 实例交给 Spring 进行依赖注入
        return jobInstance;
    }
}

/** Quartz 框架默认 由自己创建 Job 实例 ，而不是由 Spring 容器管理。这就导致了一个问题：
*   @Resource
*   BusinessFeign businessFeign; 会无法注入，导致空指针异常。
* 解决方案：
*   super.createJobInstance(bundle) - Quartz 创建 Job 实例（默认方式
*   beanFactory.autowireBean(jobInstance) - 将该实例交给 Spring 进行依赖注入
*
* 生效
*   在SchedulerConfig.java中
* @Bean
    public SchedulerFactoryBean schedulerFactoryBean(DataSource dataSource) {
        SchedulerFactoryBean factory = new SchedulerFactoryBean();
        factory.setDataSource(dataSource);
        factory.setJobFactory(myJobFactory);  // 设置自定义的 JobFactory
        return factory;
    }
* */
