package com.semi.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.semi.dao.MatchingDao;
import com.semi.dao.MatchingDaoImpl;
import com.semi.service.MatchingService;

//매칭

@WebServlet("/matchingServlet")
public class MatchingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MatchingServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		dual(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		dual(request, response);
	}
	
	private void dual(HttpServletRequest request, 
			
			HttpServletResponse response) throws ServletException, IOException {
		/**
		 * dual method : get, post 방식으로 들어온 요청을 둘다 받는다
		 * 			   : 구분값 설정 필요 (hidden값(예: command) or url/(추가 url로 구분 문자열 예: userservlet/login의 login)) 
		 *			   : 구분값을 통해 service 로 값 전달
		 *  방식 예시
		 *	https://github.com/jaewookleeee/semi/blob/master/src/com/semi/controller/Controller.java#L44
		 *  */

		String command = request.getParameter("command");
		System.out.println("[ " + command + " ]");
		//서비스와 연결
		MatchingService matchingService = new MatchingService();
		
		if(command.equals("projectWrite")) {
			int success = matchingService.projectWrite(request, response);
			System.out.println("프로젝트 생성");
		} else if (command.equals("projectAll")) {
		  System.out.println("프로젝트 전체 보기");
		} else if (command.equals("projectRead")) {
			System.out.println("프로젝트 상세보기");
		} else if( command.equals("projectDelete")) {
			System.out.println("프로젝트 글 삭제");
		} else if( command.equals("projectUpdate")) {
			System.out.println("프로젝트 글 수정");
		}
	}
}
