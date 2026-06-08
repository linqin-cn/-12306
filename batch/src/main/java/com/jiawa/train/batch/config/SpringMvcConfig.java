package com.jiawa.train.batch.config;

import com.jiawa.train.common.interceptor.LogInterceptor;
import jakarta.annotation.Resource;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class SpringMvcConfig implements WebMvcConfigurer {

   @Resource
   LogInterceptor logInterceptor;

   @Override
   public void addInterceptors(InterceptorRegistry registry) {
       registry.addInterceptor(logInterceptor)
               .addPathPatterns("/**");

   }
}
//Spring MVC 的配置类，主要作用是注册拦截器，注册拦截器 registry.addInterceptor(logInterceptor)，用于打印日志流水号
//由 Spring MVC 框架自动调用的回调方法

