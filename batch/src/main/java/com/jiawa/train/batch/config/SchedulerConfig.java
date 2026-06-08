package com.jiawa.train.batch.config;

import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;

import javax.sql.DataSource;
import java.io.IOException;

@Configuration
public class SchedulerConfig {

    @Resource
    private MyJobFactory myJobFactory;
// 当存在多个数据源 Bean 时，明确指定注入名为 "dataSource" 的数据源 Bean，dataSource为配置文件中定义的数据源 Bean 的名称，数据源的名称 "dataSource" 是由 Spring Boot 自动配置机制生成的，而不是手动命名的
    @Bean
    public SchedulerFactoryBean schedulerFactoryBean(@Qualifier("dataSource") DataSource dataSource) throws IOException {
        SchedulerFactoryBean factory = new SchedulerFactoryBean();
        factory.setDataSource(dataSource); // 设置 Quartz 使用的数据源，确保 Quartz 的作业和触发器信息能够持久化到数据库中
        factory.setJobFactory(myJobFactory); // 设置自定义的 JobFactory，使 Quartz 创建的 Job 实例能够被 Spring 管理，从而支持依赖注入
        factory.setStartupDelay(2); // 设置调度器启动延迟时间2 秒，确保 Spring 容器完全初始化后再开始执行任务
        return factory;
    }
}
/*
* Quartz 调度器的配置类
* 如果想手动命名，可以
* @Bean(name = "dataSourceone")  // 自定义名称
    public DataSource dataSourceone() {
        return DataSourceBuilder.create()
            .url("jdbc:mysql://localhost:3306/train_batch")
            .username("train_batch")
            .password("Batch123")
            .driverClassName("com.mysql.cj.jdbc.Driver")
            .build();
    }
 就可以@Qualifier("dataSourceone") DataSource dataSource了
 *
 * 后续调用 SchedulerFactoryBean 的地方，直接注入 SchedulerFactoryBean 就可以了，Spring 会自动注入配置好的 SchedulerFactoryBean 实例。
 * @Autowired
    private SchedulerFactoryBean schedulerFactoryBean;
* */