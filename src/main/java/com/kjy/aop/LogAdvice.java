package com.kjy.aop;

import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {

	@Before( "execution(* com.kjy.service.SampleService*.*(..))")
	public void logBefore() {
		log.info("========================");
	}
	
	@Before("execution(* com.kjy.service.SampleService*.doAdd(String,String)) && args(str1,str2)")
	public void logBeforeWithParam(String str1, String str2) {
		//해당 매서드에 전달되는 파라미터가 무엇인지 기록하거나 예외 발생시 어떤 파라미터에 문제가 있는지 알수 있게 args 를 이용한 파라미터 추적
		
		log.info("str1: " + str1);
		log.info("str2: " + str2);
	}
	
	@AfterThrowing(pointcut = "execution(* com.kjy.service.SampleService*.*(..))", throwing="exception")
	public void logException(Exception exception) {
		//지정된 대상이 예외를 발생한 후에 동작하여 문제를 찾을수 있도록 도와준다
		log.info("Exception...!!!!");
		log.info("exception: " +exception);
	}
	
}
