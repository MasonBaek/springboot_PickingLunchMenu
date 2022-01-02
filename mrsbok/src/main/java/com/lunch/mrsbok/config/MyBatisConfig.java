package com.lunch.mrsbok.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import javax.sql.DataSource;

@Configuration
// 패키지명
@PropertySource("classpath:/application.properties")
public class MyBatisConfig {

  @Autowired
  ApplicationContext applicationContext;

  @Value("${mybatis.mapper-locations}")
  String mPath;

  @Bean
  @ConfigurationProperties(prefix = "spring.datasource.hikari")
  public HikariConfig hikariConfig() {
    return new HikariConfig();
  }

  @Bean
  public DataSource DataSource() {
    return new HikariDataSource(hikariConfig());
  }

  @Bean
  public SqlSessionFactory SqlSessionFactory(DataSource DataSource) throws Exception {
    SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
    bean.setDataSource(DataSource);
    bean.setMapperLocations(applicationContext.getResources(mPath));
    bean.setTypeAliasesPackage("com.lunch.mrsbok.domain");
    return bean.getObject();
  }

  @Bean
  public SqlSessionTemplate SqlSessionTemplate(SqlSessionFactory sqlSessionFactory) {
    return new SqlSessionTemplate(sqlSessionFactory);
  }

}
