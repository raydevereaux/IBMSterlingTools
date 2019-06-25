package com.bc;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@SpringBootApplication
public class IbmSterlingToolsApplication extends SpringBootServletInitializer {

    // 13.36.00 comment 05/07/2019
    // 09.20.00 comment 06.25.2019
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
         return application.sources(IbmSterlingToolsApplication.class);
    }
    
	public static void main(String[] args) {
				SpringApplication.run(IbmSterlingToolsApplication.class, args);
	}
} 
