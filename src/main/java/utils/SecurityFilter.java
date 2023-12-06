package utils;

import user.model.UserDetails;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/auth/*"})
public class SecurityFilter extends HttpFilter implements Filter {
    private static final String ACCESS_DENIED_PATH = "./public/public-access-denied.jsp";

    public SecurityFilter() {
        super();
    }

    @Override
    public void destroy() {
        super.destroy();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        String path = req.getRequestURI();
        HttpSession session = req.getSession(false); // Obtenha a sessão atual sem criar uma nova

        if (session != null) {
            UserDetails userDetails = (UserDetails) session.getAttribute("usuarioLogado");

            Authorization authorization = new Authorization();

            boolean authorized = authorization.hasAuthorization(userDetails, path);
            if (authorized) {
                chain.doFilter(request, response);
            } else {
                String pth = req.getContextPath() + ACCESS_DENIED_PATH;
                HttpServletResponse resp = (HttpServletResponse) response;
                resp.sendRedirect(pth);
            }
        } else {
            String loginPath = req.getContextPath() + "/login.jsp";
            HttpServletResponse resp = (HttpServletResponse) response;
            resp.sendRedirect(loginPath);

        }
    }


    public void init(FilterConfig fConfig) {
    }
}
