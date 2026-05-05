package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.security.MessageDigest;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {


    public String aplicarSHA256(String base) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(base.getBytes("UTF-8"));
            StringBuilder hex = new StringBuilder();
            for (byte b : hash) {
                String h = Integer.toHexString(0xff & b);
                if(h.length() == 1) hex.append('0');
                hex.append(h);
            }
            return hex.toString();
        } catch (Exception e) { return null; }
    }

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write('\n');
      out.write('\n');
      out.write('\n');

    String errorMsg = "";
    // 2. LÓGICA DE LOGIN Y REDIRECCIÓN
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String user = request.getParameter("usuario");
        String pass = request.getParameter("password");
        String passCifrada = aplicarSHA256(pass);

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/edu_ia_db", "root", "");
            
            // Buscamos al usuario en la tabla 'usuarios'
            PreparedStatement ps = con.prepareStatement("SELECT * FROM usuarios WHERE usuario=? AND password=?");
            ps.setString(1, user);
            ps.setString(2, passCifrada);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // SI LAS CREDENCIALES SON CORRECTAS:
                session.setAttribute("usuario", user); // Guardamos la sesión
                response.sendRedirect("principal.jsp"); // <--- AQUÍ ESTÁ LA REDIRECCIÓN
                return; 
            } else {
                errorMsg = "Usuario o contraseña incorrectos.";
            }
            con.close();
        } catch (Exception e) {
            errorMsg = "Error de conexión: " + e.getMessage();
        }
    }

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <title>Acceso | Plataforma ASI</title>\n");
      out.write("    <style>\n");
      out.write("        body { font-family: 'Segoe UI', sans-serif; background: #f1f5f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }\n");
      out.write("        .login-card { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); width: 350px; }\n");
      out.write("        h2 { text-align: center; color: #1e293b; margin-top: 0; }\n");
      out.write("        .field { width: 100%; padding: 12px; margin: 10px 0; border: 1px solid #cbd5e1; border-radius: 6px; box-sizing: border-box; }\n");
      out.write("        .btn { width: 100%; padding: 12px; background: #2563eb; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; }\n");
      out.write("        .error { color: #dc2626; background: #fee2e2; padding: 10px; border-radius: 4px; text-align: center; font-size: 0.9em; margin-bottom: 15px; }\n");
      out.write("    </style>\n");
      out.write("</head>\n");
      out.write("<body>\n");
      out.write("\n");
      out.write("    <div class=\"login-card\">\n");
      out.write("        <h2>Iniciar Sesión</h2>\n");
      out.write("        \n");
      out.write("        ");
 if(!errorMsg.isEmpty()){ 
      out.write("\n");
      out.write("            <div class=\"error\">");
      out.print( errorMsg );
      out.write("</div>\n");
      out.write("        ");
 } 
      out.write("\n");
      out.write("\n");
      out.write("        <form method=\"POST\">\n");
      out.write("            <label>Usuario:</label>\n");
      out.write("            <input type=\"text\" name=\"usuario\" class=\"field\" required>\n");
      out.write("            \n");
      out.write("            <label>Contraseña:</label>\n");
      out.write("            <input type=\"password\" name=\"password\" class=\"field\" required>\n");
      out.write("            \n");
      out.write("            <button type=\"submit\" class=\"btn\">Entrar al Sistema</button>\n");
      out.write("        </form>\n");
      out.write("        \n");
      out.write("        <p style=\"text-align: center; font-size: 0.8em; color: #64748b; margin-top: 20px;\">\n");
      out.write("            Seguridad ASI - Cifrado SHA-256 Activo\n");
      out.write("        </p>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
