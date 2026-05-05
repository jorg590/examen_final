<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.MessageDigest"%>

<%-- 1. DECLARACIÓN DE MÉTODOS DE SEGURIDAD --%>
<%!
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
%>

<%
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
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Acceso | Plataforma ASI</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #f1f5f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-card { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); width: 350px; }
        h2 { text-align: center; color: #1e293b; margin-top: 0; }
        .field { width: 100%; padding: 12px; margin: 10px 0; border: 1px solid #cbd5e1; border-radius: 6px; box-sizing: border-box; }
        .btn { width: 100%; padding: 12px; background: #2563eb; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; }
        .error { color: #dc2626; background: #fee2e2; padding: 10px; border-radius: 4px; text-align: center; font-size: 0.9em; margin-bottom: 15px; }
    </style>
</head>
<body>

    <div class="login-card">
        <h2>Iniciar Sesión</h2>
        
        <% if(!errorMsg.isEmpty()){ %>
            <div class="error"><%= errorMsg %></div>
        <% } %>

        <form method="POST">
            <label>Usuario:</label>
            <input type="text" name="usuario" class="field" required>
            
            <label>Contraseña:</label>
            <input type="password" name="password" class="field" required>
            
            <button type="submit" class="btn">Entrar al Sistema</button>
        </form>
        
        <p style="text-align: center; font-size: 0.8em; color: #64748b; margin-top: 20px;">
            Seguridad ASI - Cifrado SHA-256 Activo
        </p>
    </div>

</body>
</html>