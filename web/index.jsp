<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.MessageDigest"%>

<%-- 1. DECLARACIÓN DE MÉTODOS DE SEGURIDAD --%>
<%!
    // MÉTODO DEL WAF: Detecta patrones maliciosos (SQLi y XSS)
    public boolean esAtaque(String input) {
        if (input == null) return false;
        String[] patrones = {
            "<script>", "</script>", "javascript:", "onload", "alert(", 
            "UNION SELECT", "OR 1=1", "DROP TABLE", "--", "INSERT INTO", 
            "WAITFOR DELAY", "xp_cmdshell"
        };
        for (String p : patrones) {
            if (input.toLowerCase().contains(p.toLowerCase())) {
                return true; // Se detectó un patrón malicioso
            }
        }
        return false;
    }

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
    String successMsg = "";
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String accion = request.getParameter("accion");
        String user = request.getParameter("usuario");
        String pass = request.getParameter("password");

        // --- FILTRO DEL WAF ACTIVO ---
        if (esAtaque(user) || esAtaque(pass)) {
            errorMsg = "¡ALERTA DE SEGURIDAD! Se detectaron caracteres no permitidos.";
            // Aquí podrías insertar una fila en una tabla 'logs_auditoria'
        } else {
            String passCifrada = aplicarSHA256(pass);

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/edu_ia_db", "root", "");

                if ("login".equals(accion)) {
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM usuarios WHERE usuario=? AND password=?");
                    ps.setString(1, user);
                    ps.setString(2, passCifrada);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        session.setAttribute("usuario", user);
                        response.sendRedirect("principal.jsp");
                        return; 
                    } else {
                        errorMsg = "Usuario o contraseña incorrectos.";
                    }
                } 
                else if ("registro".equals(accion)) {
                    PreparedStatement check = con.prepareStatement("SELECT usuario FROM usuarios WHERE usuario=?");
                    check.setString(1, user);
                    ResultSet rsCheck = check.executeQuery();
                    
                    if(rsCheck.next()){
                        errorMsg = "El nombre de usuario ya está ocupado.";
                    } else {
                        PreparedStatement psIns = con.prepareStatement("INSERT INTO usuarios (usuario, password) VALUES (?, ?)");
                        psIns.setString(1, user);
                        psIns.setString(2, passCifrada);
                        psIns.executeUpdate();
                        successMsg = "Usuario registrado con éxito. Ya puedes entrar.";
                    }
                }
                con.close();
            } catch (Exception e) {
                errorMsg = "Error: " + e.getMessage();
            }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Acceso Seguro | WAF Protegido</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background: #0f172a; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-card { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.5); width: 350px; }
        h2 { text-align: center; color: #1e293b; margin-top: 0; }
        .field { width: 100%; padding: 12px; margin: 10px 0; border: 1px solid #cbd5e1; border-radius: 6px; box-sizing: border-box; }
        .btn { width: 100%; padding: 12px; background: #2563eb; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: bold; margin-top: 10px; }
        .btn-reg { background: #64748b; }
        .error { color: #dc2626; background: #fee2e2; padding: 10px; border-radius: 4px; text-align: center; font-size: 0.9em; margin-bottom: 15px; border: 1px solid #f87171; }
        .success { color: #16a34a; background: #dcfce7; padding: 10px; border-radius: 4px; text-align: center; font-size: 0.9em; margin-bottom: 15px; }
        .waf-badge { text-align: center; font-size: 0.7em; color: #10b981; margin-top: 15px; font-weight: bold; text-transform: uppercase; letter-spacing: 1px; }
    </style>
</head>
<body>

    <div class="login-card">
        <h2>Shield ASI v2.0</h2>
        
        <% if(!errorMsg.isEmpty()){ %>
            <div class="error"><strong>AVISO:</strong> <%= errorMsg %></div>
        <% } %>

        <% if(!successMsg.isEmpty()){ %>
            <div class="success"><%= successMsg %></div>
        <% } %>

        <form method="POST">
            <label>Usuario:</label>
            <input type="text" name="usuario" class="field" placeholder="Ej: admin123" required>
            
            <label>Contraseña:</label>
            <input type="password" name="password" class="field" placeholder="••••••••" required>
            
            <button type="submit" name="accion" value="login" class="btn">Autenticar</button>
            <button type="submit" name="accion" value="registro" class="btn btn-reg">Registrar Nuevo Nodo</button>
        </form>
        
        <div class="waf-badge"> WAF Filtering Engine Active</div>
        <p style="text-align: center; font-size: 0.8em; color: #64748b; margin-top: 10px;">
            AES-SHA256 Encrypted
        </p>
    </div>

</body>
</html>