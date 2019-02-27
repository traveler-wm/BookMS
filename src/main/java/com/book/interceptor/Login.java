package com.book.interceptor;

import com.book.domain.Admin;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Login implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
        System.out.println("AuthorizationInterceptor preHandle--> ");                //flag变量用于判断用户是否登录，默认为false
        //   boolean flag = false;        //获取请求的路径进行判断
        String urlString = request.getRequestURI();

        //  String servletPath = request.getServletPath();        //判断请求是否需要拦截
        if (urlString.endsWith("/") || urlString.endsWith("/login.html") || urlString.endsWith("/api/loginCheck")) {
            return true;
        }
        //拦截请求
        //1.获取session中的用户
        Admin user = (Admin) request.getSession().getAttribute("admin");
        // 2.判断用户是否已经登录
        if (user != null) {                //如果用户没有登录，则设置提示信息，跳转到登录页面
            System.out.println("AuthorizationInterceptor请求放行：");
            return true;

        }
        //如果用户已经登录，则验证通过，放行
        System.out.println("AuthorizationInterceptor拦截请求：");
        request.getSession().setAttribute("message", "请先登录后再访问网站!");
        response.sendRedirect("/login.html");
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object
            o, ModelAndView modelAndView) throws Exception {
        System.out.println("AuthorizationInterceptor postHandle--> ");
    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse
            httpServletResponse, Object o, Exception e) throws Exception {
        System.out.println("AuthorizationInterceptor afterCompletion--> ");
    }
}
