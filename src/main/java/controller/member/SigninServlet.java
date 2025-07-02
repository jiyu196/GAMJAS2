package controller.member;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import domain.Member;
import domain.dto.Criteria;
import service.MemberService;
import util.ParamUtil;


@WebServlet("/member/signin")
public class SigninServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/WEB-INF/views/member/signin.jsp").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		String id = req.getParameter("id");
//		String pw = req.getParameter("pw");
		
		Member member = ParamUtil.get(req, Member.class);
		boolean ret = new MemberService().signin(member.getId(), member.getPw());

		if(ret) {
			HttpSession session = req.getSession();
			session.setMaxInactiveInterval(60 * 10);
			session.setAttribute("member", new MemberService().findById(member.getId()));
			
			String url = req.getParameter("url");
			if(url == null) {//로그인 성공
					resp.sendRedirect(req.getContextPath() + "/index");
				}
				else {
					String decodeUrl = URLDecoder.decode(url, "utf-8");
					Criteria cri = Criteria.init(req);
					
					resp.sendRedirect(decodeUrl + "?" + cri.getQs2()); 
				}
			}else {
				resp.sendRedirect("login fail");
			}	
		}
	}
